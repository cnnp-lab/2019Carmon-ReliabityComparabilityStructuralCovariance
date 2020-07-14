function [] = diff_in_resolutions(HCP,HCP1mm, HCP1_5mm,HCP2mm)
%This function visualises the difference between the structural covariance
%of normal HCP compared to downsampled versions (1mm, 1.5mm and 2mm). 
%
% Arguments:
% -HCP - struct; all measures of normal HCP
% -HCP1mm - struct; all measures of HCP downsampled to 1mm
% -HCP1_5mm - struct; all measures of HCP downsampled to 1.5mm
% -HCP2mm - struct; all measures of HCP downsampled to 2mm
%
% Returns:
% figure plot
%
% Dependencies: 
%-NONE
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, April 2020 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



% covariance matrices of normal HCP
thick_hcp_normal = corr(HCP.thick);
vol_hcp_normal = corr(HCP.vol);
area_hcp_normal = corr(HCP.area);

% differnces to downsampled versions
diff_thick(1) = sum(sum(abs(thick_hcp_normal - corr(HCP1mm.thick))));
diff_thick(2) = sum(sum(abs(thick_hcp_normal - corr(HCP1_5mm.thick))));
diff_thick(3) = sum(sum(abs(thick_hcp_normal - corr(HCP2mm.thick))));

diff_vol(1) = sum(sum(abs(vol_hcp_normal - corr(HCP1mm.vol))));
diff_vol(2) = sum(sum(abs(vol_hcp_normal - corr(HCP1_5mm.vol))));
diff_vol(3) = sum(sum(abs(vol_hcp_normal - corr(HCP2mm.vol))));

diff_area(1) = sum(sum(abs(area_hcp_normal - corr(HCP1mm.area))));
diff_area(2) = sum(sum(abs(area_hcp_normal - corr(HCP1_5mm.area))));
diff_area(3) = sum(sum(abs(area_hcp_normal - corr(HCP2mm.area))));



% plot all differnces
figure
plot([1 2 3],diff_thick,'-ok','Color',[0 0 0])
hold on
plot([1 2 3],diff_vol,'--ok','Color',[0 0 0])
hold on
plot([1 2 3],diff_area,':ok','Color',[0 0 0])
legend('thickness', 'volume', 'surface area', 'Location', 'northwest')
xticks([1,2,3])
xticklabels(["1mm","1.5mm","2mm"])
xlabel('Downsampled HCP')
ylabel('Difference to normal HCP')
ylim([100 650])



end