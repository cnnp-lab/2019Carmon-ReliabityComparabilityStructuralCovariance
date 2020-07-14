%This script computes the p-values between the structural covariance for
%various sites (8 pairs)
%
% Dependencies: 
% - pvalue_threshold
%
% Returns:
% figure plot
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, April 2020 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



clear 

%access data in supplmentary
addpath([pwd,'\supplementary'])


% all data sets  
overview_table = ...
{
'data_site_comparison_hcp_camcan60_old',     'CamCAN',   'Hcp',     'FS version + Resolution + Age'    ;
'data_site_comparison',                      'CamCAN',   'Hcp',     'FS version + Resolution'          ;
'data_site_comparison_hcp_1mm_camcan60_old', 'CamCAN',   'Hcp',     'FS version + Age'                 ;
'data_site_comparison_hcp_camcan53_old',     'CamCAN',   'Hcp',     'Resolution + Age (FS assumption)' ;
'data_site_comparison_hcp_1mm_camcan60',     'CamCAN',   'Hcp',     'FS version'                       ;
'data_site_comparison_hcp_camcan53',         'CamCAN',   'Hcp',     'Resolution (FS assumption)'       ;
'data_site_comparison_hcp_1mm_camcan53_old', 'CamCAN',   'Hcp',     'Age'                              ;
'data_site_comparison_hcp_1mm_camcan53',     'CamCAN',   'Hcp',     '-'                                ;
};



num_of_data_sets = numel(overview_table(:,1));
thresholds = 0.025:0.025:0.35;

% for j = 1:numel(thresholds)
%     for i = 1: num_of_data_sets
%         
%         load(cell2mat(overview_table(i,1)))
%         
%         rng(1)
%         p_values(i,j) = pvalue_threshold(eval(cell2mat(overview_table(i,2))).thick, ...
%             eval(cell2mat(overview_table(i,3))).thick, thresholds(j));
% 
%        x_pos(i,j) = thresholds(j);
%        y_pos(i,j) = num_of_data_sets + 1 - i; %first data set on highest row
%         
%     end
% end
% 
% save('various_effects_pvalues.mat','p_values','x_pos','y_pos')

load('various_effects_pvalues.mat')



figure('Position',[100 100 550 500])

yyaxis right
% horizontal lines
for l = 1:num_of_data_sets
    hold on
    line(thresholds,l*ones(size(thresholds)),'Color',[0 0 0])
end
hold on
scatter(x_pos(:),y_pos(:),[],p_values(:),'s','filled','SizeData',60);

ylim([0 num_of_data_sets + 1]);
xlim([min(thresholds)-0.025 max(thresholds) + 0.05])
yticks(1:num_of_data_sets)
yticklabels(fliplr(overview_table(:,4)'))
set(gca,'YColor',[0 0 0])
yyaxis left
yticks([])
xlabel('Thresholding')
title('L1 distance')
box on
%colormap for p-values
map = [
    linspace(0,0,5)',linspace(0,0,5)',linspace(0,0,5)';
    linspace(0,0.95,95)',linspace(0.6,0.95,95)',linspace(0.6,0.95,95)'
    ];
colormap(map)
caxis([0 1])
c = colorbar('Location','westoutside');
ylabel(c, 'p-value','FontSize',12);


