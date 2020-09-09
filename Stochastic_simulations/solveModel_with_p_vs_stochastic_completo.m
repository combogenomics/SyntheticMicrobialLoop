function solveModel_with_p_vs_stochastic_completo(fileNameSt)
global ColorStochastic;
global counter;
global Stochastic_legend;
parEps=str2num(fileNameSt(end-12:end-4));
global Plots

switch parEps
    case 0.0016
        parEps = 0.0016;
        FBA_D = 0.17109;
        FBA_B = 0.17569;
        FBA_C = 0.017109;
        FBA_P = 0.012053;
    case 0.0019
        FBA_D = 0.17240;
        FBA_B = 0.21232;
        FBA_C = 0.01724;
        FBA_P = 0.01205;
    case 0.0022 
        FBA_D = 0.17355;
        FBA_B = 0.24896;
        FBA_C = 0.01735;
        FBA_P = 0.01205;   
    case 0.0025
        FBA_D = 0.17459;
        FBA_B = 0.28561;
        FBA_C = 0.01745;
        FBA_P = 0.01205;
    case 0.0028
        FBA_D = 0.17556;
        FBA_B = 0.32225;
        FBA_C = 0.01755;
        FBA_P = 0.01205;
end

D0=1;
B0=1;
C0=1;
P0=5;

parEta=0.0;
parCsiD=0.1;
parCsiB=0.5;
parCsiC=1.0;
parCsiP=1.0;

parAlpha=parEps*parCsiD/(parCsiB*FBA_B+parCsiD*FBA_D+parCsiP*FBA_P)/FBA_P;
parDelta=parEps/(parCsiB*FBA_B+parCsiD*FBA_D+parCsiP*FBA_P);
parGamma=parEps*parCsiB/(parCsiB*FBA_B+parCsiD*FBA_D+parCsiP*FBA_P)/FBA_P/FBA_C;
parH=ceil((parCsiB*FBA_B+parCsiC*FBA_C)/(parCsiD*FBA_D) -parEta/parEps*(parCsiB*FBA_B+parCsiD*FBA_D+parCsiP*FBA_P)/(parCsiD*FBA_D));
%parH=(parCsiB*FBA_B+parCsiC*FBA_C)/(parCsiD*FBA_D) -parEta/parEps*(parCsiB*FBA_B+parCsiD*FBA_D+parCsiP*FBA_P)/(parCsiD*FBA_D)

system_D=(parEps-parEta)/parDelta/(1+parH)/parCsiD+parAlpha/parGamma/(1+parH)*parCsiC*parCsiB/(parCsiD^2)-parDelta/(1+parH)/parAlpha*parCsiP;
system_B=(parH*parEps+parEta)/parDelta/(1+parH)/parCsiB-parAlpha/parGamma/(1+parH)*parCsiC/parCsiD-parDelta*parH/(1+parH)/parAlpha*parCsiP*parCsiD/parCsiB;
system_C=parAlpha/parGamma*parCsiB/parCsiD;
system_P=parDelta/parAlpha*parCsiD;


y0=[D0 B0 C0 P0];

tspan = [0 7000];
opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t,y] = ode45(@(t,y) systemToBeSolved(t,y,parAlpha,parDelta,parGamma,parEps,parH,parEta,parCsiD,parCsiB,parCsiC,parCsiP), tspan, y0, opts);

%close all


simST=load(fileNameSt);
a=str2num(fileNameSt(end-25:end-18));
V=str2num(fileNameSt(end-38:end-30));
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
    Plots{counter} = plot(simST(startIndex:endIndex,1)./V,log10(simST(startIndex:endIndex,2)./simST(startIndex:endIndex,3)), ColorStochastic{counter}, 'LineWidth', .1),
    ylabel('\fontsize{12}log_1_0 D/B biomass ratio')
    xlabel('Time steps')
    hold on


    
end
figure(1),
plot(t,y(:,1),'k'),shg
figure(2),
plot(t,y(:,2),'k'),shg
figure(3),
plot(t,y(:,3),'k'),shg
figure(4),
plot(t,y(:,4),'k'),shg
figure(5),
plot(t,log10(y(:,1)./y(:,2)),'yellow', 'LineWidth', 3),shg
hold on



systemVect=[system_D system_B system_C system_P]';
FBAVect=[FBA_D FBA_B FBA_C FBA_P]';
simVect=[y(end,1) y(end,2) y(end,3) y(end,4)]';

table(systemVect, FBAVect, simVect)



function dydt = systemToBeSolved(t,y,parAlpha,parDelta,parGamma,parEps,parH,parEta,parCsiD,parCsiB,parCsiC,parCsiP)
dydt = zeros(4,1);
dydt(1) = parAlpha*y(1)*y(4)-parDelta*parCsiD*y(1);
dydt(2) = parGamma*y(2)*y(4)*y(3)-parDelta*parCsiB*y(2);
dydt(3) = parEta+parH*parAlpha*y(4)*y(1)-parGamma*y(2)*y(4)*y(3)-parDelta*parCsiC*y(3);
dydt(4) = parEps-parAlpha*y(1)*y(4)-parGamma*y(2)*y(4)*y(3)-parDelta*parCsiP*y(4);