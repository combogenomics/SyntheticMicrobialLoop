

function solveModel

% FBA_D = 0.13828;
% FBA_B = 0.013815;
% FBA_C = 0.077656;
% FBA_P = 0.12335 ;

global FBA_B ;
global FBA_D ;
global FBA_C ;
global FBA_P ;
global P_in;
global InfluxP;
global InfluxC;
global parH;


global BacterialConcentration;
global DiatomConcentration;
global PhosphateConcentration;
global CarbonConcentration;
global DilRate;

D0=DiatomConcentration;
B0=BacterialConcentration;
C0=CarbonConcentration;
P0=PhosphateConcentration;

parEta=InfluxC;
 =P_in;
parAlpha=parEps/(FBA_B+FBA_D+FBA_P)/FBA_P;
parDelta=parEps/(FBA_B+FBA_D+FBA_P);
parGamma=parEps/(FBA_B+FBA_D+FBA_P)/FBA_P/FBA_C;
parH=(FBA_B+FBA_C)/FBA_D -parEta/parEps*(FBA_B+FBA_D+FBA_P)/FBA_D


system_D=(parEps-parEta)/parDelta/(1+parH)+parAlpha/parGamma/(1+parH)-parDelta/(1+parH)/parAlpha;
system_B=(parH*parEps+parEta)/parDelta/(1+parH)-parAlpha/parGamma/(1+parH)-parDelta*parH/(1+parH)/parAlpha;
system_C=parAlpha/parGamma;
system_P=parDelta/parAlpha;


y0=[D0 B0 C0 P0];
global t;
global SimLength;
tspan = [0 SimLength];
opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t,y] = ode45(@(t,y) systemToBeSolved(t,y,parAlpha,parDelta,parGamma,parEps,parH,parEta), tspan, y0, opts);
% 
% close all
% 
% figure(1),
% plot(t,y(:,1),'.r', t, FBA_D*ones(size(t)),'k'),shg
% figure(2),
% plot(t,y(:,2),'.r', t, FBA_B*ones(size(t)),'k'),shg
% figure(3),
% plot(t,y(:,3),'.r', t, FBA_C*ones(size(t)),'k'),shg
% figure(4),
% plot(t,y(:,4),'.r', t, FBA_P*ones(size(t)),'k'),shg

N=6
C = linspecer(N);
figure

subplot(2,4,1);plot(t,y(:,4), '-', 'LineWidth',1.5, 'color','r'); title('\fontsize{8}Phosphate concentration', 'FontWeight' , 'normal');ylabel('\fontsize{6}PO_43^- concentration (mmol/L)')
axis([0 t(end) 0  max(y(:,4))])
subplot(2,4,2);plot(t,y(:,2), '-', 'LineWidth',1.5, 'color', C(5,:)); title('\fontsize{8} Bacterium biomass', 'FontWeight' , 'normal');ylabel('\fontsize{6}Biomass bacterium (gDW/L)');        
axis([0 t(end) 0  max(y(:,2))])
subplot(2,4,3);plot(t,y(:,1), '-', 'LineWidth',1.5); title('\fontsize{8}Diatom biomass', 'FontWeight' , 'normal'); ylabel('\fontsize{6}Biomass diatom (gDW/L)'); 
axis([0 t(end) 0  max(y(:,1))])
subplot(2,4,4);plot(t,y(:,3), '-', 'LineWidth',1.5, 'color', C(1,:)); title('\fontsize{8}C concentration', 'FontWeight' , 'normal');ylabel('\fontsize{6}AA concentration (mmol/L'); 
axis([0 t(end) 0  max(y(:,3))])

hold on
subplot(2,1,2);plot(t, log10(y(:,1)./y(:,2)), '-','LineWidth',1.5, 'color',  C(3,:));title('Diatom-Bacteria biomass ratio', 'FontWeight' , 'normal');ylabel('\fontsize{12}log(D/B biomass ratio)')
hold on
max_y_axis = max(max(y(:,1:4)));
% axis([0 t 0  max_y_axis  ])

systemVect=[system_D system_B system_C system_P]';
FBAVect=[FBA_D FBA_B FBA_C FBA_P]';
simVect=[y(end,1) y(end,2) y(end,3) y(end,4)]';

 
global dynamicY;
dynamicY = y;

%write table of fixed poitns to output
T_fixed_points = table(systemVect, FBAVect, simVect)
phosphate= strrep(num2str(P_in), '.', '_')
table_file = strcat('table', phosphate);
writetable(T_fixed_points,table_file )  


function dydt = systemToBeSolved(t,y,parAlpha,parDelta,parGamma,parEps,parH,parEta)
dydt = zeros(4,1);
dydt(1) = parAlpha*y(1)*y(4)-parDelta*y(1);
dydt(2) = parGamma*y(2)*y(4)*y(3)-parDelta*y(2);
dydt(3) = parEta+parH*parAlpha*y(4)*y(1)-parGamma*y(2)*y(4)*y(3)-parDelta*y(3);
dydt(4) = parEps-parAlpha*y(1)*y(4)-parGamma*y(2)*y(4)*y(3)-parDelta*y(4);


cd /home/marco/Data/Analisi/Pseudoalteromonas/MicrobialLoop/5_1_18_15Jan/Code/MetaNetX/dFBA

