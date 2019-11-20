function [] = coeff_variation(thick,volume,area,color,label)
%This function computes and visualises the coeffcient of variation for 
%all three morphological measures (thickness, volume and surface area). 
%
% Arguments:
% -THICK - double array; average cortical thickness of data set 1
% -VOL - double array; volume of data set 1
% -AREA - double array; surface area of data set 1 
% -COLOR - double array; color of the displayed scatter plots. 
% -LABEL - cell array; labels of plot 
%     
% Returns:
% figure plot
%
% Dependencies: 
%-NONE
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



figure

%thickness
scatter(1:68,log10(var(thick)./mean(thick)),'o','MarkerEdgeColor', color, 'MarkerFaceColor', color)
hold on

%volume
scatter(1:68,log10(var(volume)./mean(volume)),'d','MarkerEdgeColor', color, 'MarkerFaceColor', color)

%area
hold on 
scatter(1:68,log10(var(area)./mean(area)),'+','MarkerEdgeColor', color, 'MarkerFaceColor', color)

legend('thickness','volume','area')
xlabel('ROIs')
ylabel('ROI log_{10}(coefficient of variation)')
title(label)
xticklabels('')
box on  
set(findall(gcf,'-property','FontSize'),'FontSize',14)



end