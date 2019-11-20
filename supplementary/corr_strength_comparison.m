function [] = corr_strength_comparison(thick, vol, area,color)
%This function visualises for all morphological measures a boxplot of the 
%correlation strengths of the (correlations of the) structural covaraince.  
%
% Arguments:
% -THICK - double array; average cortical thickness of data set 1
% -VOL - double array; volume of data set 1
% -AREA - double array; surface area of data set 1 
% -COLOR - double array; color of the displayed scatter plots. 
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



%compute correlations 
corr_thick = corr(thick);
corr_thick = corr_thick(:);
corr_vol = corr(vol);
corr_vol = corr_vol(:);
corr_area = corr(area);
corr_area = corr_area(:);



%box plot of correlations 
figure
grouping = [zeros([68*68 1]); ones([68*68 1]);2*ones([68*68 1])];
data = [corr_thick; corr_vol; corr_area];

boxplot(data,grouping,'Positions',[0.1 0.2 0.3],'Colors',color,'Labels',{'Thickness','Volume','Surface area'})

ylabel('correlation strengths')
box on
title(['thickness mean = ', num2str(mean(abs(corr_thick(:)))),' volume mean = ',...
    num2str(mean(abs(corr_vol(:)))),' area mean = ', num2str(mean(abs(corr_area(:))))])

set(findall(gcf,'-property','FontSize'),'FontSize',13)



end