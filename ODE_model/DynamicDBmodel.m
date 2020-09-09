

function solveModel

global FBA_B ;
global FBA_D ;
global FBA_C ;
global FBA_P ;
global dynamicY;
global t;

global BacterialConcentration;
global DiatomConcentration;
global PhosphateConcentration;
global CarbonConcentration;
global P_in;
global InfluxC;
global parH;
D0=DiatomConcentration;
B0=BacterialConcentration;
C0=CarbonConcentration;
P0=PhosphateConcentration;

parEps=P_in;
parAlpha=parEps/(FBA_B+FBA_D)/FBA_P;
parDelta=parEps/(FBA_B+FBA_D);
parGamma=parEps/(FBA_B+FBA_D)/FBA_P/FBA_C;
parH=(FBA_B+FBA_C)/FBA_D

system_D=parEps/parDelta/(1+parH)+parAlpha/parGamma/(1+parH);
system_B=parH*parEps/parDelta/(1+parH)-parAlpha/parGamma/(1+parH);
system_C=parAlpha/parGamma;
system_P=parDelta/parAlpha;


y0=[D0 B0 C0 P0];

global SimLength;
tspan = [0 SimLength];
[t,y] = ode45(@(t,y) systemToBeSolved(t,y,parAlpha,parDelta,parGamma,parEps,parH), tspan, y0);


% %close all,
% figure,
% plot(t,y(:,1),'k', t, FBA_D*ones(size(t)),'r'),shg
% figure,
% plot(t,y(:,2),'k', t, FBA_B*ones(size(t)),'r'),shg
% figure,
% plot(t,y(:,3),'k', t, FBA_C*ones(size(t)),'r'),shg
% figure,
% plot(t,y(:,4),'k', t, FBA_P*ones(size(t)),'r'),shg

% figure,
% plot(t,log10(y(:,1)./y(:,2)),'k'),shg
% 

systemVect=[system_D system_B system_C system_P]';
FBAVect=[FBA_D FBA_B FBA_C FBA_P]';
simVect=[y(end,1) y(end,2) y(end,3) y(end,4)]';

table(systemVect, FBAVect, simVect)

%  figure
%  subplot(2,2,1);plot(t/(24), y(:,4), '-', 'LineWidth',1.5, 'Color', 'red');; title('\fontsize{8}Phosphate concentration', 'FontWeight' , 'normal');
%  subplot(2,2,2);plot(t/(24), y(:,2), '-', 'LineWidth',1.5, 'Color', 'red');; title('\fontsize{8}Bacterium biomass', 'FontWeight' , 'normal');        
%  subplot(2,2,3);plot(t/(24), y(:,1), '-', 'LineWidth',1.5, 'Color', 'red');; title('\fontsize{8}Diatom biomass', 'FontWeight' , 'normal');
%  subplot(2,2,4);plot(t/(24), y(:,3), '-', 'LineWidth',1.5, 'Color', 'red'); title('\fontsize{8}Carbon concentration', 'FontWeight' , 'normal');

N=6
C = linspecer(N);
figure

subplot(4,2,2);plot(t,y(:,4), 'o', 'MarkerSize', 6,  'color', 'r'); title('\fontsize{8}Phosphate concentration', 'FontWeight' , 'normal');ylabel('\fontsize{6}PO_43^- concentration (mmol/L)')
axis([0 t(end)/24 0  max(y(:,4))])
subplot(4,2,4);plot(t,y(:,2), 'o', 'MarkerSize', 6,  'color', C(5,:)); title('\fontsize{8} Bacterium biomass', 'FontWeight' , 'normal');ylabel('\fontsize{6}Biomass bacterium (gDW/L)');        
axis([0 t(end)/24 0  max(y(:,2))])
subplot(4,2,6);plot(t,y(:,1), 'o', 'MarkerSize', 6); title('\fontsize{8}Diatom biomass', 'FontWeight' , 'normal'); ylabel('\fontsize{6}Biomass diatom (gDW/L)'); 
axis([0 t(end)/24 0  max(y(:,1))])
subplot(4,2,8);plot(t,y(:,3), 'o', 'MarkerSize',6, 'color', C(6,:)); title('\fontsize{8}C concentration', 'FontWeight' , 'normal');ylabel('\fontsize{6}AA concentration (mmol/L'); 
axis([0 t(end)/24 0  max(y(:,3))])

hold on
subplot(4,2,[1 7]);plot(t/24, log10(y(:,1)./y(:,2)), '-','LineWidth',1.5, 'color',  C(3,:));title('Diatom-Bacteria biomass ratio', 'FontWeight' , 'normal');ylabel('\fontsize{12}log(D/B biomass ratio)')
hold on
% max_y_axis = max(max(y(:,1:4)));
axis([0 t(end)/24 min(log10(y(:,1)./y(:,2))) max(log10(y(:,1)./y(:,2)))])
 
global dynamicY;
dynamicY = y;

cd /home/marco/Data/Analisi/Pseudoalteromonas/MicrobialLoop/5_1_18_15Jan/Code/MetaNetX/dFBA

function dydt = systemToBeSolved(t,y,parAlpha,parDelta,parGamma,parEps,parH)
dydt = zeros(4,1);
dydt(1) = parAlpha*y(1)*y(4)- parDelta*y(1);
dydt(2) = parGamma*y(2)*y(4)*y(3)- parDelta*y(2);
dydt(3) = parH*parAlpha*y(4)*y(1)  -parGamma*y(2)*y(4)*y(3)- parDelta*y(3);
dydt(4) = parEps-parAlpha*y(1)*y(4)-parGamma*y(2)*y(4)*y(3) ;


%
