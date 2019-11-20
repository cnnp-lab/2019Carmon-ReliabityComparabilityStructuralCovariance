function [] = attenuation_and_reliability(thick, vol, area,thick2,vol2,area2,color,limits,tag)
%This function computes the error variance, error covariance, attenuation
%and reliability and scatters their relationship. By attenuation we mean
%the differnce between the estimated corrected correlation and the 
%empirically measured correlation. By reliability we mean the difference
%between empirically measured correlations
%
% Arguments:
% -THICK - double array; average cortical thickness of data set 1
% -VOL - double array; volume of data set 1
% -AREA - double array; surface area of data set 1 
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
%-estimate_noise_and_corr
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



%compute correlations 
corr_thick = corr(thick);
corr_thick = corr_thick(:);
%atanh of 1 is infinite, but atanh of 0.995055 is 3  
corr_thick(corr_thick > 0.995055) = 0.995055; 

corr_vol = corr(vol);
corr_vol = corr_vol(:);
corr_vol(corr_vol > 0.995055) = 0.995055;

corr_area = corr(area);
corr_area = corr_area(:);
corr_area(corr_area > 0.995055) = 0.995055;

corr_thick2 = corr(thick2);
corr_thick2 = corr_thick2(:);
corr_thick2(corr_thick2 > 0.995055) = 0.995055;

corr_vol2 = corr(vol2);
corr_vol2 = corr_vol2(:);
corr_vol2(corr_vol2 > 0.995055) = 0.995055;

corr_area2 = corr(area2);
corr_area2 = corr_area2(:);
corr_area2(corr_area2 > 0.995055) = 0.995055;



%estimate underlying correlations 
[cov_corrected,cov_error_thick, var_corrected1,var_corrected2,~,...
    var_error_thick] = estimate_noise_and_corr(thick,thick2);

corr_thick_improved = cov_corrected./sqrt(var_corrected1.*var_corrected2);
corr_thick_improved = corr_thick_improved(:);
%atanh of 1 is infinite, but atanh of 0.995055 is 3  
corr_thick_improved(corr_thick_improved > 0.995055) = 0.995055; 


[cov_corrected,cov_error_vol, var_corrected1,var_corrected2,~,var_error_vol]...
    = estimate_noise_and_corr(vol,vol2);

corr_vol_improved = cov_corrected./sqrt(var_corrected1.*var_corrected2);
corr_vol_improved = corr_vol_improved(:);
%atanh of 1 is infinite, but atanh of 0.995055 is 3
corr_vol_improved(corr_vol_improved > 0.995055) = 0.995055;  


[cov_corrected,cov_error_area, var_corrected1,var_corrected2,~,var_error_area]...
    = estimate_noise_and_corr(area,area2);

corr_area_improved = cov_corrected./sqrt(var_corrected1.*var_corrected2);
corr_area_improved = corr_area_improved(:);
%atanh of 1 is infinite, but atanh of 0.995055 is 3
corr_area_improved(corr_area_improved > 0.995055) = 0.995055; 



%compute change of estimated vs. measured correlations
change_corr_thick = (atanh(corr_thick_improved) - atanh(corr_thick));
change_corr_vol = (atanh(corr_vol_improved) - atanh(corr_vol));
change_corr_area = (atanh(corr_area_improved) - atanh(corr_area));



%compute differnce of correlations ( = reliability)
diff_corr_thick = (atanh(corr_thick) - atanh(corr_thick2));
diff_corr_vol = (atanh(corr_vol) - atanh(corr_vol2));
diff_corr_area = (atanh(corr_area) - atanh(corr_area2));



%covariance error 
cov_error_thick = cov_error_thick(:);
cov_error_thick = (cov_error_thick);
cov_error_vol = cov_error_vol(:);
cov_error_vol = (cov_error_vol);
cov_error_area = cov_error_area(:);
cov_error_area = (cov_error_area);



%varaince error 
var_error_thick = var_error_thick(:);
var_error_vol = var_error_vol(:);
var_error_area = var_error_area(:);









%Select only attenuated correlations
attenuation_index_thick = find(corr_thick_improved > corr_thick);
attenuation_index_vol = find(corr_vol_improved > corr_vol);
attenuation_index_area = find(corr_area_improved > corr_area);



%plot estimated attenuation ~ differnce in correlation
figure

subplot(1,3,1)
scatter((change_corr_thick(attenuation_index_thick)),abs(diff_corr_thick(attenuation_index_thick)),3,...
    'MarkerFaceColor',color,'MarkerEdgeColor',color,'MarkerEdgeAlpha',0.05,'MarkerFaceAlpha',0.05)
xlabel('Estimated attenuation ')
ylabel('|Difference in measured correlation| ')
title('Thickness')
xlim([0 limits(1)])
ylim([0 limits(1)])
box on
%plot the correlation value in a text box
corr_value = corr((change_corr_thick(attenuation_index_thick)),...
    abs(diff_corr_thick(attenuation_index_thick)),'type','Spearman');
corr_value = round(corr_value,2);
y_lim = get(gca,'ylim');
x_lim = get(gca,'xlim');
text(x_lim(2) - (x_lim(2) - x_lim(1))/8,y_lim(2) - (y_lim(2) - y_lim(1))/8,...
    ['\rho = ', num2str(corr_value)],...
    'FontWeight','bold',...
    'HorizontalAlignment','right','VerticalAlignment','cap')
axis('square')



subplot(1,3,2)
scatter((change_corr_vol(attenuation_index_vol)),abs(diff_corr_vol(attenuation_index_vol)),3,....
   'MarkerFaceColor',color,'MarkerEdgeColor',color,'MarkerEdgeAlpha',0.05,'MarkerFaceAlpha',0.05)
xlabel('Estimated attenuation ')
title('Volume')
xlim([0 limits(1)])
ylim([0 limits(1)])
yticklabels({''})
box on
%plot the correlation value in a text box
corr_value = corr((change_corr_vol(attenuation_index_vol)),...
    abs(diff_corr_vol(attenuation_index_vol)),'type','Spearman');
corr_value = round(corr_value,2);
y_lim = get(gca,'ylim');
x_lim = get(gca,'xlim');
text(x_lim(2) - (x_lim(2) - x_lim(1))/8,y_lim(2) - (y_lim(2) - y_lim(1))/8,...
    ['\rho = ', num2str(corr_value)],...
    'FontWeight','bold',...
    'HorizontalAlignment','right','VerticalAlignment','cap')
axis('square')



subplot(1,3,3)
scatter((change_corr_area(attenuation_index_area)),abs(diff_corr_area(attenuation_index_area)),3,...
    'MarkerFaceColor',color,'MarkerEdgeColor',color,'MarkerEdgeAlpha',0.05,'MarkerFaceAlpha',0.05)
xlabel('Estimated attenuation ')
title('Surface area')
xlim([0 limits(1)])
ylim([0 limits(1)])
yticklabels({''})
box on
%plot the correlation value in a text box
corr_value = corr((change_corr_area(attenuation_index_area)),...
    abs(diff_corr_area(attenuation_index_area)),'type','Spearman');
corr_value = round(corr_value,2);
y_lim = get(gca,'ylim');
x_lim = get(gca,'xlim');
text(x_lim(2) - (x_lim(2) - x_lim(1))/8,y_lim(2) - (y_lim(2) - y_lim(1))/8,...
    ['\rho = ', num2str(corr_value)],...
    'FontWeight','bold',...
    'HorizontalAlignment','right','VerticalAlignment','cap')
axis('square')

set(findall(gcf,'-property','FontSize'),'FontSize',13)






% select all corelations for the following plots
attenuation_index_thick = 1:68^2;
attenuation_index_vol = 1:68^2;
attenuation_index_area = 1:68^2;



%covariance error 
%plot estimated error ~ estimated attenuation
figure
subplot(3,1,1);
scatter(cov_error_thick(attenuation_index_thick),change_corr_thick(attenuation_index_thick),3,...
    'MarkerFaceColor',color,'MarkerEdgeColor',color,'MarkerEdgeAlpha',0.05,'MarkerFaceAlpha',0.05)
ylabel({'{\bfThickness}',['Corrected corr - ', char(tag(1)), ' corr']})
xticklabels({''})
box on
xlim([-limits(2) limits(2)])
ylim([-limits(3)/4 limits(3)])
yline(0)
xline(0)
%plot the correlation value in a text box
corr_value = corr(cov_error_thick(attenuation_index_thick),...
    change_corr_thick(attenuation_index_thick),'type','Spearman');
corr_value = round(corr_value,2);
y_lim = get(gca,'ylim');
x_lim = get(gca,'xlim');
text(x_lim(2) - (x_lim(2) - x_lim(1))/20,y_lim(2) - (y_lim(2) - y_lim(1))/20,...
    ['\rho = ', num2str(corr_value)],...
    'FontWeight','bold',...
    'HorizontalAlignment','right','VerticalAlignment','cap')
axis('square')



subplot(3,1,2);
scatter(cov_error_vol(attenuation_index_vol),change_corr_vol(attenuation_index_vol),3,....
   'MarkerFaceColor',color,'MarkerEdgeColor',color,'MarkerEdgeAlpha',0.05,'MarkerFaceAlpha',0.05)
ylabel({'{\bfVolume}',['Corrected corr - ', char(tag(1)), ' corr']})
xticklabels({''})
box on
xlim([-limits(2) limits(2)])
ylim([-limits(3)/4 limits(3)])
yline(0)
xline(0)
%plot the correlation value in a text box
corr_value = corr((change_corr_vol(attenuation_index_vol)),...
    cov_error_vol(attenuation_index_vol),'type','Spearman');
corr_value = round(corr_value,2);
y_lim = get(gca,'ylim');
x_lim = get(gca,'xlim');
text(x_lim(2) - (x_lim(2) - x_lim(1))/20,y_lim(2) - (y_lim(2) - y_lim(1))/20,...
    ['\rho = ', num2str(corr_value)],...
    'FontWeight','bold',...
    'HorizontalAlignment','right','VerticalAlignment','cap')
axis('square')


subplot(3,1,3);
scatter(cov_error_area(attenuation_index_area),change_corr_area(attenuation_index_area),3,...
    'MarkerFaceColor',color,'MarkerEdgeColor',color,'MarkerEdgeAlpha',0.05,'MarkerFaceAlpha',0.05)
ylabel({'{\bfSurface area}',['Corrected corr - ', char(tag(1)), ' corr']})
xlabel({'Estimated error covariance ',[char(tag(1)), ' data']})
box on
xlim([-limits(2) limits(2)])
ylim([-limits(3)/4 limits(3)])
yline(0)
xline(0)
%plot the correlation value in a text box
corr_value = corr((change_corr_area(attenuation_index_area)),...
    cov_error_area(attenuation_index_area),'type','Spearman');
corr_value = round(corr_value,2);
y_lim = get(gca,'ylim');
x_lim = get(gca,'xlim');
text(x_lim(2) - (x_lim(2) - x_lim(1))/20,y_lim(2) - (y_lim(2) - y_lim(1))/20,...
    ['\rho = ', num2str(corr_value)],...
    'FontWeight','bold',...
    'HorizontalAlignment','right','VerticalAlignment','cap')
axis('square')

set(findall(gcf,'-property','FontSize'),'FontSize',13)



%plot estimated error ~ differences in correlation 
figure
subplot(3,1,1);
scatter(cov_error_thick(attenuation_index_thick),diff_corr_thick(attenuation_index_thick),3,...
    'MarkerFaceColor',color,'MarkerEdgeColor',color,'MarkerEdgeAlpha',0.05,'MarkerFaceAlpha',0.05)
ylabel({'{\bfThickness}',[char(tag(1)),' corr - ',char(tag(2)),' corr']})
xticklabels({''})
box on
xlim([-limits(4) limits(4)])
ylim([-limits(5) limits(5)])
yline(0)
xline(0)
%plot the correlation value in a text box
corr_value = corr((cov_error_thick(attenuation_index_thick)),...
    diff_corr_thick(attenuation_index_thick),'type','Spearman');
corr_value = round(corr_value,2);
y_lim = get(gca,'ylim');
x_lim = get(gca,'xlim');
text(x_lim(2) - (x_lim(2) - x_lim(1))/20,y_lim(2) - (y_lim(2) - y_lim(1))/20,...
    ['\rho = ', num2str(corr_value)],...
    'FontWeight','bold',...
    'HorizontalAlignment','right','VerticalAlignment','cap')
axis('square')


subplot(3,1,2);
scatter(cov_error_vol(attenuation_index_vol),diff_corr_vol(attenuation_index_vol),3,....
   'MarkerFaceColor',color,'MarkerEdgeColor',color,'MarkerEdgeAlpha',0.05,'MarkerFaceAlpha',0.05)
ylabel({'{\bfVolume}',[char(tag(1)),' corr - ',char(tag(2)),' corr']})
xticklabels({''})
box on
xlim([-limits(4) limits(4)])
ylim([-limits(5) limits(5)])
yline(0)
xline(0)
%plot the correlation value in a text box
corr_value = corr((cov_error_vol(attenuation_index_vol)),...
    diff_corr_vol(attenuation_index_vol),'type','Spearman');
corr_value = round(corr_value,2);
y_lim = get(gca,'ylim');
x_lim = get(gca,'xlim');
text(x_lim(2) - (x_lim(2) - x_lim(1))/20,y_lim(2) - (y_lim(2) - y_lim(1))/20,...
    ['\rho = ', num2str(corr_value)],...
    'FontWeight','bold',...
    'HorizontalAlignment','right','VerticalAlignment','cap')
axis('square')


subplot(3,1,3);
scatter(cov_error_area(attenuation_index_area),diff_corr_area(attenuation_index_area),3,...
    'MarkerFaceColor',color,'MarkerEdgeColor',color,'MarkerEdgeAlpha',0.05,'MarkerFaceAlpha',0.05)
xlabel({'Estimated error covariance ',[char(tag(1)), ' data']})
ylabel({'{\bfSurface area}',[char(tag(1)),' corr - ',char(tag(2)),' corr']})
box on
xlim([-limits(4) limits(4)])
ylim([-limits(5) limits(5)])
yline(0)
xline(0)
%plot the correlation value in a text box
corr_value = corr((cov_error_area(attenuation_index_area)),...
    diff_corr_area(attenuation_index_area),'type','Spearman');
corr_value = round(corr_value,2);
y_lim = get(gca,'ylim');
x_lim = get(gca,'xlim');
text(x_lim(2) - (x_lim(2) - x_lim(1))/20,y_lim(2) - (y_lim(2) - y_lim(1))/20,...
    ['\rho = ', num2str(corr_value)],...
    'FontWeight','bold',...
    'HorizontalAlignment','right','VerticalAlignment','cap')
axis('square')

set(findall(gcf,'-property','FontSize'),'FontSize',13)






%variance error 
%plot estimated error ~ estimated attenuation
figure 
subplot(3,1,1);
scatter(var_error_thick(attenuation_index_thick),change_corr_thick(attenuation_index_thick),3,...
    'MarkerFaceColor',color,'MarkerEdgeColor',color,'MarkerEdgeAlpha',0.05,'MarkerFaceAlpha',0.05)
%ylabel({'{\bfThickness}',['Corrected corr - ', char(tag(1)), ' corr']})
xticklabels({''})
yticklabels({''})
box on
xlim([0 limits(6)])
ylim([-limits(7)/4 limits(7)])
yline(0)
%plot the correlation value in a text box
corr_value = corr(var_error_thick(attenuation_index_thick),...
    change_corr_thick(attenuation_index_thick),'type','Spearman');
corr_value = round(corr_value,2);
y_lim = get(gca,'ylim');
x_lim = get(gca,'xlim');
text(x_lim(2) - (x_lim(2) - x_lim(1))/20,y_lim(2) - (y_lim(2) - y_lim(1))/20,...
    ['\rho = ', num2str(corr_value)],...
    'FontWeight','bold',...
    'HorizontalAlignment','right','VerticalAlignment','cap')
axis('square')


subplot(3,1,2);
scatter(var_error_vol(attenuation_index_vol),change_corr_vol(attenuation_index_vol),3,....
   'MarkerFaceColor',color,'MarkerEdgeColor',color,'MarkerEdgeAlpha',0.05,'MarkerFaceAlpha',0.05)
%ylabel({'{\bfVolume}',['Corrected corr - ', char(tag(1)), ' corr']})
xticklabels({''})
yticklabels({''})
box on
xlim([0 limits(6)])
ylim([-limits(7)/4 limits(7)])
yline(0)
%plot the correlation value in a text box
corr_value = corr((change_corr_vol(attenuation_index_vol)),...
    var_error_vol(attenuation_index_vol),'type','Spearman');
corr_value = round(corr_value,2);
y_lim = get(gca,'ylim');
x_lim = get(gca,'xlim');
text(x_lim(2) - (x_lim(2) - x_lim(1))/20,y_lim(2) - (y_lim(2) - y_lim(1))/20,...
    ['\rho = ', num2str(corr_value)],...
    'FontWeight','bold',...
    'HorizontalAlignment','right','VerticalAlignment','cap')
axis('square')



subplot(3,1,3);
scatter(var_error_area(attenuation_index_area),change_corr_area(attenuation_index_area),3,...
    'MarkerFaceColor',color,'MarkerEdgeColor',color,'MarkerEdgeAlpha',0.05,'MarkerFaceAlpha',0.05)
xlabel({'Estimated error variance ',[char(tag(1)), ' data']})
%ylabel({'{\bfSurface area}',['Corrected corr - ', char(tag(1)), ' corr']})
yticklabels({''})
box on
xlim([0 limits(6)])
ylim([-limits(7)/4 limits(7)])
yline(0)
%plot the correlation value in a text box
corr_value = corr((change_corr_area(attenuation_index_area)),...
    var_error_area(attenuation_index_area),'type','Spearman');
corr_value = round(corr_value,2);
y_lim = get(gca,'ylim');
x_lim = get(gca,'xlim');
text(x_lim(2) - (x_lim(2) - x_lim(1))/20,y_lim(2) - (y_lim(2) - y_lim(1))/20,...
    ['\rho = ', num2str(corr_value)],...
    'FontWeight','bold',...
    'HorizontalAlignment','right','VerticalAlignment','cap')
axis('square')

set(findall(gcf,'-property','FontSize'),'FontSize',13)



%plot estimated error ~ differences in correlation 
figure('Position',[100 0 250 1000]) 
subplot(3,1,1);
scatter(var_error_thick(attenuation_index_thick),diff_corr_thick(attenuation_index_thick),3,...
    'MarkerFaceColor',color,'MarkerEdgeColor',color,'MarkerEdgeAlpha',0.05,'MarkerFaceAlpha',0.05)
%ylabel([char(tag(1)),' corr - ',char(tag(2)),' corr'])
title(['Thickness \rho = ',... 
    num2str(corr((var_error_thick(attenuation_index_thick)),diff_corr_thick(attenuation_index_thick),'type','Spearman'))])
xticklabels({''})
box on
xlim([0 limits(8)])
ylim([-limits(9) limits(9)])
yline(0)


subplot(3,1,2);
scatter(var_error_vol(attenuation_index_vol),diff_corr_vol(attenuation_index_vol),3,....
   'MarkerFaceColor',color,'MarkerEdgeColor',color,'MarkerEdgeAlpha',0.05,'MarkerFaceAlpha',0.05)
ylabel([char(tag(1)),' corr - ',char(tag(2)),' corr'])
title(['Volume \rho = ' ... 
    num2str(corr((var_error_vol(attenuation_index_vol)),diff_corr_vol(attenuation_index_vol),'type','Spearman'))])
xticklabels({''})
box on
xlim([0 limits(8)])
ylim([-limits(9) limits(9)])
yline(0)


subplot(3,1,3);
scatter(var_error_area(attenuation_index_area),diff_corr_area(attenuation_index_area),3,...
    'MarkerFaceColor',color,'MarkerEdgeColor',color,'MarkerEdgeAlpha',0.05,'MarkerFaceAlpha',0.05)
xlabel(['Estimated error variance ',char(tag(1)), ' data'])
ylabel([char(tag(1)),' corr - ',char(tag(2)),' corr'])
title(['Surface area \rho = ' ...
    num2str(corr((var_error_area(attenuation_index_area)),diff_corr_area(attenuation_index_area),'type','Spearman'))])
box on
xlim([0 limits(8)])
ylim([-limits(9) limits(9)])
yline(0)



end