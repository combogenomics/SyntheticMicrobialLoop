%% Prepare diato model 1

% load diato model

% cd /home/marco/Data/Analisi/Pseudoalteromonas/MicrobialLoop/5_1_18/Code/MetaNetX

model = readCbModel('iLB1025.xml');
%model= changeRxnBounds(model,model.rxns(findRxnIDs(model,'Biomass')),0,'l');
%model= changeRxnBounds(model,model.rxns(findRxnIDs(model,'Biomass')),99999,'u');
sol = optimizeCbModel(model);
%model= changeObjective(model, 'BiomassWithStarch')
%sol = optimizeCbModel(model);
%model= changeObjective(model, 'Biomass')

boundary_reactions = model.rxns(findExcRxns(model))
exchangers_id = ~cellfun(@isempty, regexp(boundary_reactions,'^EX'));
exchangers = boundary_reactions(exchangers_id)

exchangersRed = ~cellfun(@isempty, regexp(model.rxns,'^TE[A-Z]|Cons'));

% model = changeObjective(model, model.rxns(findRxnIDs(model,'BiomassWithStarch')))
% sol = optimizeCbModel(model)



modelwithClosedBounds = changeRxnBounds(model,exchangers,0,'b');


%reset any existing objective and set the BiomassWithStarch as objective
%modelwithClosedBounds.c(:) = 0;
modelwithClosedBounds.c(end-1) = 1;
sol = optimizeCbModel(modelwithClosedBounds);


% Get diato cellular metabolites (only those in the cytosol can serve
% as input for the sino model, right?)
diato_boundary_mets_index= ~cellfun(@isempty, regexp(model.mets,'\[e\]'));
diato_boundary_mets = model.mets(diato_boundary_mets_index);

NewMetNameDia_ok = []

for i=1:length(diato_boundary_mets)
    
        
      
      NewMetNameDia = strrep(diato_boundary_mets(i), '[', '_');
      NewMetNameDia = strrep(NewMetNameDia, ']', '');

     
      NewMetNameDia_ok{end+1} = cell2mat(NewMetNameDia);
end
    
fileID = fopen('dia_boundary.mets','w');
fprintf(fileID,'%s\n' ,NewMetNameDia_ok{:});
fclose(fileID);

fileID = fopen('dia_all.mets','w');
fprintf(fileID,'%s\n' ,model.mets{:});
fclose(fileID);


IntegratedTrunca = model;
