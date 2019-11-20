function [] = struct_cov_lh_rh(thick1,thick2,vol1,vol2,area1,area2,color1, color2, tags, frame_size)
%This function visualises the correlations of the left and right hemisphere 
%of all three morphological measures (thickness, volume and area) 
%for two data sets
%
% Arguments:
% -THICK1 - double array; average cortical thickness of data set 1
% -VOL1 - double array; volume of data set 1
% -AREA1 - double array; surface area of data set 1 
% -THICK2 - double array; average cortical thickness of data set 2
% -VOL2 - double array; volume of data set 2
% -AREA2 - double array; surface area of data set 2
% -FRAME_SIZE - double array; size of plots 
% -COLOR - double array; color of the displayed scatter plots. 
%     
% Returns:
% figure plot
%
% Dependencies: 
%-error_ellipse
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



figure('Position',[0,0,250,1100])



%thickness
a = subplot(3,1,1);
scatter(thick1(:,1),thick1(:,2),3,'filled', 'MarkerEdgeColor', color1, ...
    'MarkerFaceColor', color1,'MarkerEdgeAlpha',0.5,'MarkerFaceAlpha',0.5)

hold on
scatter(thick2(:,1),thick2(:,2),3,'filled', 'MarkerEdgeColor', color2, ...
    'MarkerFaceColor', color2,'MarkerEdgeAlpha',0.5,'MarkerFaceAlpha',0.5)

hold on
error_ellipse(cov(thick1),color1)

hold on
error_ellipse(cov(thick2),color2)

legend(char(tags(1)),char(tags(2)),'Location','northwest')
ylabel('right hemisphere')
corr_value1 = round(corr(thick1(:,1),thick1(:,2)),2);
corr_value2 = round(corr(thick2(:,1),thick2(:,2)),2);
title(['\rho_{',char(tags(1)),'}', '= ', num2str(corr_value1),...
    '     ', '\rho_{',char(tags(2)),'}', '= ', num2str(corr_value2)])
set(gca,'XTick',[])
box on



%volume
b = subplot(3,1,2);
scatter(vol1(:,1),vol1(:,2),3,'filled', 'MarkerEdgeColor', color1, ...
    'MarkerFaceColor', color1,'MarkerEdgeAlpha',0.5,'MarkerFaceAlpha',0.5)

hold on
scatter(vol2(:,1),vol2(:,2),3,'filled', 'MarkerEdgeColor', color2, ...
    'MarkerFaceColor', color2,'MarkerEdgeAlpha',0.5,'MarkerFaceAlpha',0.5)

hold on
error_ellipse(cov(vol1),color1)

hold on
error_ellipse(cov(vol2),color2)

title("Volume")
legend(char(tags(1)),char(tags(2)),'Location','northwest')
ylabel('right hemisphere')
corr_value1 = round(corr(vol1(:,1),vol1(:,2)),2);
corr_value2 = round(corr(vol2(:,1),vol2(:,2)),2);
title(['\rho_{',char(tags(1)),'}', '= ' num2str(corr_value1),...
    '     ', '\rho_{',char(tags(2)),'}', '= ' num2str(corr_value2)])
set(gca,'XTick',[])
box on



%area 
c = subplot(3,1,3);
scatter(area1(:,1),area1(:,2),3,'filled', 'MarkerEdgeColor', color1, ...
    'MarkerFaceColor', color1,'MarkerEdgeAlpha',0.5,'MarkerFaceAlpha',0.5)

hold on
scatter(area2(:,1) ,area2(:,2),3,'filled', 'MarkerEdgeColor', color2,...
    'MarkerFaceColor', color2,'MarkerEdgeAlpha',0.5,'MarkerFaceAlpha',0.5)

hold on
error_ellipse(cov(area1),color1)

hold on
error_ellipse(cov(area2),color2)

title("Surface area")
legend(char(tags(1)),char(tags(2)),'Location','northwest')
xlabel('left hemisphere')
ylabel('right hemisphere')
corr_value1 = round(corr(area1(:,1),area1(:,2)),2);
corr_value2 = round(corr(area2(:,1),area2(:,2)),2);
title(['\rho_{',char(tags(1)),'}', '= ' num2str(corr_value1),...
    '     ', '\rho_{',char(tags(2)),'}', '= ' num2str(corr_value2)])
box on



linkaxes([a,b,c],'xy')
axis([-frame_size, frame_size, -frame_size, frame_size])
%to change the display format of the floats 
format short g



end