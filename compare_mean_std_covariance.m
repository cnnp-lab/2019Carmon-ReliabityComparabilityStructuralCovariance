function [] = compare_mean_std_covariance(data1, data2, color1, color2, tags, rois)
%This function visualises a boxplot of the data distribution in each ROI,
%and the covariance between the two ROIs as an ellipse.
%
% Arguments:
% -DATA1 - double array; data set 1
% -DATA1 - double array; data set 2
% -COLOR1 - double array; color of first ROI
% -COLOR2 - double array; color of second ROI
% -TAGS - cell array; names of ROIs
% -ROIS - double array; index of ROIs in the data matrices
%
% Returns:
% -figure plot
%
% Dependencies: 
% - error_ellipse 
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



figure('Position',[200,200,1100,300]) 



%boxplots of ROI 1
subplot(1,3,1)
boxplot([data1(:,1),data2(:,1)], 'Colors', [color1;color2], 'Labels',{char(tags(1)),char(tags(2))})
title(['p-value = ',num2str(pvalue_univariate_measure(data1(:,2),data2(:,2))),'   ', char(rois(1))])



%boxplots of ROI 2
subplot(1,3,2)
boxplot([data1(:,2),data2(:,2)], 'Colors', [color1;color2],'Labels',{char(tags(1)),char(tags(2))})
title(['p-value = ',num2str(pvalue_univariate_measure(data1(:,2),data2(:,2))),'   ', char(rois(2))])



%comparison correlation of data sets
%correlation of (ROI 1 with ROI 2) 
subplot(1,3,3)
scatter(data1(:,1),data1(:,2),'filled', 'MarkerEdgeColor', color1,...
    'MarkerFaceColor', color1, 'MarkerFaceAlpha', 0.3, 'MarkerEdgeAlpha', 0.3)
hold on
error_ellipse(cov(data1),color1)

hold on 
scatter(data2(:,1), data2(:,2),'filled' , 'MarkerEdgeColor', color2, ...
    'MarkerFaceColor', color2, 'MarkerFaceAlpha', 0.3, 'MarkerEdgeAlpha', 0.3)
error_ellipse(cov(data2),color2)

corr_value1 = round(corr(data1(:,1),data1(:,2)),2);
corr_value2 = round(corr(data2(:,1),data2(:,2)),2);

title(['p-value = ',num2str(round(pvalue(data1,data2),2)),...
    '   ','\rho_{',char(tags(1)),'}', '= ', num2str(corr_value1),...
    '     ', '\rho_{',char(tags(2)),'}', '= ', num2str(corr_value2)])

xlabel(rois(1))
ylabel(rois(2))
box on



%to change the display format of the floats 
format short g



end