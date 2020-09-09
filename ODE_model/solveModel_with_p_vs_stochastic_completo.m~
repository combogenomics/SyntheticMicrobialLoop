function solveModel_with_p_vs_stochastic_completo(fileNameSt)


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
global DilRate_bacterium;
global b_count;
% FBA_D = 0.17109;
% FBA_B = 0.17569;
% FBA_C = 0.017109;
% FBA_P = 0.012053;



% D0=1;
% B0=1;
% C0=1;
% P0=5;

D0=DiatomConcentration;
B0=BacterialConcentration;
C0=CarbonConcentration;
P0=PhosphateConcentration;

parEta=InfluxC;
parEps=P_in;
parCsiD=1.0;
parCsiB=1.0;
parCsiC=1.0;
parCsiP=1.0;

 parAlpha=parEps*parCsiD/(parCsiB*FBA_B+parCsiD*FBA_D+parCsiP*FBA_P)/FBA_P;
 parDelta=parEps/(parCsiB*FBA_B+parCsiD*FBA_D+parCsiP*FBA_P);
 parGamma=parEps*parCsiB/(parCsiB*FBA_B+parCsiD*FBA_D+parCsiP*FBA_P)/FBA_P/FBA_C;
% parH=ceil((parCsiB*FBA_B+parCsiC*FBA_C)/(parCsiD*FBA_D) -parEta/parEps*(parCsiB*FBA_B+parCsiD*FBA_D+parCsiP*FBA_P)/(parCsiD*FBA_D))
 parH=(parCsiB*FBA_B+parCsiC*FBA_C)/(parCsiD*FBA_D) -parEta/parEps*(parCsiB*FBA_B+parCsiD*FBA_D+parCsiP*FBA_P)/(parCsiD*FBA_D)

% parEta=InfluxC;
% parEps=P_in;
% parAlpha=parEps/(FBA_B+FBA_D+FBA_P)/FBA_P;
% parDelta=parEps/(FBA_B+FBA_D+FBA_P);
% parGamma=parEps/(FBA_B+FBA_D+FBA_P)/FBA_P/FBA_C;
% parH=(FBA_B+FBA_C)/FBA_D -parEta/parEps*(FBA_B+FBA_D+FBA_P)/FBA_D

system_D=(parEps-parEta)/parDelta/(1+parH)/parCsiD+parAlpha/parGamma/(1+parH)*parCsiC*parCsiB/(parCsiD^2)-parDelta/(1+parH)/parAlpha*parCsiP;
system_B=(parH*parEps+parEta)/parDelta/(1+parH)/parCsiB-parAlpha/parGamma/(1+parH)*parCsiC/parCsiD-parDelta*parH/(1+parH)/parAlpha*parCsiP*parCsiD/parCsiB;
system_C=parAlpha/parGamma*parCsiB/parCsiD;
system_P=parDelta/parAlpha*parCsiD;


y0=[D0 B0 C0 P0];
global t;
global SimLength;
tspan = [0 SimLength];
opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t,y] = ode45(@(t,y) systemToBeSolved(t,y,parAlpha,parDelta,parGamma,parEps,parH,parEta,parCsiD,parCsiB,parCsiC,parCsiP), tspan, y0, opts);


if(nargin>0)
    simST=load(fileNameSt);
    a=str2num(fileNameSt(end-11:end-4));
    V=str2num(fileNameSt(end-24:end-16));
    steps=max(size(simST))/a;
    for i=1:a
        startIndex=(i-1)*steps+1;
        endIndex=startIndex+steps-1;
        figure(1),
        plot(simST(startIndex:endIndex,1)./V,simST(startIndex:endIndex,2)),hold on
        figure(2),
        plot(simST(startIndex:endIndex,1)./V,simST(startIndex:endIndex,3)),hold on
        figure(3),
        plot(simST(startIndex:endIndex,1)./V,simST(startIndex:endIndex,4)),hold on
        figure(4),
        plot(simST(startIndex:endIndex,1)./V,simST(startIndex:endIndex,5)),hold on
        figure(5),
        plot(simST(startIndex:endIndex,1)./V,simST(startIndex:endIndex,2)./simST(startIndex:endIndex,3)),hold on
    end
%     figure(1),
%     plot(t,y(:,1),'k'),shg
%     figure(2),
%     plot(t,y(:,2),'k'),shg
%     figure(3),
%     plot(t,y(:,3),'k'),shg
%     figure(4),
%     plot(t,y(:,4),'k'),shg
%     figure(5),
%     plot(t,y(:,1)./y(:,2),'k'),shg
else
%     figure(1),
%     plot(t,y(:,1),'.r', t, FBA_D*ones(size(t)),'k'),shg
%     figure(2),
%     plot(t,y(:,2),'.r', t, FBA_B*ones(size(t)),'k'),shg
%     figure(3),
%     plot(t,y(:,3),'.r', t, FBA_C*ones(size(t)),'k'),shg
%     figure(4),
%     plot(t,y(:,4),'.r', t, FBA_P*ones(size(t)),'k'),shg
end


systemVect=[system_D system_B system_C system_P]';
FBAVect=[FBA_D FBA_B FBA_C FBA_P]';
simVect=[y(end,1) y(end,2) y(end,3) y(end,4)]';

%%
N=6
C = linspecer(N);
figure

subplot(2,4,1);plot(t/24,y(:,4), 'o', 'MarkerSize',3, 'color','r'); title('\fontsize{8}Phosphate concentration', 'FontWeight' , 'normal');ylabel('\fontsize{6}PO_43^- concentration (mmol/L)')
axis([0 t(end)/24 0  max(y(:,4))])
subplot(2,4,2);plot(t/24,y(:,2), 'o', 'MarkerSize',3, 'color', C(5,:)); title('\fontsize{8} Bacterium biomass', 'FontWeight' , 'normal');ylabel('\fontsize{6}Biomass bacterium (gDW/L)');        
axis([0 t(end)/24 0  max(y(:,2))])
subplot(2,4,3);plot(t/24,y(:,1), 'o', 'MarkerSize',3); title('\fontsize{8}Diatom biomass', 'FontWeight' , 'normal'); ylabel('\fontsize{6}Biomass diatom (gDW/L)'); 
axis([0 t(end)/24 0  max(y(:,1))])
subplot(2,4,4);plot(t/24,y(:,3), 'o', 'MarkerSize',3, 'color', C(1,:)); title('\fontsize{8}C concentration', 'FontWeight' , 'normal');ylabel('\fontsize{6}AA concentration (mmol/L'); 
axis([0 t(end)/24 0  max(y(:,3))])

hold on
subplot(2,1,2);plot(t, log10(y(:,1)./y(:,2)), '-','LineWidth',1.5, 'color',  C(3,:));title('Diatom-Bacteria biomass ratio', 'FontWeight' , 'normal');ylabel('\fontsize{12}log(D/B biomass ratio)')
hold on
max_y_axis = max(max(y(:,1:4)));
% axis([0 t 0  max_y_axis  ])
 
global dynamicY;
dynamicY = y;
%%
T_fixed_points = table(systemVect, FBAVect, simVect)
phosphate= strrep(num2str(DilRate_bacterium), '.', '_')

table_file = strcat(num2str(b_count), 'table', phosphate);
writetable(T_fixed_points,table_file )  

%table(systemVect, FBAVect, simVect)



function dydt = systemToBeSolved(t,y,parAlpha,parDelta,parGamma,parEps,parH,parEta,parCsiD,parCsiB,parCsiC,parCsiP)
dydt = zeros(4,1);
dydt(1) = parAlpha*y(1)*y(4)-parDelta*parCsiD*y(1);
dydt(2) = parGamma*y(2)*y(4)*y(3)-parDelta*parCsiB*y(2);
dydt(3) = parEta+parH*parAlpha*y(4)*y(1)-parGamma*y(2)*y(4)*y(3)-parDelta*parCsiC*y(3);
dydt(4) = parEps-parAlpha*y(1)*y(4)-parGamma*y(2)*y(4)*y(3)-parDelta*parCsiP*y(4);
cd /home/marco/Data/Analisi/Pseudoalteromonas/MicrobialLoop/5_1_18_15Jan/Code/MetaNetX/dFBA
