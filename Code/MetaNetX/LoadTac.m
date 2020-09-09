%% Prepare tac model 1
  
%     cd /home/marco/Data/Analisi/Pseudoalteromonas/MicrobialLoop/5_1_18/Code/MetaNetX/

    tac = readCbModel('iMF721_update.xml');
    %%%% TO BE FIXED %%%%%
    % this model differs in the symbiosis reaction (cpdSymCoF is not
    % synthesized in the integrates version of the model)
    %%%% TO BE FIXED %%%%%
    optimizeCbModel(tac)

    %get sino boundary metabolites (to be used to feed ShareMetsPipeline.sh)

    tac_boundary_mets_index = ~cellfun(@isempty, regexp(tac.mets,'[e]'));
    tac_boundary_mets = tac.mets(tac_boundary_mets_index);


    fileID = fopen('tac_boundary.mets','w');
    fprintf(fileID,'%s\n' ,tac_boundary_mets{:});
    fclose(fileID);

    fileID = fopen('tac_all.mets','w');
    fprintf(fileID,'%s\n' ,tac.mets{:});
    fclose(fileID);

    % list of mets in sinorhizobium whose names are to be changed to MNX ones


    IntegratedTac = tac;
