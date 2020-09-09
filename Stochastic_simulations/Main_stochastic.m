close all

Files = {'simST_V_1.000e+03_av_1.00e+01_eps_1.600e-03.dat' ; 'simST_V_1.000e+03_av_1.00e+01_eps_1.900e-03.dat' ; 'simST_V_1.000e+03_av_1.00e+01_eps_2.200e-03.dat' ; 'simST_V_1.000e+03_av_1.00e+01_eps_2.500e-03.dat'; ; 'simST_V_1.000e+03_av_1.00e+01_eps_2.800e-03.dat'};
global Plots
global ColorStochastic;
ColorStochastic = {'blue' ; 'red' ; 'black' ; 'yellow' ; 'green'}
global counter;
global Stochastic_legend
Stochastic_legend = {'1.6' ; '1.9' ; '2.2' ; '2.5' ; '2.8'}
 Plots = [];

for counter = 1:1:length(Files)

        solveModel_with_p_vs_stochastic_completo(Files{counter});
end

legend([Plots{:}], Stochastic_legend);
legend boxoff;                  


