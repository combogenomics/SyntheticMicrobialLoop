% Uses DFBAlab to run a dynamic FBA simulation of a P. tricornutum and P. haloplanktis co-culture



                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % DFBAlab: Dynamic Flux Balance Analysis laboratory                       %
                % Process Systems Engineering Laboratory, Cambridge, MA, USA              %
                % July 2014                                                               %
                % Written by Jose A. Gomez and Kai H�ffner                                %
                %                                                                         % 
                % This code can only be used for academic purposes. When using this code  %
                % please cite:                                                            %
                %                                                                         %
                % Gomez, J.A., H�ffner, K. and Barton, P. I. (2014).                      %
                % DFBAlab: A fast and reliable MATLAB code for Dynamic Flux Balance       %
                % Analysis. BMC Bioinformatics, 15:409                                    % 
                %                                                                         %
                % COPYRIGHT (C) 2014 MASSACHUSETTS INSTITUTE OF TECHNOLOGY                %
                %                                                                         %
                % Read the LICENSE.txt file for more details.                             %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                
                close all
                global FLUXES_P_BACT
                global FLUXES_P_DIA
                global B_GROWTH_RATE;
                global D_GROWTH_RATE;
                global P_LB_BACT;
                global P_LB_DIA;
                global C_RATIO;
                global parH;

                ratiosDiatomBacteria = [];
                FixPointD = [];
                FixPointB = [];
                LogRatio = [];
                parametroH = [];
                B_GROWTH_RATE = [];
                D_GROWTH_RATE = [];
                FLUXES_P_BACT = [];
                FLUXES_P_DIA = [];
                P_LB_BACT = []
                P_LB_DIA = [];
                C_RATIO = [];
                set(0,'DefaultFigureWindowStyle','docked')
                
                SimLength = 7000   
                figure_index = 0;
                

                %% Set of parameters for deterministic and stochastic simulations
                global InfluxP;
                InfluxP = .0016:-.0003:.0016;
                global InfluxC;
                InfluxC =  0;
                global BacterialConcentration;
                BacterialConcentration = .1;
                global DiatomConcentration;
                DiatomConcentration = .1;% Hides the legend's axes (legend border and background)
                global PhosphateConcentration;
                PhosphateConcentration = 5;
                global CarbonConcentration;
                CarbonConcentration = 10;
                global DilRate_bacterium;
                global DilRate_diatom;
                global DilRate_carbon;
                global SimLength;
                global P_in;

%% Diluition rate for deterministic simulations


                DilRate_B = [1]
                DilRate_D = [1]
                DilRate_C = [1]
 

% %% Diluition rate for stochastic simulations
% % 
%                 DilRate_B = [.4 ]
%                 DilRate_D = [.1 ]
%                 DilRate_C = [ 1]

%% DOM fraction for stochastic simulations
% BIOMASS_fractions = [.8 ];
% DOM_fractions = [ .2  ];

%% DOM fraction for deterministic simulations

BIOMASS_fractions = [.9 ];
DOM_fractions = [ .1  ];
dia_DFBA = removeRxns(dia_DFBA,'DOM_reaction');
dia_DFBA = addReaction(dia_DFBA,'DOM_reaction', Metabolites_Exu_reaction,[-1 BIOMASS_fractions(1) DOM_fractions(1)], 'false', 0, 100) ;                 
%  
    for b = 1:length(DilRate_B)
                 
	DilRate_bacterium = DilRate_B(b);
    DilRate_diatom= DilRate_D(b);
    DilRate_carbon = DilRate_C(b);
             
    figure_index = figure_index +1;
    P_uptake_tac = [];
    P_uptake_dia = [];    

               for k=1:length(InfluxP)
                   
                P_in = InfluxP(k)
                clear model
                clear exID
                clear C
                clear exID_populating_tac
                INFO.nmodel = 2; % Number of models

                % Load models. These should be .mat files generated by the COBRA toolbox. 
                % When generating these files using the COBRA toolbox, a big number is used
                % as infinity. This number should be fed to the DB vector (Default bound).

                model{1} = tac_DFBA; 
                DB(1) = 1000;

                model{2} = dia_DFBA; 
                DB(2) = 1000;
                INFO.DB = DB;

                optimizeCbModel(tac_DFBA)
                optimizeCbModel(dia_DFBA)

                %% exID array
                % You can either search the reaction names by name or provide them directly
                % in the exID array.
                %%Reaction names for exchange reactions in tac125
                % RxnNames = {'EX_glc(e)', 'EX_ac(e)', 'biomass'};
                % for i = 1:length(RxnNames)
                %    [a,exID(i)] = ismember(RxnNames(i),model.rxns);
                % end

                OEXCT_reactions_tac_DFBA = tac_DFBA.rxns(~cellfun(@isempty, regexp(tac_DFBA.rxns,'^OEXCT_')));

                for j = 1:length(EX_aa_from_DOM)
                OEXCT_reactions_tac_DFBA{j+length(OEXCT_reactions_tac)} = EX_aa_from_DOM{j};
                end

                for j = 1:length(EX_ch_from_DOM)
                OEXCT_reactions_tac_DFBA{j+length(OEXCT_reactions_tac)+length(EX_aa_from_DOM)} = EX_ch_from_DOM{j};
                end

                 for j = 1:length(EX_lip_from_DOM)
                OEXCT_reactions_tac_DFBA{j+length(OEXCT_reactions_tac)+length(EX_aa_from_DOM)+length(EX_ch_from_DOM)} = EX_lip_from_DOM{j};
                end

                for i = 1:length(OEXCT_reactions_tac_DFBA)
                [a,exID_populating_tac(i)] = ismember(OEXCT_reactions_tac_DFBA(i),tac_DFBA.rxns);
                end

                tac_DFBA.rxns(exID_populating_tac)

                exID{1}=exID_populating_tac


                OEXCTD_reactions_dia_DFBA = dia_DFBA.rxns(~cellfun(@isempty, regexp(dia_DFBA.rxns,'^OEXCTD_')));

                for i = 1:length(OEXCTD_reactions_dia_DFBA)
                  [a,exID_populating_dia(i)] = ismember(OEXCTD_reactions_dia_DFBA(i),dia_DFBA.rxns);
                end

                exID{2}=exID_populating_dia;

                INFO.exID = exID;
                
                % Lower bounds and upper bounds for these reactions should be provided in
                % the RHS code. 

                % This codes solves the LPs in standard form. Bounds on exchange fluxes in 
                % the exID array can be modified directly on the first 2*n rows where n is 
                % the number of exchange fluxes. Order will be lower bound, upper bound, 
                % lower bound, upper bound in the same order as exID. 
                %
                % NOTE: All bounds on fluxes in the exID arrays are relaxed to -Inf and 
                % + Inf. These bounds need to be updated if needed in the RHS file.

                %% Cost vectors
                % Usually the first cost vector will be biomass maximization, but it can
                % be any other objective. The CPLEX objects will minimize by default. 
                % Report only nonzero elements. 
                % The structure should be:
                % C{model} = struct
                % Element C{k}(i) of C, is the cost structure i for model k. 
                % C{k}(i).sense = +1 for minimize, or -1 for maximize.
                % C{k}(i).rxns = array containing the reactions in this objective. 
                % C{k}(i).wts = array containing coefficients for reactions reported in 
                % rxns. Both arrays should have the same length. 
                % Example, if:
                % C{k}(i).rxns = [144, 832, 931];
                % C{k}(i).wts = [3, 1, -1];
                % Then the cost vector for this LP will be:
                % Cost{k}(i) = 3*v_144 + v_832 - v_931 (fluxes for model k). 
                % This cost vector will be either maximized or minimized depending on the
                % value of C{k}(i).sense.

                % In SBML files, usually production fluxes are positive and uptake fluxes
                % are negative. Keep in mind that maximizing a negative flux implies 
                % minimizing its absolute value.
                % Different models can have different number of objectives. 

                minim = 1;
                maxim = -1;

                %% TAC125 lexicographic optimization parameters

                % Maximize growth
                % find biomass reaction index 
                [a, index_biomass_tac125] = ismember('RXNbiomass',tac_DFBA.rxns);
                C{1}(1).sense = maxim;
                C{1}(1).rxns = [index_biomass_tac125];
                C{1}(1).wts = [1];

                % PO4 consumption
                [a, index_phosphate_tac125] = ismember('OEXCT_MNXM9(e)',tac_DFBA.rxns);

                C{1}(2).sense = minim;
                C{1}(2).rxns = [index_phosphate_tac125];
                C{1}(2).wts = [1];

                % Glu consumption
                [a, index_glu_tac125] = ismember('EX_cpd00023(e)',tac_DFBA.rxns);

                C{1}(3).sense = maxim;
                C{1}(3).rxns = [index_glu_tac125];
                C{1}(3).wts = [1];

                % Thr consumption
                index_thr_tac125 =[];
                [a, index_thr_tac125] = ismember('EX_cpd00161(e)',tac_DFBA.rxns);

                C{1}(4).sense = minim;
                C{1}(4).rxns = [index_thr_tac125];
                C{1}(4).wts = [1];

                % Asn consumption
                index_asn_tac125 =[];
                [a, index_asn_tac125] = ismember('EX_cpd00132(e)',tac_DFBA.rxns);

                C{1}(5).sense = minim;
                C{1}(5).rxns = [index_asn_tac125];
                C{1}(5).wts = [1];

                % Ser consumption
                index_ser_tac125 =[];
                [a, index_ser_tac125] = ismember('EX_cpd00054(e)',tac_DFBA.rxns);
                C{1}(6).sense = minim;
                C{1}(6).rxns = [index_ser_tac125];
                C{1}(6).wts = [1];

                % Asp consumption
                index_asp_tac125 =[];
                [a, index_asp_tac125] = ismember('EX_cpd00041(e)',tac_DFBA.rxns);
                C{1}(7).sense = minim;
                C{1}(7).rxns = [index_asp_tac125];
                C{1}(7).wts = [1];


                % get reaction index for each tac lip EX reaction
                index_lip_tac125 = [];
                for v = 1:length(EX_lip_from_DOM)

                [a, index_lip_tac125(v)] = ismember(EX_lip_from_DOM(v),tac_DFBA.rxns);

                end

                wts_coefficient_lip= repelem(1, length(EX_lip_from_DOM));    


                C{1}(10).sense = minim;
                C{1}(10).rxns = index_lip_tac125(2);
                C{1}(10).wts = wts_coefficient_lip(2);


                % get reaction index for each other aa EX reaction
                index_aa_tac125 = [];

                for v = 6:length(EX_aa_from_DOM)

                 [a, index_aa_tac125(v)] = ismember(EX_aa_from_DOM(v),tac_DFBA.rxns);

                end

                wts_coefficient = repelem(1, length(EX_aa_from_DOM));    
                C{1}(8).sense = minim;
                C{1}(8).rxns = index_aa_tac125(6:14);
                C{1}(8).wts = wts_coefficient;

                % get reaction index for each tac ch EX reaction
                index_ch_tac125 = [];

                for v = 1:length(EX_ch_from_DOM)

                [a, index_ch_tac125(v)] = ismember(EX_ch_from_DOM(v),tac_DFBA.rxns);

                end

                wts_coefficient_ch = repelem(1, length(EX_ch_from_DOM(1)));    


                C{1}(9).sense = minim;
                C{1}(9).rxns = index_ch_tac125(1);
                C{1}(9).wts = wts_coefficient_ch(1);





                
                %% P. tricornutum lexicographic optimization parameters
 
                % Maximize growth
                [a, index_DOM_dia] = ismember('DOM_reaction',dia_DFBA.rxns);
                C{2}(1).sense = maxim;
                C{2}(1).rxns = [index_DOM_dia];
                C{2}(1).wts = [1];

                % HCO3
                [a, index_hco3_dia] = ismember('EX_Phco3_e',dia_DFBA.rxns);
                C{2}(2).sense = maxim;
                C{2}(2).rxns = [index_hco3_dia];
                C{2}(2).wts = [1];

                % Light
                [a, index_photons_dia] = ismember('EX_Pphoton_e',dia_DFBA.rxns);
                C{2}(3).sense = maxim;
                C{2}(3).rxns = [index_photons_dia];
                C{2}(3).wts = [1];

                % % Phosphate 
                [a, index_phosphate_dia] = ismember('OEXCTD_MNXM9(e)',dia_DFBA.rxns);
                C{2}(4).sense = maxim;
                C{2}(4).rxns = [index_phosphate_dia];
                C{2}(4).wts = [1];

                %minimize glutamate release
                [a, index_DOM_prot_dia] = ismember('DOM_split1',dia_DFBA.rxns);
                C{2}(5).sense = maxim;
                C{2}(5).rxns = [index_DOM_prot_dia];
                C{2}(5).wts = [1];

                INFO.C = C;
                % Initial conditions
                % Y1 = Volume (L)
                % Y2 = Biomass tac125 (gDW/L)
                % Y3 = Biomass diatom (gDW/L)
                % Y4 = Phosphate (mmol/L)
                % Y5 = HCO3 (mmol/L)
                % Y6 = Photons (mmol/L)
                % Y7 = Glutamate through DOM reaction
                glu_conc_init = CarbonConcentration;
                other_aa_initial_conc = repelem(.00001', 19);   
                
                %overall carbon ratio for debugging
                carbon_ratio_1 = 0;
                carbon_ratio_2 = 0;
                HCO3_conc_init = 1;
                
                Photons_conc_init = 1;
                Biomass_bacterium_init = BacterialConcentration; %(gDW/L)
                Biomass_diatom_init = DiatomConcentration; %(gDW/L)
            

                Y0 = [100 Biomass_bacterium_init Biomass_diatom_init  PhosphateConcentration HCO3_conc_init Photons_conc_init glu_conc_init other_aa_initial_conc  carbon_ratio_1  carbon_ratio_2]';

              
                % Time of simulation
                tspan = [0,SimLength];

                % CPLEX Objects construction parameters
                INFO.LPsolver = 1; % CPLEX = 0, Gurobi = 1.
                                   % CPLEX works equally fine with both methods.
                                   % Gurobi seems to work better with Method = 1, and 
                                   % Mosek with Method = 0.
                INFO.tol = 1E-9; % Feasibility, optimality and convergence tolerance for Cplex (tol>=1E-9). 
                                 % It is recommended it is at least 2 orders of magnitude
                                 % tighter than the integrator tolerance. 
                                 % If problems with infeasibility messages, tighten this
                                 % tolerance.
                INFO.tolPh1 = INFO.tol; % Tolerance to determine if a solution to phaseI equals zero.
                                   % It is recommended to be the same as INFO.tol. 
                INFO.tolevt = 5*INFO.tol; % Tolerance for event detection. Has to be greater
                                   % than INFO.tol.

                % You can modify the integration tolerances here.
                % If some of the flows become negative after running the simulation once
                % you can add the 'Nonnegative' option.
                NN = 1:length(Y0);
                options = odeset('AbsTol',1E-6,'RelTol',1E-6,'Events',@evts,'Nonnegative',NN);

                % INFO: You can use the INFO struct to pass parameters. Don't use any of 
                % the names already declared or: INFO.t (carries time information), 
                % INFO.ncost, INFO.lexID, INFO.LlexID, INFO.lbct, INFO.ubct, INFO.sense,
                % INFO.b, INFO.pair. 


                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                [model,INFO, P_uptake_tac, P_uptake_dia] = ModelSetupM(model,Y0,INFO);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                if INFO.LPsolver == 0
                    [INFO] = LexicographicOpt(model,INFO);
                elseif INFO.LPsolver == 1
                    [INFO] = LexicographicOptG(model,INFO);
                else
                    display('Solver not currently supported.');
                end

                tic
                tint = 1;
                TF = [];
                YF = [];


                INFO.a=InfluxP;

                while tint<tspan(2)
                % Look at MATLAB documentation if you want to change solver.
                % ode15s is more or less accurate for stiff problems. 
                    [T,Y] = ode45(@DRHS,tspan,Y0,options, INFO);

                    TF = [TF;T];
                    YF = [YF;Y];
                    tint = T(end);
                    tspan = [tint,tspan(2)];
                    Y0 = Y(end,:);
                    if tint == tspan(2)
                        break;
                    end

                %Determine model with basis change
                    value = evts(tint,Y0,INFO);
                    [jjj,j] = min(value);
                    ct = 0;
                    k = 0;
                    while j>ct
                        k = k + 1;
                        ct = ct + size(model{k}.A,1);
                    end
                    INFO.flagbasis = k;
                    fprintf('Basis change at time %d. \n',tint);

                % Update b vector 
                [INFO] = bupdate(tint,Y0,INFO);

                % Perform lexicographic optimization
                if INFO.LPsolver == 0



                    [INFO] = LexicographicOpt(model,INFO);
                elseif INFO.LPsolver == 1
                    [INFO] = LexicographicOptG(model,INFO);
                else
                    display('Solver not currently supported.');
                end
                end

                display(toc);
                T = TF;
                Y = YF;
                % % 


    
    
%% Plots
                figure(1)
                %figure
                N=6
                C = linspecer(N);
                
                subplot(4,2,2);plot(T/24,Y(:,4), '-', 'LineWidth',1.5, 'color','r'); title('\fontsize{8}Phosphate concentration', 'FontWeight' , 'normal');ylabel('\fontsize{6}PO_43^- concentration (mmol/L)')
                axis([0 T(end)/24 0  max(Y(:,4))])
                subplot(4,2,4);plot(T/24,Y(:,2), '-', 'LineWidth',1.5, 'color', C(5,:)); title('\fontsize{8} Bacterium biomass', 'FontWeight' , 'normal');ylabel('\fontsize{6}Biomass bacterium (gDW/L)');        
                axis([0 T(end)/24 0  max(Y(:,2))])
                subplot(4,2,6);plot(T/24,Y(:,3), '-', 'LineWidth',1.5); title('\fontsize{8}Diatom biomass', 'FontWeight' , 'normal'); ylabel('\fontsize{6}Biomass diatom (gDW/L)'); 
                axis([0 T(end)/24 0  max(Y(:,3))])
                h = subplot(4,2,8);
                cla(h)
                subplot(4,2,8);plot(T/24,Y(:,7), '-', 'LineWidth',1.5, 'color', C(1,:)); title('\fontsize{8}AA concentration', 'FontWeight' , 'normal');ylabel('\fontsize{6}AA concentration (mmol/L'); 
                hold on
                plot(T/24,Y(:,8), '-', 'LineWidth',2.5, 'color', C(2,:)); title('\fontsize{8}AA concentration', 'FontWeight' , 'normal');ylabel('\fontsize{6}AA concentration (mmol/L'); 
                hold on
                plot(T/24,Y(:,9), '-','LineWidth',2.5, 'color', C(3,:)); title('\fontsize{8}AA concentration', 'FontWeight' , 'normal');ylabel('\fontsize{6}AA concentration (mmol/L'); 
                hold on
                plot(T/24,Y(:,10), '-','LineWidth',2.5, 'color', C(4,:)); title('\fontsize{8}AA concentration', 'FontWeight' , 'normal');ylabel('\fontsize{6}AA concentration (mmol/L'); 
                hold on
                plot(T/24,Y(:,11), '-','LineWidth',2.5, 'color', C(5,:)); title('\fontsize{8}AA concentration', 'FontWeight' , 'normal');ylabel('\fontsize{6}AA concentration (mmol/L'); 
                hold on
                max_y_axis = max(max(Y(:,7:11)));
                axis([0 T(end)/24 0  max_y_axis  ])
                legend('Glu', 'Thr', 'Asn', 'Ser', 'Asp')
                legend('boxoff')
                subplot(4,2,[1 7]);plot(T/24, log10(Y(:,3)./Y(:,2)), '-','LineWidth',2);xlabel('Time (days)');ylabel('\fontsize{12}log_1_0 D/B biomass ratio');        
                max_y_axis = max(log10(Y(:,3)./Y(:,2)));
                min_y_axis = min(log10(Y(:,3)./Y(:,2)));
                axis([0 T(end)/24 -2  max_y_axis])
                hold on

                %create the legend
                Legend=[];
                for i = 1:length(InfluxP)
                    Legend{i}=num2str(InfluxP(i))
                end
                
                lgd = legend(Legend);
                set(gcf,'color','w');
                legend boxoff                  

         
                B = Y(end,2);
                D = Y(end,3);
                C = Y(end, 28);
                P = Y(end,4);

                global FBA_B ;
                global FBA_D ;
                global FBA_C ;
                global FBA_P ;

                FBA_B = B;
                FBA_D = D;
                FBA_C = C;
                FBA_P = P;

               ratiosDiatomBacteria{end+1} = D/B;
               FixPointD{end+1}=D;
               FixPointB{end+1}=B;
               LogRatio{end+1} = log10(Y(:,3)./Y(:,2)); 

               %% Dynamic deterministic simulation
               cd ../../../ODE_model
               solveModel_with_p_vs_stochastic_completo
               parametroH{end+1} = parH;

               end
               
        end

        global dynamicY;
        global t;
        dynamicY;
        
        figure
        N=6
        C = linspecer(N);
        hold on
        plot(T/24, log10(Y(:,3)./Y(:,2)), '-','LineWidth',2);xlabel('Time (days)');ylabel('\fontsize{12}log_1_0 D/B biomass ratio');        
        plot(t/24, log10(dynamicY(:,1)./dynamicY(:,2)), '*','MarkerSize',5);title('Diatom-Bacteria biomass ratio', 'FontWeight' , 'normal');ylabel('\fontsize{12}log(D/B biomass ratio)')
         
