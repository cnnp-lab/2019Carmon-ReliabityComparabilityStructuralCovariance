function [] = roi_size_pvalue(thick, thick2, vol, vol2, area, area2, color, tag)
%This function visualises the relationship of the mean p-value of ROIs and
%the ROI volume. The p-value is computed by H0: correlation in data set 1 =
%correlation in data set 2. The relationship is visualised for all 
%morphological measures 
%
% Arguments:
% -THICK - double array; average cortical thickness of data set 1
% -VOL - double array; volume of data set 1
% -AREA - double array; surface area of data set 1 
% -THICK2 - double array; average cortical thickness of data set 2
% -VOL2 - double array; volume of data set 2
% -AREA2 - double array; surface area of data set 2
% -COLOR - double array; color of the displayed scatter plots
% -TAG - cell array; label of scatter plots
%     
% Returns:
% figure plot
%
% Dependencies: 
%-all_pvalues
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



%roi size is defined by the mean volume of data set 1
roi_size = sum(vol)/68;



%after capturing original size as refernce we site correct data for same scale
number_hemi_brain_regions = numel(thick(1,:));
for i = 1:number_hemi_brain_regions
    thick(:,i) = site_correction(thick(:,i));
    thick2(:,i) = site_correction(thick2(:,i));
    vol(:,i) = site_correction(vol(:,i));
    vol2(:,i) = site_correction(vol2(:,i));
    area(:,i) = site_correction(area(:,i));
    area2(:,i) = site_correction(area2(:,i));
end



figure('Position', [0 0 400 1000])

%thickness
subplot(3,1,1)

%compute p-value of ROI pair
[~, all_roi_pvalues] = all_pvalues(thick,thick2);

scatter(roi_size, sum(reshape(all_roi_pvalues,[68,68]))/68, 'MarkerEdgeColor', color, 'MarkerEdgeAlpha', 0.8)
xlabel([tag])
ylabel({'Average p-value','on site corrected data'})
title('Average cortical thickness')
ylim([0 1])



%volume
subplot(3,1,2)

%compute p-value of ROI pair
[~, all_roi_pvalues] = all_pvalues(vol,vol2);

scatter(roi_size, sum(reshape(all_roi_pvalues,[68,68]))/68, 'MarkerEdgeColor', color,  'MarkerEdgeAlpha', 0.8)
xlabel([tag])
ylabel({'Average p-value','on site corrected data'})
title('Volume')
ylim([0 1])



%area
subplot(3,1,3)

%compute p-value of ROI pair
[~, all_roi_pvalues] = all_pvalues(area,area2);

scatter(roi_size, sum(reshape(all_roi_pvalues,[68,68]))/68, 'MarkerEdgeColor', color,  'MarkerEdgeAlpha', 0.8)
xlabel([tag])
ylabel({'Average p-value','on site corrected data'})
title('Surface area')
ylim([0 1])



%enlarge the font size
set(findall(gcf,'-property','FontSize'),'FontSize',13)



end