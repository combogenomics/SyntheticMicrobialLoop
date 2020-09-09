
t  = [0, 0.1, 0.2];
y0 = 0;

for k = 2:length(t)
  fValue = 2;
  [t,x] = ode15s(@(t, f)fodt(t,x,fValue), t(k-1:k), y0);
  y0     = x(end, :);
end

[t,x] = ode15s(@(t,x)fodt(t,x), [0 10], 1)

plot(t,x)

hold on