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
% Initial conditions
% Y1 = Volume (L)
% Y2 = Biomass tac125 (gDW/L)
% Y3 = Biomass diatom (gDW/L)
% Y4 = Phosphate (mmol/L)
% Y5 = HCO3 (mmol/L)
% Y6 = Photons (mmol/L)
% Y7 = Glutamate through DOM reaction (S4)
% Y8 = Threonine through DOM reaction (S5)
% Y9 = Asparagine through DOM reaction (S6)
% Y10 = Serine through DOM reaction (S7)
% Y11 = Aspartate through DOM reaction (S8)

%.
%.
%.



% Y28 = Penalty


function [dy] = DRHS(t, y, INFO)
global FLUXES_P_BACT
global FLUXES_P_DIA
global B_GROWTH_RATE;
global D_GROWTH_RATE;
global C_RATIO;
global InfluxC;
global P_in;
global DilRate_bacterium;
global DilRate_carbon;
global DilRate_diatom;

FluxP_dia = [];
FluxP_bact = [];

% Assign values from states
Vol = y(1);
X(1) = y(2);
X(2) = y(3);

for i=1:length(y)-3;
   S(i) = y(3+i);
end
% Feed rates
Fin = 1;
Fout = 1;

% Biomass Feed concentrations
% Xfeed(1) = 0;
% Xfeed(2) = 0;
Xfeed(3) = .10;

% Mass transfer coefficients
KhO2 = 0.0013;
KhCO2 = 0.035;

% Mass transfer expressions
MT(1) = 0;
MT(2) = 0.6*(KhO2*0.21*1000 - S(2)); 
MT(3) = 0.58*(KhCO2*0.00035*1000 - S(3));
MT(4) = 0;
MT(5) = 0;
MT(6) = 0;

% Substrate feed concentrations
Sfeed(1) = 15.01;
Sfeed(2) = KhO2*0.21*1000;
Sfeed(3) = KhCO2*0.00035*1000;
Sfeed(4) = 0;
Sfeed(5) = 0;
Sfeed(6) = 0;
Sfeed(7) = 0;






%% Update bounds and solve for fluxes
[flux,penalty] = solveModel(t,y,INFO);

%%
% The elements of the flux matrix have the sign given to them by the
% coefficients in the Cost vector in main. 
% Example, if:
% C{k}(i).rxns = [144, 832, 931];
% C{k}(i).wts = [3, 1, -1];
% Then the cost vector for this LP will be:
% flux(k,i) = 3*v_144 + v_832 - v_931 
% The penalty is an array containing the feasibility LP problem optimal
% objective function value for each model. 

% tac125 fluxes

for i=1:10
    v(1,i) = flux(1,i);
end

%     v(1,5) = 0;
%     v(1,6) = 0;

% Algae fluxes
    v(2,1) = flux(2,1);
    v(2,2) = flux(2,2);
    v(2,3) = flux(2,3);
    v(2,4) = flux(2,4);
    v(2,5) = flux(2,5);
%   v(2,5) = flux(2,2);

%     %FluxP_dia = flux(1,4);
      FLUXES_P_BACT{end+1}= abs((v(1,3)+v(1,4)+v(1,5)+v(1,6)+v(1,7)+v(1,8))*X(1)); %asn is not considered here because it leads to an unfeasible solution
      FLUXES_P_DIA{end+1}= abs(v(2,1)*X(2))*5;
      B_GROWTH_RATE{end+1} = v(1,1);
      D_GROWTH_RATE{end+1} = v(2,1);
      C_RATIO{end+1} = -(v(2,5)*X(2)/(+ v(1,3)*X(1) + v(1,4)*X(1) + v(1,5)*X(1)+ v(1,6)*X(1)+ v(1,7)*X(1)));


%     p = 1;
%     d = 1;
%assignin('base', 'ppp', v(1,2))




%% Dynamics
%dilution parameter for slowing down the growth

dy = zeros(28,1);    % a column vector
dy(1) = Fin-Fout;    % Volume
dy(2) = flux(1,1)*y(2) - (y(2)*Fout/y(1))*DilRate_bacterium;   % Biomass bacterium
dy(3) = flux(2,1)*y(3) - (y(3)*Fout/y(1))*DilRate_diatom;   % Biomass diatom



%dy(4)=0;
dy(4) = v(1,2)*X(1) + v(2,4)*X(2) + P_in - (S(1)*Fout/y(1));
dy(5) =0;
dy(6) =0;


%% [aa]

aa = {'cpd00023[s]'  ,'cpd00132(e)'  ,  'cpd00041(e)'  , 'cpd00033(e)', 'cpd00119(e)', 'cpd00322(e)', 'cpd00107(e)', 'cpd00039(e)','cpd00066(e)','cpd00054(e)','cpd00161(e)','cpd00069(e)', 'cpd00035(e)', 'cpd00156(e)'};

aa_counter = 0;
 for l=7:20
%      aa_counter = aa_counter + 1;
%      
%      if strcmp(aa(aa_counter),'cpd00023[s]')
%      dy(l) =  + v(2,5)*X(2) + v(1,3)*X(1) - S(4)*Fout/y(1) ;
% %      elseif strcmp(aa(aa_counter),'cpd00161[s]')
% %       dy(l) =  + v(2,5)*X(2) + v(1,4)*X(1) - S(5)*Fout/y(1) ;
%      elseif strcmp(aa(aa_counter),'cpd00132[s]')
%       dy(l) =  + v(2,5)*X(2) + v(1,5)*X(1) - S(6)*Fout/y(1) ;
%      elseif strcmp(aa(aa_counter),'cpd00054[s]')
%       dy(l) =  + v(2,5)*X(2) + v(1,6)*X(1) - S(7)*Fout/y(1) ;
%      elseif strcmp(aa(aa_counter),'cpd00041[s]')
%       dy(l) =  + v(2,5)*X(2) + v(1,7)*X(1) - S(8)*Fout/y(1) ;

%      else
         
      dy(l) = 0;

 end
 

%  %%glu
dy(7) =  + v(2,5)*X(2) + v(1,3)*X(1)  - (S(4)*Fout/y(1))*DilRate_carbon + InfluxC;
%thr
dy(8) =  + v(2,5)*X(2) + v(1,4)*X(1)  - (S(5)*Fout/y(1))*DilRate_carbon + InfluxC;
% %dy(8) = 0;
% %asn
dy(9) =  + v(2,5)*X(2) + v(1,5)*X(1)  - (S(6)*Fout/y(1))*DilRate_carbon + InfluxC;
%dy(9) = 0;
% %%ser
dy(10) =  + v(2,5)*X(2) + v(1,6)*X(1)  - (S(7)*Fout/y(1))*DilRate_carbon + InfluxC;
% %dy(10) = 0;
% %%asp
dy(11) =  + v(2,5)*X(2) + v(1,7)*X(1)  - (S(8)*Fout/y(1))*DilRate_carbon + InfluxC;
% 


 
 %% [ch]
ch_stoichiometric_function = [1.8 .9 1.5];
index_ch = 0;
 for l=21:23
     index_ch  =  index_ch + 1;
     %dy(l+7) =  + v(2,5)*X(2)*.2 + v(1,9)*X(1)  - S(l+4)*Fout/y(1);
     dy(l) = 0;
 end
 %dy(21) =  + v(2,5)*X(2) + v(1,3)*X(1)  - S(18)*Fout/y(1);
 
 %% [lip]
 lip_stoichiometric_function = [.08 .17 .11 ];
 index_lip = 0;

 for l=24:26
     index_lip = index_lip + 1;
     %dy(l+7) =  + v(2,5)*X(2)*.4  + v(1,10)*X(1) - S(l+4)*Fout/y(1);
     dy(l) = 0;

 end

dy(27) = v(2,5)*X(2)/(+ v(1,3)*X(1) + v(1,4)*X(1) + v(1,5)*X(1) + v(1,6)*X(1) + v(1,7)*X(1));
% Penalty function

dy(28) =v(2,5)*X(2) - S(25)*Fout/y(1);


end