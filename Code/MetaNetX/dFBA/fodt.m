function  dxdt  = fodt( t,x, sino)

%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
u = 2;
K = 0.1;
a = optimizeCbModel(sino)   
%l = x(1);
l=x(1);
m= x(2);
dxdt(1) = -l*2/(l+1) + K * a.f/a.x(end-2)
dxdt(2) = -m*2/(m+1)
 dxdt=dxdt'

end


