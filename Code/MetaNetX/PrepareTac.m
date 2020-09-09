%% Prepare tac model 


tac_integrated = tac;

PureEX_reactions_original = tac_integrated.rxns(~cellfun(@isempty, regexp(tac_integrated.rxns,'EX_')));
tac_integrated = changeRxnBounds(tac_integrated, PureEX_reactions_original, -10, 'l');
optimizeCbModel(tac_integrated)


 for j = 1:length(tac_integrated.mets)
        
      tac_integrated.mets(j) = strrep(tac_integrated.mets(j), '[c]' , '[t]')
      tac_integrated.mets(j) = strrep(tac_integrated.mets(j), '[e]' , '[z]')

 end

TacNewNames = importdata('TacNamesMapping_of_shared.NewMetNames');
TacOldNames = importdata('TacNamesMapping_of_shared.OldMetNames');

    for i = 1:length(TacOldNames)
        
        OldnameC = strcat(TacOldNames(i),'[t]');
        NewnameC = strcat(TacNewNames(i),'[t]');
        
        OldnameE = strcat(TacOldNames(i),'[e]');
        NewnameE = strcat(TacNewNames(i),'[z]');
        
        metindexC=findMetIDs(tac, OldnameC);
        metindexE=findMetIDs(tac, OldnameE);

  
     if (metindexC > 0)
          

                 tac_integrated.mets(metindexC) = NewnameC;

     end
         
     if (metindexE > 0)

         
                 tac_integrated.mets(metindexE) = NewnameE;

     end
         
         
     metindex=findMetIDs(tac_integrated, OldnameC);
    
     % _b mets do not formally exist in the mat version of the model. the
     % following if statement avoids this issue
     
     if (metindex > 0)
          
     tac_integrated.mets(metindex) = NewnameC;

     end
         
     end

    
    AllEx_tac_integrated = tac_integrated.rxns(findExcRxns(tac_integrated));

    %keep demand reactions
    PureEX_reactions_tac = AllEx_tac_integrated(~cellfun(@isempty, regexp(AllEx_tac_integrated,'EX_')));
        

    %Close all EX reactions
    tac_integrated_withEX = changeRxnBounds(tac_integrated, PureEX_reactions_tac, -10, 'l');
    tac_integrated_Export = changeRxnBounds(tac_integrated, PureEX_reactions_tac, -10, 'l');
    %Find EX reactions involving a shared met
    optimizeCbModel(tac_integrated_Export )

    NewmesForEx = {};
    for i = 1:length(TacNewNames)    
    NewNamesForEx(i) = strcat(TacNewNames(i),'[z]');

    end

    AllReactionsWithMNXCompounds = findRxnsFromMets(tac_integrated, NewNamesForEx);
    AllEXWithMNXCompounds_tac=AllReactionsWithMNXCompounds(~cellfun(@isempty, regexp(AllReactionsWithMNXCompounds,'EX_')));

    printRxnFormula(tac_integrated_withEX, AllEXWithMNXCompounds_tac);
    
   
    %change name to cross-talking EX reactions (from EX_ to EXCT_ and from cpd codes to MNX codes)
    AllEXWithMNXCompoundsNewName = [];
    for j = 1:length(AllEXWithMNXCompounds_tac)
        
       formula = printRxnFormula(tac_integrated_withEX, AllEXWithMNXCompounds_tac{j});
       [mat,tok] = regexp(formula,'^(\w+)\[', 'match', 'tokens');
       mat{:};
       newname = strcat('OEXCT_',mat{:},'(e)');
       newname = strrep(newname, '[','');
       met1 = strrep(mat{:}, '[', '[s]');
       met2 = strrep(mat{:}, '[', '[z]');
       rxnID = findRxnIDs( tac_integrated_withEX,AllEXWithMNXCompounds_tac{j});
       tac_integrated_withEX.rxns{rxnID}  = newname{:};
       AllEXWithMNXCompoundsNewName{end+1} = cell2mat(newname);
       %This is the model that will be actually exported and integrated
       %into the truncatula one.
       tac_integrated_Export = addReaction(tac_integrated_Export,newname{:},[met1, met2],[1 -1]) ;

       
    end
    
    printRxnFormula(tac_integrated_Export)
    optimizeCbModel(tac_integrated_Export)
    tac_integrated_Export.rxnsformula = printRxnFormula(tac_integrated_Export)

    OEXCT_reactions_tac = tac_integrated_withEX.rxns(~cellfun(@isempty, regexp(tac_integrated_withEX.rxns,'^OEXCT_')));
    
