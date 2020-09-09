%% Master script for combining sino and truncatula models  and running dynamic simulations

fprintf('\n\n 1. Cleaning up and loading COBRATollbox\n\n');

clear all

initCobraToolbox

cd MetaNetX

fprintf('\n\n 2. Loading Diatom model (errors expected due to sbml conversion problems)\n\n');

LoadDiato

fprintf('\n\n 3. Loading TAC125 model\n\n');

LoadTac

fprintf('\n\n 4. Executing bash pipeline\n\n');

BashPipeline

fprintf('\n\n 5. Preparing dia model for integration\n\n');

PrepareDia

fprintf('\n\n 6. Preparing tac model for integration\n\n');

PrepareTac

fprintf('\n\n 7. Preparing models for their analysis with DFBAlab\n\n');

PrepareModelsForDFBA_full

fprintf('\n\n 8. First simple pipeline analysis\n\n');

cd dFBA

%main_function
main_function_DOM_fraction
%main_function_DilutionCombinations



