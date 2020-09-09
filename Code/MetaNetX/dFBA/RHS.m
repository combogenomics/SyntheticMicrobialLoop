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
% Y7 = Glutamate through DOM reaction
% Y8 = Penalty


function [lb,ub] = RHS( t,y,INFO )
P_tac= [];
 
global P_LB_BACT;
global P_LB_DIA;

% This subroutine updates the upper and lower bounds for the fluxes in the
% exID arrays in main. The output should be two matrices, lb and ub. The lb matrix
% contains the lower bounds for exID{i} in the ith row in the same order as
% exID. The same is true for the upper bounds in the ub matrix.
% Infinity can be used for unconstrained variables, however, it should be 
% fixed for all time. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bacterium 
 


% mg
lb(1,1) = -1000;
ub(1,1) = 1000;

% urea
lb(1,2) = 0;
ub(1,2) = 0;

% na
lb(1,3) = -1000;
ub(1,3) = 1000;

% h
lb(1,4) = -1000;
ub(1,4) = 1000;

% h2o
lb(1,5) = 0;
ub(1,5) = 1000;

% o2
lb(1,6) = -1000;
ub(1,6) = 1000;

% lactate
lb(1,7) = 0;
ub(1,7) = 1000;

% co2
lb(1,8) = 0;
ub(1,8) = 1000;

% so42-
lb(1,9) = -.01;
ub(1,9) = -.01;



% cl
lb(1,10) = -1000;
ub(1,10) = 1000;

% po43- phosphate
if (y(4)<0)
    lb(1,11) = 0;
    ub(1,11) = 0;

else
 %find correct formulation for phosphate
 lb(1,11)=(-.3*y(4)/(0.43+y(4)));
 %lb(1,11)=(-.4*y(4)/(0.43+y(4)));
 ub(1,11) = 0;

end
P_LB_BACT{end+1} = lb(1,11);

% P_tac{end+1} = lb(1,11);

% nh4+
lb(1,12) = -1000;
ub(1,12) = 1000;

% fe2+
lb(1,13) = -1000;
ub(1,13) = 1000;

% no4
lb(1,14) = -1000;
ub(1,14) = 1000;

% EX_cpd00054_e	L-Serine_C3H7NO3	-3.3014738723	8
% EX_cpd00161_e	L-Threonine_C4H9NO3	-0.6502903082	8
% EX_cpd00132_e	L-Asparagine_C4H8N2O3	-1.5	3.5
% EX_cpd00041_e	L-Aspartate_C4H6NO4	-1.0357359176	.5
% EX_cpd00023_e	L-Glutamate_C5H8NO4	-3.3	.5
% EX_cpd00035_e	L-Alanine_C3H7NO2	-1.375	9.2
% EX_cpd00107_e	L-Leucine_C6H13NO2	-1.1916666667	1.07
% EX_cpd00039_e	L-Lysine_C6H15N2O2	-2.1666666667	5
% EX_cpd00033_e	Glycine_C2H5NO2	-2.125	3.8
% EX_cpd00066_e	L-Phenylalanine_C9H11NO2	-0.7297687861	0.72
% EX_cpd00069_e	L-Tyrosine_C9H11NO3	-0.5055555556	3.9
% EX_cpd00322_e	L-Isoleucine_C6H13NO2	-0.3162393162	1.22
% EX_cpd00156_e	L-Valine_C5H11NO2	-0.5274566474	8
% EX_cpd00119_e	L-Histidine_C6H9N3O2	-1	0.5

%1,1     'OEXCT_MNXM653(e)' mg
%1,2     'OEXCT_MNXM117(e)' urea
%1,3     'OEXCT_MNXM27(e)' na
%1,4     'OEXCT_MNXM1(e)' h
%1,5     'OEXCT_MNXM2(e)' h2o
%1,6     'OEXCT_MNXM4(e)' o2
%1,7     'OEXCT_MNXM285(e)' d-lactate
%1,8     'OEXCT_MNXM13(e)' co2
%1,9     'OEXCT_MNXM58(e)'so42-
%1,10    'OEXCT_MNXM43(e)'cl-
%1,11    'OEXCT_MNXM9(e)'po43-
%1,12    'OEXCT_MNXM84(e)'nh4+
%1,13    'OEXCT_MNXM111(e)'fe2+
%1,14    'OEXCT_MNXM207(e)'no3-
%1,15    'EX_cpd00023(e)' glutamate
%1,16    'EX_cpd00132(e)' asparagine
%1,17    'EX_cpd00041(e)' aspartate
%1,18     'EX_cpd00033(e)'
%1,19     'EX_cpd00119(e)'
%1,20     'EX_cpd00322(e)'
%1,21     'EX_cpd00107(e)'
%1,22     'EX_cpd00039(e)'
%1,23     'EX_cpd00066(e)'
%1,24     'EX_cpd00054(e)' serine
%1,25     'EX_cpd00161(e)' threonine
%1,26     'EX_cpd00069(e)'
%1,27     'EX_cpd00035(e)'
%1,28     'EX_cpd00156(e)'
%1,29     'EX_cpd00027(e)'glucose
%1,30     'EX_cpd00108(e)'  galactose
%1,31     'EX_cpd00138(e)' mannose
%1,32     'EX_cpd03847(e)'
%1,33     'EX_cpd00214(e)' plamitic acid
%1,34     'EX_cpd01080(e)'

Km = [.5	3.5	.5 3.8	0.5	1.22	1.07	5	0.72	6	6	3.9	9.2	8];
Urates = [-3.3	-1.5	-1.0357359176	-2.125	-1	-0.3162393162	-1.1916666667	-2.1666666667	-0.7297687861	-3.3014738723	-0.6502903082	-0.5055555556	-1.375	-0.5274566474];

%% amino acids
counter = 0;
for m=7:20
    counter=counter + 1;
    EX_index =m+8;
    
if (y(m)<0)
     lb(1,EX_index) = 0;
else
     lb(1,EX_index) = Urates(counter)*(y(m)/Km(counter)+y(m));
     %lb(1,EX_index) = 0;

end

ub(1,EX_index) = 0;

end
%glutamate uptake rate
%lb(1,15) = Urates(1)*(y(7)/Km(1)+y(7));
%lb(1,15) = 0;

%% carbohydrates
Km_ch = [1.75 1.75 45];
Urates_ch = [-8 -8 -.27];
counter = 0;
for n=21:23
    counter = counter + 1;
    EX_index_ch =n+8;
    
if (y(n)<0)
    
     lb(1,EX_index_ch) = 0;
else
     %lb(1,EX_index_ch) = Urates_ch(counter)*(y(n)/Km_ch(counter)+y(n));
     lb(1,EX_index) = 0;

end

ub(1,EX_index_ch) = 0;

end
%glucose uptake rate
%lb(1,29) = Urates_ch(1)*y(21)/(Km_ch(1)+y(21));
%galactose uptake rate
%lb(1,30) = Urates_ch(2)*y(22)/(Km_ch(2)+y(22));

%lb(1,29) = 0;

%% lipids
Urates_lipids = [-1836 -1044 -1123.2];
Km_lipids = [163 163 163];
counter = 0;
for n=24:26
    
    counter = counter + 1;
    EX_index_lip =n+8;
    
if (y(n)<0)
     lb(1,EX_index_lip) = 0;
else
     %lb(1,EX_index_lip) = Urates_lipids(counter)*(y(n)/Km_lipids(counter)+y(n));
     lb(1,EX_index_lip) = 0;

end

ub(1,EX_index_lip) = 0;

end
%palmitic acid uptake rate
%lb(1,33) = Urates_lipids(2)*y(25)/(Km_lipids(2)+y(25));
%lb(1,33) = -.1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
%     'OEXCT_MNXM653(e)'
%     'OEXCT_MNXM117(e)'
%     'OEXCT_MNXM27(e)'
%     'OEXCT_MNXM1(e)'
%     'OEXCT_MNXM2(e)'
%     'OEXCT_MNXM4(e)'
%     'OEXCT_MNXM285(e)'
%     'OEXCT_MNXM13(e)'
%     'OEXCT_MNXM58(e)'
%     'OEXCT_MNXM43(e)'
%     'OEXCT_MNXM9(e)'
%     'OEXCT_MNXM84(e)'
%     'OEXCT_MNXM111(e)'
%     'OEXCT_MNXM207(e)'
%     'EX_cpd00023(e)'
%     'EX_cpd00132(e)'
%     'EX_cpd00041(e)'
%     'EX_cpd00033(e)'
%     'EX_cpd00119(e)'
%     'EX_cpd00322(e)'
%     'EX_cpd00107(e)'
%     'EX_cpd00039(e)'
%     'EX_cpd00066(e)'
%     'EX_cpd00054(e)'
%     'EX_cpd00161(e)'
%     'EX_cpd00069(e)'
%     'EX_cpd00035(e)'
%     'EX_cpd00156(e)'
%     'EX_cpd00027(e)'
%     'EX_cpd00108(e)'
%     'EX_cpd00138(e)'
%     'EX_cpd03847(e)'
%     'EX_cpd00214(e)'
%     'EX_cpd01080(e)'

% diatom

% co2
% % CO2
% if y(6) < 0
%     lb(2,4) = 0;
% else
%     lb(2,4) = -2.64279793224*y(6)/(0.0009+y(6));
% end
% ub(2,4) = Inf;

lb(2,1) = 0;
ub(2,1) = 0;

% no3
lb(2,2) = -1000;
ub(2,2) = 0;

% nh4+ 
lb(2,3) = -1000;
ub(2,3) = 1000;

% fe2+
lb(2,4) = -1000;
ub(2,4) = 1000;

% h+
lb(2,5) = -1000;
ub(2,5) = 1000;

% h2o
lb(2,6) = -1000;
ub(2,6) = 1000;

% o2
lb(2,7) = -1000;
ub(2,7) = 1000;

% po43- phosphate
 if (y(4)<0)
     lb(2,8) = 0;
%      lb(2,8) = -.0001;
 else
    lb(2,8) = -.1*y(4)/(4.85+y(4));
 end
 P_LB_DIA{end+1} = lb(2,8);

ub(2,8) = 0;


% na
lb(2,9) = -1000;
ub(2,9) = 1000;


% % Light
% Ke1 = 0.32;
% Ke2 = 0.03;
% L = 0.4; % meters depth of pond
% Ke = Ke1 + Ke2*(y(3)+y(2)/2);
% Io = 28*(max(sin(2*pi()*t/48)^2,sin(2*pi()*5/48)^2)-sin(2*pi()*5/48)^2)/(1-sin(2*pi()*5/48)^2);
% lb(2,5) = 0;
% ub(2,5) = Io*(1-exp(-L*Ke))/(Ke*L);


for i=10:12
   lb(2,i) = -1000;
   ub(2,i) = 1000;
end

   lb(2,13) =  0;
   ub(2,13) =  100;

   lb(2,14) =  0;
   ub(2,14) =  100;


end

