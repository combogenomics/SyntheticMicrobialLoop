function Ys = dYdt(t, W)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Yd = W(1);
Yb = W(2);
Yc = W(3);
Yp = W(4);

global p_alpha ;
global p_delta ;
global p_gamma ;
global p_epsilon;
global p_h;

dYd = p_alpha*Yd*Yp -p_delta*Yd ;
dYb = p_gamma*Yp*Yc*Yb - p_delta*Yb;
dYc = p_h*p_alpha*Yd*Yp - p_gamma*Yb*Yc*Yp - p_delta*Yc;
dYp = p_epsilon - p_alpha*Yd*Yp - p_gamma*Yb*Yc*Yp;

Ys = [dYd;dYb;dYc;dYp];
end

