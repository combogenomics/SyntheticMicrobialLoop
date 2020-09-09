%% Prepare sino model 2


% EXlist = {'EX_cpd00156_e0';'EX_cpd11583_e0';'EX_cpd01242_e0';'EX_cpd00254_e0';'EX_cpd15603_e0';'EX_cpd00067_e0';'EX_cpd11576_e0';'EX_cpd00098_e0';'EX_cpd10516_e0';'EX_cpd00137_e0';'EX_cpd08023_e0';'EX_cpd00205_e0';'EX_cpd00034_e0';'EX_cpd00009_e0';'EX_cpd15606_e0';'EX_cpd00048_e0';'EX_cpd00039_e0';'EX_cpd00106_e0';'EX_cpd00264_e0';'EX_cpd00030_e0';'EX_cpd09878_e0';'EX_cpd00129_e0';'EX_cpd00080_e0';'EX_cpd00119_e0';'EX_cpd01017_e0';'EX_cpd11586_e0';'EX_cpd00060_e0';'EX_cpd00309_e0';'EX_cpd11589_e0';'EX_cpd11578_e0';'EX_cpd15302_c0';'EX_cpd00268_e0';'EX_cpd11584_e0';'EX_cpd15604_e0';'EX_cpd00105_e0';'EX_cpd00041_e0';'EX_cpd11593_e0';'EX_cpd00027_e0';'EX_cpd00001_e0';'EX_cpd00222_e0';'EX_cpd01329_e0';'EX_cpd00210_e0';'EX_cpd11587_e0';'EX_cpd00322_e0';'EX_cpd00971_e0';'EX_cpd00013_e0';'EX_cpd00224_e0';'EX_cpd00540_e0';'EX_cpd00107_e0';'EX_cpd00226_e0';'EX_cpd00036_e0';'EX_cpd03725_e0';'EX_cpd10515_e0';'EX_cpd03343_e0';'EX_cpd03048_e0';'EX_cpd00099_e0';'EX_cpd00104_e0';'EX_cpd11592_e0';'EX_cpd00012_e0';'EX_cpd11579_e0';'EX_cpd11580_e0';'EX_cpd11581_e0';'EX_cpd01012_e0';'EX_cpd01262_e0';'EX_cpd00063_e0';'EX_cpd00307_e0';'EX_cpd01914_e0';'EX_cpd00395_e0';'EX_cpd00531_e0';'EX_cpd03724_e0';'EX_cpd11596_e0';'EX_cpd11585_e0';'EX_cpd11575_e0';'EX_cpd00305_e0';'EX_cpd00209_e0';'EX_cpd11591_e0';'EX_cpd00033_e0';'EX_cpd00092_e0';'EX_cpd00064_e0';'EX_cpd00051_e0';'EX_cpd00154_e0';'EX_cpd00058_e0';'EX_cpd04097_e0';'EX_cpd00149_e0';'EX_cpd00179_e0';'EX_cpd15605_e0';'EX_cpd00073_e0';'EX_cpd00118_e0';'EX_cpd11582_e0';'EX_cpd00637_e0';'EX_cpd11588_e0';'EX_cpd01092_e0';'EX_cpd00023_e0';'EX_cpd00075_e0';'EX_cpd00011_e0';'EX_cpd00007_e0';'EX_cpd11416_c0';'EX_cpd15378_e0';'EX_cpd00147_e0';'EX_cpd00121_e0';'EX_cpd11574_e0';'EX_cpd00392_e0';'EX_cpd00366_e0';'EX_cpd00417_e0';'EX_cpd00567_e0';'EX_cpd03727_e0';'EX_cpd15137_e0';'EX_cpd00396_e0';'EX_cpd00308_e0';'EX_cpd02233_e0';'EX_cpd07061_e0';'EX_cpd00122_e0';'EX_cpd00609_e0';'EX_cpd00108_e0';'EX_cpd00117_e0';'EX_cpd00794_e0';'EX_cpd00138_e0';'EX_cpd01171_e0';'EX_cpd00550_e0';'EX_cpd00588_e0';'EX_cpd00100_e0';'EX_cpd00751_e0';'EX_cpd00164_e0';'EX_cpd00159_e0';'EX_cpd00047_e0';'EX_cpd00314_e0';'EX_cpd00079_e0';'EX_cpd02143_e0';'EX_cpd13391_e0';'EX_cpd00082_e0';'EX_cpd00029_e0';'EX_cpd03198_e0';'EX_cpd00184_e0';'EX_cpd00132_e0';'EX_cpd00320_e0';'EX_cpd02351_e0';'EX_cpd00453_e0';'EX_cpd00024_e0';'EX_cpd00094_e0';'EX_cpd02274_e0';'EX_cpd00208_e0';'EX_cpd04349_e0';'EX_cpd00076_e0';'EX_cpd00249_e0';'EX_cpd00053_e0';'EX_cpd00432_e0';'EX_cpd00089_e0';'EX_cpd00072_e0';'EX_cpd13392_e0';'EX_cpd03561_e0';'EX_cpd11603_e0';'EX_cpd00438_e0';'EX_cpd00182_e0';'EX_cpd00611_e0';'EX_cpd00141_e0';'EX_cpd01246_e0';'EX_cpd00139_e0';'EX_cpd00040_e0';'EX_cpd00158_e0';'EX_cpd00246_e0';'EX_cpd00054_e0';'EX_cpd00161_e0';'EX_cpd00035_e0';'EX_cpd00142_e0';'EX_cpd00492_e0';'EX_cpd00386_e0';'EX_cpd00130_e0';'EX_cpd00489_e0';'EX_cpd00374_e0';'EX_cpd03884_e0';'EX_cpd01067_e0';'EX_cpd00020_e0';'EX_cpd00280_e0';'EX_cpd03161_e0';'EX_cpd00162_e0';'EX_cpd11717_e0';'EX_cpd11594_e0';'EX_cpd11879_e0';'EX_cpd00155_e0';'EX_cpd11602_e0';'EX_cpd11748_e0';'EX_cpd11685_e0';'EX_cpd11601_e0';'EX_cpd00832_e0';'EX_cpd00232_e0';'EX_cpd01055_e0';'EX_cpd05240_e0';'EX_cpd00185_e0';'EX_cpd01307_e0';'EX_cpd03696_e0';'EX_cpd00750_e0';'EX_cpd05158_e0';'EX_cpd09457_e0';'EX_cpd05161_e0';'EX_cpd16821_e0';'EX_cpd01200_e0';'EX_cpd00382_e0';'EX_cpd01030_e0';'EX_cpd00212_e0';'EX_cpd01133_e0';'EX_cpd00589_e0';'EX_cpd00306_e0';'EX_cpd00281_e0';'EX_cpd00339_e0';'EX_cpd00211_e0';'EX_cpd01107_e0';'EX_cpd01113_e0';'EX_cpd01502_e0';'EX_cpd00607_e0';'EX_cpd00276_e0';'EX_cpd00599_e0';'EX_cpd00136_e0';'EX_cpd00797_e0';'EX_cpd00728_e0';'EX_cpd03737_e0';'EX_cpd00380_e0';'EX_cpd00180_e0';'EX_cpd01363_e0';'EX_cpd00248_e0';'EX_cpd05192_e0';'EX_cpd00666_e0';'EX_cpd03734_e0';'EX_cpd00477_e0';'EX_cpd00227_e0';'EX_cpd00066_e0';'EX_cpd01293_e0';'EX_cpd10719_e0';'EX_cpd00266_e0';'EX_cpd01799_e0';'EX_cpd02599_e0';'EX_cpd00157_e0';'EX_cpd01947_e0';'EX_cpd00361_e0';'EX_cpd00851_e0';'EX_cpd02175_e0';'EX_cpd00737_e0';'EX_cpd03963_e0';'EX_cpd00084_e0';'EX_cpd00065_e0';'EX_cpd00069_e0';'EX_cpd01308_e0';'EX_cpd00186_e0';'EX_cpd00549_e0';'EX_cpd03840_e0';'EX_cpd00274_e0';'EX_cpd00165_e0';'EX_cpd00187_e0';'EX_cpd00591_e0';'EX_cpd00152_e0';'EX_cpd00312_e0';'EX_cpd00378_e0';'EX_cpd01524_e0';'EX_cpd02241_e0';'EX_cpd00128_e0';'EX_cpd00367_e0';'EX_cpd00207_e0';'EX_cpd00311_e0';'EX_cpd00151_e0';'EX_cpd01217_e0';'EX_cpd00300_e0';'EX_cpd01573_e0';'EX_cpd01588_e0';'EX_cpd11590_e0';'EX_cpd00919_e0';'EX_cpd00635_e0';'EX_cpd00528_e0';'EX_cpdFixed_e0';'EX_cpd11640_e0';'EX_cpd01024_e0';'EX_cpd00197_e0'};
% dia_integrated = changeRxnBounds(sino,EXlist,0,'l');
dia_mat = load('iLB1025.mat');
dia_integrated = dia_mat;
dia_integrated = dia_integrated.pti
sol_original = optimizeCbModel(dia_mat.pti)
optimizeCbModel(dia_integrated)

PureEX_orginal = dia_mat.pti.rxns(~cellfun(@isempty, regexp(dia_mat.pti.rxns,'^EX_')));
table(dia_mat.pti.rxns(findRxnIDs(dia_mat.pti, PureEX_orginal)), sol_original.x(findRxnIDs(dia_mat.pti, PureEX_orginal)), printRxnFormula(dia_mat.pti, PureEX_orginal), dia_mat.pti.lb(findRxnIDs(dia_mat.pti, PureEX_orginal)))
original_lb =     dia_mat.pti.lb(findRxnIDs(dia_mat.pti, PureEX_orginal))
original_ub =     dia_mat.pti.ub(findRxnIDs(dia_mat.pti, PureEX_orginal))

sum(sol_original.x(findRxnIDs(dia_mat.pti, PureEX_orginal)))

 for j = 1:length(dia_integrated.mets)
        
      dia_integrated.mets(j) = strrep(dia_integrated.mets(j), '_c' , '[c]')
      dia_integrated.mets(j) = strrep(dia_integrated.mets(j), '_e' , '[e]')
      dia_integrated.mets(j) = strrep(dia_integrated.mets(j), '_x' , '[x]')
      dia_integrated.mets(j) = strrep(dia_integrated.mets(j), '_u' , '[u]')
      dia_integrated.mets(j) = strrep(dia_integrated.mets(j), '_h' , '[h]')
      dia_integrated.mets(j) = strrep(dia_integrated.mets(j), '_m' , '[m]')

       
 end
 
 for j = 1:length(dia_integrated.rxns)
        
      dia_integrated.rxns(j) = strrep(dia_integrated.rxns(j), 'EX_' , 'EX_P')
 end
Original_EX_NewName = dia_integrated.rxns(~cellfun(@isempty, regexp(dia_integrated.rxns,'^EX_P')));

optimizeCbModel(dia_mat.pti)
optimizeCbModel(dia_integrated)



    %import new and old names (files written by PrepareMetsSubstitution.pl)
    DiaNewNames = importdata('DiaNamesMapping_of_shared.NewMetNames');
    DiaOldNames = importdata('DiaNamesMapping_of_shared.OldMetNames');
    %sharedMets = importdata('MetaNetX/SinoNamesMapping_of_shared.ExListofShared_MNXcode');

    for i = 1:length(DiaOldNames)
        
        OldnameC = strcat(DiaOldNames(i),'[c]');
        NewnameC = strcat(DiaNewNames(i),'[c]');
        
        OldnameE = strcat(DiaOldNames(i),'[e]');
        NewnameE = strcat(DiaNewNames(i),'[e]');
        
        OldnameX = strcat(DiaOldNames(i),'[x]');
        NewnameX = strcat(DiaNewNames(i),'[x]');
        
        OldnameU = strcat(DiaOldNames(i),'[u]');
        NewnameU = strcat(DiaNewNames(i),'[u]');
        
        OldnameH = strcat(DiaOldNames(i),'[h]');
        NewnameH = strcat(DiaNewNames(i),'[h]');
        
        OldnameM = strcat(DiaOldNames(i),'[m]');
        NewnameM = strcat(DiaNewNames(i),'[m]');
        
        metindexC=findMetIDs(dia_integrated, OldnameC);
        metindexE=findMetIDs(dia_integrated, OldnameE);
        metindexX=findMetIDs(dia_integrated, OldnameX);
        metindexU=findMetIDs(dia_integrated, OldnameU);
        metindexH=findMetIDs(dia_integrated, OldnameH);
        metindexM=findMetIDs(dia_integrated, OldnameM);

     % _b mets do not formally exist in the mat version of the model. the
     % following if statement avoids this issue
     
     if (metindexC > 0)
          
%          if regexp(TacNewNames{i}, 'MNXM15_')
%          
%          else
                 dia_integrated.mets(metindexC) = NewnameC;

     end
         
     if (metindexE > 0)
          
%          if regexp(TacNewNames{i}, 'MNXM15_')
%          
%          else
                 dia_integrated.mets(metindexE) = NewnameE;

     end
         
     if (metindexX > 0)
          
%          if regexp(TacNewNames{i}, 'MNXM15_')
%          
%          else
                 dia_integrated.mets(metindexX) = NewnameX;

     end
         
     if (metindexU > 0)
          
%          if regexp(TacNewNames{i}, 'MNXM15_')
%          
%          else
                 dia_integrated.mets(metindexU) = NewnameU;

     end
     
     if (metindexH > 0)
          
%          if regexp(TacNewNames{i}, 'MNXM15_')
%          
%          else
                 dia_integrated.mets(metindexH) = NewnameH;

     end
     
     if (metindexM > 0)
          
%          if regexp(TacNewNames{i}, 'MNXM15_')
%          
%          else
                 dia_integrated.mets(metindexM) = NewnameM;

     end
     
        

         
     end

    optimizeCbModel(dia_integrated)


    %remove ex reactions (except demand reactions) and then add new EX
    %(EXPS) reactions for model cross-talk
    
    AllEx_dia_integrated = dia_integrated.rxns(findExcRxns(dia_integrated));

    %keep demand reactions
    PureEX_reactions_dia = AllEx_dia_integrated(~cellfun(@isempty, regexp(AllEx_dia_integrated,'EX_')));
        

    %Close all EX reactions
%     dia_integrated_withEX = changeRxnBounds(dia_integrated, PureEX_reactions_dia, -10, 'l');
%      dia_integrated_Export = changeRxnBounds(dia_integrated, PureEX_reactions_dia, -10, 'l');
%     %Find EX reactions involving a shared met
    
    dia_integrated_withEX = dia_integrated;
    NewmesForEx = {};
    for i = 1:length(DiaNewNames)    
    NewNamesForEx(i) = strcat(DiaNewNames(i),'[e]');

    end

    AllReactionsWithMNXCompounds = findRxnsFromMets(dia_integrated, NewNamesForEx);
    AllEXWithMNXCompounds_dia = AllReactionsWithMNXCompounds(~cellfun(@isempty, regexp(AllReactionsWithMNXCompounds,'EX_')));
    printRxnFormula(dia_integrated_withEX, AllEXWithMNXCompounds_dia);
    
    optimizeCbModel(dia_integrated_withEX)

    
    PureEX_before = dia_integrated.rxns(~cellfun(@isempty, regexp(dia_integrated.rxns,'^EX_')));
    sol_before = optimizeCbModel(dia_integrated)
    table(dia_integrated.rxns(findRxnIDs(dia_integrated, PureEX_before)), sol_before.x(findRxnIDs(dia_integrated, PureEX_before)), printRxnFormula(dia_integrated, PureEX_before))
    
    PureEX_before = dia_integrated_withEX.rxns(~cellfun(@isempty, regexp(dia_integrated_withEX.rxns,'^EX')));
    sol_before = optimizeCbModel(dia_integrated_withEX)
    table(dia_integrated_withEX.rxns(findRxnIDs(dia_integrated_withEX, PureEX_before)), sol_before.x(findRxnIDs(dia_integrated_withEX, PureEX_before)), printRxnFormula(dia_integrated_withEX, PureEX_before))
    
    dia_integrated_Export = dia_integrated_withEX;
    sol_before_export = optimizeCbModel(dia_integrated_Export)
    table(dia_integrated_Export.rxns(findRxnIDs(dia_integrated_Export, PureEX_before)), sol_before_export.x(findRxnIDs(dia_integrated_Export, PureEX_before)), printRxnFormula(dia_integrated_Export, PureEX_before))

       
    %change name to cross-talking EX reactions (from EX_ to EXCTD_ and from cpd codes to MNX codes)
    AllEXWithMNXCompoundsNewName = [];
    for j = 1:length(AllEXWithMNXCompounds_dia)
        
       formula = printRxnFormula(dia_integrated_withEX, AllEXWithMNXCompounds_dia{j});
       [mat,tok] = regexp(formula,'^(\w+)\[', 'match', 'tokens');
       mat{:};
       newname = strcat('OEXCTD_',mat{:},'(e)');
       newname = strrep(newname, '[','');
       met1 = strrep(mat{:}, '[', '[s]');
       met2 = strrep(mat{:}, '[', '[e]');
       rxnID = findRxnIDs( dia_integrated_withEX,AllEXWithMNXCompounds_dia{j});
       dia_integrated_withEX.rxns{rxnID}  = newname{:};
       AllEXWithMNXCompoundsNewName{end+1} = cell2mat(newname);
       %This is the model that will be actually exported and integrated
       %into the truncatula one.
       dia_integrated_Export = addReaction(dia_integrated_Export,newname{:},[met1, met2],[1 -1], '', 0 ,1000) ;
       
       %dia_integrated_withEX = addReaction(dia_integrated_withEX,newname{:},[met1, met2],[-1 1], ) ;
       
    end
    
    
    
    sol_after = optimizeCbModel(dia_integrated_Export)
    

    sol_after = optimizeCbModel(dia_integrated_Export)
    table(dia_integrated_Export.rxns(findRxnIDs(dia_integrated_Export, PureEX_before)), sol_after.x(findRxnIDs(dia_integrated_Export, PureEX_before)), printRxnFormula(dia_integrated_Export, PureEX_before))
    
    dia_integrated_Export.rxnsformula = printRxnFormula(dia_integrated_Export)

    OEXCTP_reactions_dia = dia_integrated_withEX.rxns(~cellfun(@isempty, regexp(dia_integrated_withEX.rxns,'^OEXCTD_')));
    dia_integrated_withEX.rxns(~cellfun(@isempty, regexp(dia_integrated_withEX.rxns,'EX')))
    prova = changeRxnBounds(dia_integrated_withEX, 'OEXCTD_MNXM653(e)', -0.1, 'l')
    optimizeCbModel(prova)
    
    
    
    
