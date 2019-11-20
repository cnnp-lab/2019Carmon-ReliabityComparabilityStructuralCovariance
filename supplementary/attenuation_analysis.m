function [] = attenuation_analysis(thick, vol, area,thick2,vol2,area2,color)
%This function visualises the differnce between the estimated corrected 
%correlation and meausered correlation of data set 1.
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

corr_vol = corr(vol);
corr_vol = corr_vol(:);

corr_area = corr(area);
corr_area = corr_area(:);



%estimate underlying correlations 
[cov_corrected,~, var_corrected1,var_corrected2,~,~] = estimate_noise_and_corr(thick,thick2);
corr_thick_improved = cov_corrected./sqrt(var_corrected1.*var_corrected2);
corr_thick_improved = corr_thick_improved(:);

[cov_corrected,~, var_corrected1,var_corrected2,~,~] = estimate_noise_and_corr(vol,vol2);
corr_vol_improved = cov_corrected./sqrt(var_corrected1.*var_corrected2);
corr_vol_improved = corr_vol_improved(:);

[cov_corrected,~, var_corrected1,var_corrected2,~,~] = estimate_noise_and_corr(area,area2);
corr_area_improved = cov_corrected./sqrt(var_corrected1.*var_corrected2);
corr_area_improved = corr_area_improved(:);



%plot
figure('Position',[100 100 1100 300])
subplot(1,3,1)
scatter(corr_thick,corr_thick_improved,2,'MarkerEdgeColor',[0 0 0],'MarkerEdgeAlpha', 0.4)
hold on 
attenuation_thick = find((corr_thick < corr_thick_improved));
scatter(corr_thick(attenuation_thick),corr_thick_improved(attenuation_thick),2,'MarkerEdgeColor',color,'MarkerEdgeAlpha', 0.4)
refline(1,0)
xlabel('measured correlations')
ylabel('estimated correlations')
title('Thickness')
box on 
ylim([-0.5 1])
xlim([-0.5 1])

subplot(1,3,2)
scatter(corr_vol(:),corr_vol_improved(:),2,'MarkerEdgeColor',[0 0 0],'MarkerEdgeAlpha', 0.4)
hold on
attenuation_vol = find((corr_vol < corr_vol_improved));
scatter(corr_vol(attenuation_vol),corr_vol_improved(attenuation_vol),2,'MarkerEdgeColor',color,'MarkerEdgeAlpha', 0.4)
refline(1,0)
xlabel('measured correlations')
title('Volume')
box on
ylim([-0.5 1])
xlim([-0.5 1])

subplot(1,3,3)
scatter(corr_area(:),corr_area_improved(:),2,'MarkerEdgeColor',[0 0 0],'MarkerEdgeAlpha', 0.4)
hold on
attenuation_area = find((corr_area < corr_area_improved));
scatter(corr_area(attenuation_area),corr_area_improved(attenuation_area),2,'MarkerEdgeColor',color,'MarkerEdgeAlpha', 0.4)
refline(1,0)
xlabel('measured correlations')
title('Surface area')
box on
ylim([-0.5 1])
xlim([-0.5 1])

set(findall(gcf,'-property','FontSize'),'FontSize',13)



end