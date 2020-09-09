

function solveModel

global FBA_B ;
global FBA_D ;
global FBA_C ;
global FBA_P ;
 
D0=1;
B0=1;
C0=1;
P0=5;

parEps=0.0016;
parAlpha=parEps/(FBA_B+FBA_D)/FBA_P;
parDelta=parEps/(FBA_B+FBA_D);
parGamma=parEps/(FBA_B+FBA_D)/FBA_P/FBA_C;
parH=(FBA_B+FBA_C)/FBA_D

system_D=parEps/parDelta/(1+parH)+parAlpha/parGamma/(1+parH);
system_B=parH*parEps/parDelta/(1+parH)-parAlpha/parGamma/(1+parH);
system_C=parAlpha/parGamma;
system_P=parDelta/parAlpha;


y0=[D0 B0 C0 P0];

tspan = [0 5000];
[t,y] = ode113(@(t,y) systemToBeSolved(t,y,parAlpha,parDelta,parGamma,parEps,parH), tspan, y0);


%close all,
figure,
plot(t,y(:,1),'k', t, FBA_D*ones(size(t)),'r'),shg
figure,
plot(t,y(:,2),'k', t, FBA_B*ones(size(t)),'r'),shg
figure,
plot(t,y(:,3),'k', t, FBA_C*ones(size(t)),'r'),shg
figure,
plot(t,y(:,4),'k', t, FBA_P*ones(size(t)),'r'),shg

figure,
plot(t,log10(y(:,1)./y(:,2)),'k'),shg


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
 
global dynamicY;
dynamicY = y;

cd /home/marco/Data/Analisi/Pseudoalteromonas/MicrobialLoop/5_1_18_15Jan/Code/MetaNetX/dFBA

function dydt = systemToBeSolved(t,y,parAlpha,parDelta,parGamma,parEps,parH)
dydt = zeros(4,1);
dydt(1) = parAlpha*y(1)*y(4)- parDelta*y(1);
dydt(2) = parGamma*y(2)*y(4)*y(3)- parDelta*y(2);
dydt(3) = parH*parAlpha*y(4)*y(1) + 0.0005 -parGamma*y(2)*y(4)*y(3)- parDelta*y(3);
dydt(4) = parEps-parAlpha*y(1)*y(4)-parGamma*y(2)*y(4)*y(3) ;


%
