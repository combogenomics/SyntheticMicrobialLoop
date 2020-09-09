%% Prepare the two models for using DFBALAB
dia_DFBA = dia_integrated_Export;
% add DOM generating reactions in the diatom
dia_DFBA  = addReaction(dia_DFBA ,'EX_Pbiomass',{ 'biomass[c]', 'biomass[s]' },[-1 1], 'false', 0, 1000) ;
dia_DFBA  = changeObjective(dia_DFBA , 'EX_Pbiomass');
sol = optimizeCbModel(dia_DFBA , 'max')

%define amino acids, ch and lipids from DOM

aa = {'cpd00023[s]' ,  'cpd00132[s]' , 'cpd00041[s]'  , 'cpd00033[s]' , 'cpd00119[s]' , 'cpd00322[s]' , 'cpd00107[s]' , 'cpd00039[s]' ,  'cpd00066[s]', 'cpd00054[s]' , 'cpd00161[s]' ,  'cpd00069[s]', 'cpd00035[s]', 'cpd00156[s]'};
ch = {'cpd00027[s]' , 'cpd00108[s]' ,  'cpd00138[s]' , 'gdpfu[c]', 'udpxyl[c]', 'udprmn[c]', 'udpglcur[c]', 'udparab[c]'};
lip = {'cpd03847[s]' , 'cpd00214[s]', 'cpd01080[s]' , 'cpd15239[s]', 'tmndnc[c]'};

aa_stoichiometric = [1.035   0.3891  0.3892      1.0317  0.1208  0.447  0.7024 ,0.4485    0.4648  0.6958  0.5502  0.2608 0.4522 0.5817];
ch_stoichiometric = [1.8 .9 1.5 .2 .5 .4 .3 .2];
lip_stoichiometric = [.08 .17 .11 .18 .32];


dia_DFBA = addExchangeRxn(dia_DFBA,{'biomass[s]'},0, 1000) ;
dia_DFBA = changeObjective(dia_DFBA, 'EX_biomass[s]');
sol = optimizeCbModel(dia_DFBA, 'max')
% 
Metabolites_Exu_reaction  = {'biomass[c]', 'biomass[s]', 'DOM' }
dia_DFBA = addReaction(dia_DFBA,'DOM_reaction', Metabolites_Exu_reaction,[-1 .8 .2], 'false', 0, 100) ;
% 
% Metabolites_Exu_reaction  = {'biomass[c]', 'biomass[s]', aa{:} , ch{:}, lip{:} }
% dia_DFBA = addReaction(dia_DFBA,'DOM_reaction', Metabolites_Exu_reaction,[-1 .9 aa_stoichiometric ch_stoichiometric lip_stoichiometric ], 'false', 0, 100) ;
% 
length(aa)
length(aa_stoichiometric)

length(ch)
length(ch_stoichiometric)

length(lip)
length(lip_stoichiometric)

%Metabolites_DOM_reaction  = {'DOM', 'dia_pro[c]', 'dia_carb[c]', 'dia_lipids[c]'}

%glutamate cpd00023[s]
%palmitic acid cpd00214[s]
%glucose cpd00027
%threonine cpd00161
%aspartate
%asparagine
%serine

Metabolites_DOM_reaction  = {'DOM', 'cpd00023[s]', 'cpd00054[s]', 'cpd00161[s]', 'cpd00132[s]', 'cpd00041[s]'}

dia_DFBA = addReaction(dia_DFBA,'DOM_split1', Metabolites_DOM_reaction,[-.2 .11 .05 .05 .05 .08], 'false', 0, 100) ;

%DOM to amino acids
% Metabolites_DOM_reaction_pro  = {'dia_pro[c]', 'cpd00035[s]' , 'cpd00051[s]' , 'cpd00132[s]' , 'cpd00041[s]' , 'cpd00084[s]' , 'cpd00053[s]' ,'cpd00023[s]' , 'cpd00033[s]' , 'cpd00119[s]' , 'cpd00322[s]' , 'cpd00107[s]' , 'cpd00039[s]' , 'cpd00060[s]' , 'cpd00066[s]' , 'cpd00129[s]' , 'cpd00054[s]' , 'cpd00161[s]' , 'cpd00065[s]' , 'cpd00069[s]' , 'cpd00156[s]' }
% dia_DFBA = addReaction(dia_DFBA,'DOM_splitProtein', Metabolites_DOM_reaction_pro,[-1 1.035  0.4356  0.3891  0.3892  0.038  0.4521  0.4522  1.0317  0.1208  0.447  0.7024  0.4485  0.1499  0.4648  0.6677  0.6958  0.5502  0.0893  0.2608  0.5817], 'false', 0, 100) ;
% 

% EX_cpd00054_e	L-Serine_C3H7NO3	-3.3014738723
% EX_cpd00161_e	L-Threonine_C4H9NO3	-0.6502903082
% EX_cpd00132_e	L-Asparagine_C4H8N2O3	-1.5
% EX_cpd00041_e	L-Aspartate_C4H6NO4	-1.0357359176
% EX_cpd00023_e	L-Glutamate_C5H8NO4	-3.3
% EX_cpd00035_e	L-Alanine_C3H7NO2	-1.375
% EX_cpd00107_e	L-Leucine_C6H13NO2	-1.1916666667
% EX_cpd00039_e	L-Lysine_C6H15N2O2	-2.1666666667
% EX_cpd00033_e	Glycine_C2H5NO2	-2.125
% EX_cpd00066_e	L-Phenylalanine_C9H11NO2	-0.7297687861
% EX_cpd00069_e	L-Tyrosine_C9H11NO3	-0.5055555556
% EX_cpd00322_e	L-Isoleucine_C6H13NO2	-0.3162393162
% EX_cpd00156_e	L-Valine_C5H11NO2	-0.5274566474
% EX_cpd00119_e	L-Histidine_C6H9N3O2	-1

%aa = {'cpd00023[s]' , 'cpd00051[s]' , 'cpd00132[s]' , 'cpd00041[s]' , 'cpd00084[s]' , 'cpd00053[s]' ,'cpd00035[s]' , 'cpd00033[s]' , 'cpd00119[s]' , 'cpd00322[s]' , 'cpd00107[s]' , 'cpd00039[s]' , 'cpd00060[s]' , 'cpd00066[s]' , 'cpd00129[s]' , 'cpd00054[s]' , 'cpd00161[s]' , 'cpd00065[s]' , 'cpd00069[s]' , 'cpd00156[s]' };

%aa_stoichiometric = [1.035  0.4356  0.3891  0.3892  0.038  0.4521  0.4522  1.0317  0.1208  0.447  0.7024  0.4485  0.1499  0.4648  0.6677  0.6958  0.5502  0.0893  0.2608  0.5817]

Metabolites_DOM_reaction_pro  = {'dia_pro[c]', aa{:}}
dia_DFBA = addReaction(dia_DFBA,'DOM_splitProtein', Metabolites_DOM_reaction_pro,[-1 aa_stoichiometric], 'false', 0, 100) ;


%Create an array with all DOM-derived aa EX reactions
clearvars EX_aa_from_DOM 
for m=1:length(aa)
    
        [mat,tok] = regexp(aa(m),'^(\w+)\[', 'match', 'tokens');
        met1 = strrep(mat{:}, '[', '(e)');
        EX_aa_from_DOM(m) = strcat('EX_', met1)

end


%Sink reactions for DOM (amino acids) compounds not used by the bacterium
for m = 1:length(aa)
dia_DFBA = addExchangeRxn(dia_DFBA,{aa{m}},0, 1000) ;
end

%DOM to carbohydrates
ch_in_TAC = {'cpd00027[s]' , 'cpd00108[s]' ,  'cpd00138[s]'}
ch_stoichiometric_tac = [1.8 .9 1.5];


Metabolites_DOM_reaction  = {'dia_carb[c]', ch_in_TAC{:} }
dia_DFBA = addReaction(dia_DFBA,'DOM_splitCarb', Metabolites_DOM_reaction,[-1 ch_stoichiometric_tac], 'false', 0, 100) ;

%Create an array with all DOM-derived ch EX reactions
clearvars EX_ch_from_DOM;
for m=1:length(ch_in_TAC)
    
        [mat,tok] = regexp(ch_in_TAC(m),'^(\w+)\[', 'match', 'tokens');
        met1 = strrep(mat{:}, '[', '(e)');
        EX_ch_from_DOM(m) = strcat('EX_', met1)

end


%Sink reactions for DOM (carbohydrates) compounds not used by the bacterium
for m = 1:length(ch)
dia_DFBA = addExchangeRxn(dia_DFBA,{ch{m}},0, 1000) ;
end



%DOM to lipids
lip_in_TAC = {'cpd03847[s]' , 'cpd00214[s]', 'cpd01080[s]'};
lip_stoichiometric_tac = [.08 .17 .11 ];
Metabolites_DOM_reaction  = {'dia_lipids[c]', lip_in_TAC{:} }
dia_DFBA = addReaction(dia_DFBA,'DOM_splitLipids', Metabolites_DOM_reaction,[-1 lip_stoichiometric_tac], 'false', 0, 100) ;

%Create an array with all DOM-derived ch EX reactions
clearvars EX_lip_from_DOM;
for m=1:length(lip_in_TAC)
    
        [mat,tok] = regexp(lip_in_TAC(m),'^(\w+)\[', 'match', 'tokens');
        met1 = strrep(mat{:}, '[', '(e)');
        EX_lip_from_DOM(m) = strcat('EX_', met1)

end


%Sink reactions for DOM (lipid) compounds not used by the bacterium
for m = 1:length(lip)
dia_DFBA = addExchangeRxn(dia_DFBA,{lip{m}},0, 1000) ;
end



dia_DFBA  = changeObjective(dia_DFBA , 'EX_Pbiomass');
sol = optimizeCbModel(dia_DFBA , 'max')

dia_DFBA = changeObjective(dia_DFBA, 'EX_biomass[s]');
sol = optimizeCbModel(dia_DFBA, 'max')

dia_DFBA = changeObjective(dia_DFBA, 'DOM_splitLipids');
sol = optimizeCbModel(dia_DFBA, 'max')

dia_DFBA = changeObjective(dia_DFBA, 'DOM_splitCarb');
sol = optimizeCbModel(dia_DFBA, 'max')

dia_DFBA = changeObjective(dia_DFBA, 'DOM_splitProtein');
sol = optimizeCbModel(dia_DFBA, 'max')


tac_DFBA = tac_integrated_Export;

%% To use the models in DFBAlab

    % Add a set of CT reactions like the combined model but as boundary
    % reactions (no [s] can be generated when the model miss CTEX reactions)
    
    tac_CT_rxns_DFBA= tac_DFBA.rxns(~cellfun(@isempty, regexp(tac_DFBA.rxns,'^OEXCT_')))
    tac_DFBA_exp = tac_DFBA;
    for j = 1:length(tac_CT_rxns_DFBA)
        
       formula = printRxnFormula(tac_DFBA, tac_CT_rxns_DFBA{j});
        [mat,tok] = regexp(formula,'^(\w+)\[', 'match', 'tokens');
%        mat{:};
         newname = strcat('DFBACT_',mat{:},'(e)');
         newname = strrep(newname, '[','');
         met1 = strrep(mat{:}, '[', '[s]');
         met2 = strrep(mat{:}, '[', '[z]');
%        rxnID = findRxnIDs( tac_integrated_withEX,AllEXWithMNXCompounds_tac{j});
%        tac_integrated_withEX.rxns{rxnID}  = newname{:};
%        AllEXWithMNXCompoundsNewName{end+1} = cell2mat(newname);
%        %This is the model that will be actually exported and integrated
%        %into the truncatula one.
         tac_DFBA_exp   = addExchangeRxn(tac_DFBA_exp, met1,[-100 0]) ;

       
    end
    

    
    dia_CT_rxns_DFBA= dia_DFBA.rxns(~cellfun(@isempty, regexp(dia_DFBA.rxns,'^OEXCTD_')))
    dia_DFBA_exp = dia_DFBA;
    
    for j = 1:length(dia_CT_rxns_DFBA)
        
         formula = printRxnFormula(dia_DFBA, dia_CT_rxns_DFBA{j});
         [mat,tok] = regexp(formula,'^(\w+)\[', 'match', 'tokens');
%        mat{:};
         newname = strcat('DFBACT_',mat{:},'(e)');
         newname = strrep(newname, '[','');
         met1 = strrep(mat{:}, '[', '[s]');
         met2 = strrep(mat{:}, '[', '[z]');
%        rxnID = findRxnIDs( tac_integrated_withEX,AllEXWithMNXCompounds_tac{j});
%        tac_integrated_withEX.rxns{rxnID}  = newname{:};
%        AllEXWithMNXCompoundsNewName{end+1} = cell2mat(newname);
%        %This is the model that will be actually exported and integrated
%        %into the truncatula one.
         dia_DFBA_exp   = addExchangeRxn(dia_DFBA_exp, met1,[-100 0]) ;

       
    end
    
    dia_DFBA = dia_DFBA_exp;
    optimizeCbModel(dia_DFBA)
    % close all the original CT reactions
    
    % open all new CT_DFBA reactions
    
    


% set proper bounds in both the models.

%% Check TAC125's reconstruction main features
tac_DFBA = tac_DFBA_exp; 
tac_DFBA.rxns(findExcRxns(tac_DFBA_exp))

optimizeCbModel(dia_DFBA)
optimizeCbModel(tac_DFBA)

tac_CT_rxns_DFBA= tac_DFBA.rxns(~cellfun(@isempty, regexp(tac_DFBA.rxns,'^OEXCT_')))

AllEx_tac_DFBA = tac_DFBA.rxns(findExcRxns(tac_DFBA));
PureEX_reactions_tac_DFBA = AllEx_tac_DFBA(~cellfun(@isempty, regexp(AllEx_tac_DFBA,'EX_')));
EXMNXM_reactions_tac_DFBA = AllEx_tac_DFBA(~cellfun(@isempty, regexp(AllEx_tac_DFBA,'EX_MNXM')));

tac_DFBA= changeRxnBounds(tac_DFBA, PureEX_reactions_tac_DFBA , 0 ,'l');
optimizeCbModel(tac_DFBA)

tac_DFBA= changeRxnBounds(tac_DFBA, EXMNXM_reactions_tac_DFBA , -1000 ,'l');
sol_f = optimizeCbModel(tac_DFBA)

tac_DFBA = changeRxnBounds(tac_DFBA , 'EX_MNXM117[s]', 0, 'l');
tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_MNXM285[s]', 0, 'l');
tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_MNXM84[s]',  0, 'l');
% tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_MNXM9[s]',  0, 'l');
% tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_MNXM13[s]',  0, 'l');
% tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_MNXM207[s]',  0, 'l');
% tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_MNXM58[s]',  0, 'l');
% tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_MNXM84[s]',  0, 'l');
% tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_MNXM1[s]',  0, 'l');
% tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_MNXM111[s]',  0, 'l');
% tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_MNXM2[s]',  0, 'l');
% tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_MNXM27[s]',  0, 'l');
% tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_MNXM4(e)',  0, 'l');
% tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_MNXM43(e)',  0, 'l');
% tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_MNXM653(e)',  0, 'l');

sol_f = optimizeCbModel(tac_DFBA)


tac_DFBA = changeRxnBounds(tac_DFBA,  'OEXCT_MNXM9(e)', -1000, 'l');
sol_f = optimizeCbModel(tac_DFBA)

tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_cpd00023(e)', -1000, 'l');
FBAsolutionSchatzGlutamate = optimizeCbModel(tac_DFBA,'max')

%  tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_cpd00023(e)', -.010, 'l');
%  FBAsolutionSchatzGlutamate = optimizeCbModel(tac_DFBA,'max')
% % 
%  tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_cpd00214(e)', -10, 'l');
%  FBAsolutionSchatzGlutamate = optimizeCbModel(tac_DFBA,'max')
% % 
% tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_cpd00108(e)', -10, 'l');
% FBAsolutionSchatzGlutamate = optimizeCbModel(tac_DFBA,'max')
% % 
%  tac_DFBA = changeRxnBounds(tac_DFBA,  'EX_cpd15239(e)', 0, 'l');
%  FBAsolutionSchatzGlutamate = optimizeCbModel(tac_DFBA,'max')



EXMNXM_reactions_dia_DFBA = dia_DFBA.rxns(~cellfun(@isempty, regexp(dia_DFBA.rxns,'EX_MNXM')));
dia_No_CT_EX_rxns_DFBA = dia_DFBA.rxns(~cellfun(@isempty, regexp(dia_DFBA.rxns,'^EX_P')))
dia_DFBA = changeRxnBounds(dia_DFBA, dia_No_CT_EX_rxns_DFBA , 0 , 'l')
sol = optimizeCbModel(dia_DFBA, 'max')
dia_DFBA = changeRxnBounds(dia_DFBA, 'EX_Pphoton_e'  ,-1000, 'l')
dia_DFBA = changeRxnBounds(dia_DFBA, 'EX_Pphoton_e' , 0, 'u')
dia_DFBA = changeRxnBounds(dia_DFBA, 'EX_Phco3_e', -0.57, 'b')
dia_DFBA = changeRxnBounds(dia_DFBA, 'EX_Pno3_e', -0.535, 'b')
dia_DFBA = changeRxnBounds(dia_DFBA, 'EX_Pbiotin_e', -1, 'l')
dia_DFBA = changeRxnBounds(dia_DFBA, 'EX_Pbiotin_e', 0, 'u')
dia_DFBA = changeRxnBounds(dia_DFBA, 'EX_Pthm_e', 0, 'u')
dia_DFBA = changeRxnBounds(dia_DFBA, 'EX_Pthm_e', -1, 'l')

sol = optimizeCbModel(dia_DFBA, 'max')
dia_CT_rxns_dfba = dia_DFBA.rxns(~cellfun(@isempty, regexp(dia_DFBA.rxns,'^OEXCTD_')));

dia_DFBA = changeRxnBounds(dia_DFBA, dia_CT_rxns_dfba, -1000 , 'l')
solz =optimizeCbModel(dia_DFBA, 'max')


dia_DFBA = changeRxnBounds(dia_DFBA,  'OEXCTD_MNXM9(e)', -1000, 'l');
sol_f = optimizeCbModel(dia_DFBA)


table(dia_DFBA.rxns(findRxnIDs(dia_DFBA, dia_CT_rxns_dfba)), solz.x(findRxnIDs(dia_DFBA, dia_CT_rxns_dfba)), printRxnFormula(dia_DFBA, dia_CT_rxns_dfba), EXMNXM_reactions_dia_DFBA , printRxnFormula(dia_DFBA, EXMNXM_reactions_dia_DFBA),  solz.x(findRxnIDs(dia_DFBA, EXMNXM_reactions_dia_DFBA)))
table(tac_DFBA.rxns(findRxnIDs(tac_DFBA, tac_CT_rxns_DFBA)), FBAsolutionSchatzGlutamate.x(findRxnIDs(tac_DFBA, tac_CT_rxns_DFBA)), printRxnFormula(tac_DFBA, tac_CT_rxns_DFBA), EXMNXM_reactions_tac_DFBA , printRxnFormula(tac_DFBA, EXMNXM_reactions_tac_DFBA),  FBAsolutionSchatzGlutamate.x(findRxnIDs(tac_DFBA, EXMNXM_reactions_tac_DFBA)))

table(tac_DFBA.rxns(findRxnIDs(tac_DFBA, 'EX_cpd00023(e)')), dia_DFBA.rxns(findRxnIDs(dia_DFBA, 'DOM_splitProtein')))

dia_DFBA = changeRxnBounds(dia_DFBA, 'DOM_splitProtein', 0, 'b')
dia_DFBA = changeRxnBounds(dia_DFBA, 'DOM_splitCarb', 0, 'b')
dia_DFBA = changeRxnBounds(dia_DFBA, 'DOM_splitLipids', 0, 'b')

