function solveModelForTable(kk)

tableValues=load('tableValues.txt');

global  parCsiD;
global  parCsiB;
global  RatioCsi;

D0=1;
B0=1;
C0=1;
P0=5;

parEps = 0.0016;
parEta=0.0;
parCsiC=1.0;
parCsiP=1.0;


parCsiD=tableValues(kk,1);
parCsiB=tableValues(kk,2);
RatioCsi = parCsiD/parCsiB;

FBA_D =tableValues(kk,3);
FBA_B =tableValues(kk,4);
FBA_C =tableValues(kk,5);
FBA_P =tableValues(kk,6);

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

tspan = [0 80000];
opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t,y] = ode45(@(t,y) systemToBeSolved(t,y,parAlpha,parDelta,parGamma,parEps,parH,parEta,parCsiD,parCsiB,parCsiC,parCsiP), tspan, y0, opts);

close all
a=100;
V=1000;
fileNameSt=sprintf('simST_V_%4.3e_av_%3.2e_csiD_%4.3e_csiB_%4.3e.dat',V,a,parCsiD,parCsiB);
simST=load(fileNameSt);

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
figure(1),
plot(t,y(:,1),'k'),shg
figure(2),
plot(t,y(:,2),'k'),shg
figure(3),
plot(t,y(:,3),'k'),shg
figure(4),
plot(t,y(:,4),'k'),shg
figure(5),
plot(t,y(:,1)./y(:,2),'k'),shg



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