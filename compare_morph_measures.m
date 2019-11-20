function [] = compare_morph_measures(thick1, thick2, vol1, vol2, area1, area2, color, limits, tag)
%This function computes the differnce in structural covariance between data 
%set 1 and data set 2 for three different morphological measures (thickness,
%volume and surface area). The correlations are Fisher transformed before
%their difference is computed. The distribution of differences are displayed with a 
%non-parametric kernel density estimation.
%
% Arguments:
% -THICK1 - double array; average cortical thickness of data set 1
% -VOL1 - double array; volume of data set 1
% -AREA1 - double array; surface area of data set 1 
% -THICK2 - double array; average cortical thickness of data set 2
% -VOL2 - double array; volume of data set 2
% -AREA2 - double array; surface area of data set 2
% -COLOR - double array; color of the displayed scatter plots. 
% -LIMITS - double array; limits of scatter plots 
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



%compute differnces between data sets
thick_diff = abs(atanh(corr(thick1)) - atanh(corr(thick2)));
thick_diff(isnan(thick_diff)) = 0;
thick_diff = sum(thick_diff)/68;

vol_diff = abs(atanh(corr(vol1)) - atanh(corr(vol2)));
vol_diff(isnan(vol_diff)) = 0;
vol_diff = sum(vol_diff)/68;

area_diff = abs(atanh(corr(area1)) - atanh(corr(area2)));
area_diff(isnan(area_diff)) = 0;
area_diff = sum(area_diff)/68;



figure('Position',[200,200,500,400])

h = histfit(thick_diff,100,'kernel');
h(2).Color = color;
h(2).LineStyle = '-';
delete(h(1)) %delete histogram to keep only the fit
axis([limits(1),limits(2),limits(3),limits(4)])
ylabel('Number of ROIs')
xlabel(['average ROI differnce between ',char(tag)])

hold on
h = histfit(vol_diff,100, 'kernel');
h(2).Color = color;
h(2).LineStyle = '--';
delete(h(1)) 
axis([limits(1),limits(2),limits(3),limits(4)])

hold on
h = histfit(area_diff,100, 'kernel');
h(2).Color = color;
h(2).LineStyle = ':';
delete(h(1))
axis([limits(1),limits(2),limits(3),limits(4)])

legend('thickness', 'volume', 'area')



end