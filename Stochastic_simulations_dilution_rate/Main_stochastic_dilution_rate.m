
global  RatioCsi;
    
for i = 1:25

    solveModelForTable(i)
    
    figure_name = strcat('iteration_', num2str(RatioCsi), '_' ,num2str(i), '.png');
    
    saveas(gcf, figure_name)

    
end
