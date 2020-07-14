function [] = brain_surface_plot_all(thick, thick2, vol, vol2, area, area2, tag)
%This function computes the average ROI differnce of the structural covariance
% of thickness, volume and surface area for data 1 and data 2. 
% The differnces are displayed with a heatmap on the brain. 
%
% Arguments:
% -THICK - double array; average cortical thickness of data set 1
% -VOL - double array; volume of data set 1
% -AREA - double array; surface area of data set 1 
% -THICK2 - double array; average cortical thickness of data set 2
% -VOL2 - double array; volume of data set 2
% -AREA2 - double array; surface area of data set 2
% -TAG - cell array; headline of subplots
%     
% Returns:
% figure plot
%
% Dependencies: 
% -FSmatlab folder
% -aparc files
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, March 2020 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



figure('Position',[0,0,1200, 200])

a = subplot(1,3,1);
hold on
brain_surface_plot_single(thick, thick2);
title('thickness')

b = subplot(1,3,2);
hold on
brain_surface_plot_single(vol, vol2);
title('volume')

c = subplot(1,3,3);
hold on
brain_surface_plot_single(area, area2);
title('surface area')

linkaxes([a,b,c],'xy')

% headline of all subplots
sgtitle(tag)



end