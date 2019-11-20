function [] = attenuation_by_correlation_strength(thick, vol, area,thick2,vol2,area2,color)
%This function visualises the relationship of correlation strength and
%attenaution. (The correlation strength is inferred from the estimated corrected
%correlations)
%
% Arguments:
% -THICK - double array; average cortical thickness of data set 1
% -VOL - double array; volume of data set 1
% -AREA - double array; surface area of data set 1 
% -THICK2 - double array; average cortical thickness of data set 2
% -VOL2 - double array; volume of data set 2
% -AREA2 - double array; surface area of data set 2
% -COLOR - double array; color of the displayed scatter plots. 
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
corr_thick(corr_thick > 0.999) = 0.999; %atanh of 1 is infinite, but atanh of 0.999 is 3.8  

corr_vol = corr(vol);
corr_vol = corr_vol(:);
corr_vol(corr_vol > 0.999) = 0.999;

corr_area = corr(area);
corr_area = corr_area(:);
corr_area(corr_area > 0.999) = 0.999;



%estimate underlying correlations 
[cov_corrected,~, var_corrected1,var_corrected2,~,~] = estimate_noise_and_corr(thick,thick2);
corr_thick_improved = cov_corrected./sqrt(var_corrected1.*var_corrected2);
corr_thick_improved = corr_thick_improved(:);
corr_thick_improved(corr_thick_improved > 0.999) = 0.999; %atanh of 1 is infinite, but atanh of 0.999 is 3.8   

[cov_corrected,~, var_corrected1,var_corrected2,~,~] = estimate_noise_and_corr(vol,vol2);
corr_vol_improved = cov_corrected./sqrt(var_corrected1.*var_corrected2);
corr_vol_improved = corr_vol_improved(:);
corr_vol_improved(corr_vol_improved > 0.999) = 0.999; %atanh of 1 is infinite, but atanh of 0.999 is 3.8  

[cov_corrected,~, var_corrected1,var_corrected2,~,~] = estimate_noise_and_corr(area,area2);
corr_area_improved = cov_corrected./sqrt(var_corrected1.*var_corrected2);
corr_area_improved = corr_area_improved(:);
corr_area_improved(corr_area_improved > 0.999) = 0.999; %atanh of 1 is infinite, but atanh of 0.999 is 3.8  



%cmpute change from measured to corrected correlation 
change_corr_thick = atanh(corr_thick_improved) - atanh(corr_thick);
change_corr_vol = atanh(corr_vol_improved) - atanh(corr_vol); 
change_corr_area = atanh(corr_area_improved) - atanh(corr_area);



%select attenuated correlations
attenuation_thick_index = find((corr_thick < corr_thick_improved));
attenuation_vol_index = find((corr_vol < corr_vol_improved));
attenuation_area_index = find((corr_area < corr_area_improved));



% %correlation size ~ attenuation strength
figure('Position',[100 100 1100 300])


subplot(1,3,1)
scatter(abs(corr_thick_improved(attenuation_thick_index)),abs(change_corr_thick(attenuation_thick_index)) ... 
    ,2,'MarkerEdgeAlpha',0.3,'MarkerEdgeColor',color')
lsline
title(['Thickness \rho = ',num2str(corr(abs(corr_thick_improved(attenuation_thick_index)),....
    abs(change_corr_thick(attenuation_thick_index))))])
ylim([0 0.4])
xlabel('|Estimated corrected correlation|')
ylabel('|Estimated attenuation|')



subplot(1,3,2)
scatter(abs(corr_vol_improved(attenuation_vol_index)),abs(change_corr_vol(attenuation_vol_index)) ... 
    ,2,'MarkerEdgeAlpha',0.3,'MarkerEdgeColor',color')
lsline
title(['Volume \rho = ',num2str(corr(abs(corr_vol_improved(attenuation_vol_index)),...
    abs(change_corr_vol(attenuation_vol_index))))])
ylim([0 0.4])
xlabel('|Estimated corrected correlation|')
ylabel('|Estimated attenuation|')



subplot(1,3,3)
scatter(abs(corr_area_improved(attenuation_area_index)),abs(change_corr_area(attenuation_area_index)) ... 
   ,2,'MarkerEdgeAlpha',0.3,'MarkerEdgeColor',color')
lsline
title(['Surface area \rho = ',num2str(corr(abs(corr_area_improved(attenuation_area_index)),...
    abs(change_corr_area(attenuation_area_index))))])
ylim([0 0.4])
xlabel('|Estimated corrected correlation|')
ylabel('|Estimated attenuation|')



set(findall(gcf,'-property','FontSize'),'FontSize',13)



end