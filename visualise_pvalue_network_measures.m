function [] = visualise_pvalue_network_measures(threshold_scan,raw_pvalue, thresholds_pvalue,thresholds_binarized_pvalue,color)
%This function visualises the p-values for different network measures 
%of the comparison of two structural covariance matrix.  
%
% Arguments:
% -THRESHOLD_SCAN - double array; threshold of strongest correlations in
% the structural covariance matrix
% -RAW_PVALUE - double array; p-value of the not thresholded matrix
% -THRESHOLDS_PVALUE - double array; p-values for different thresholds
% -THRESHOLDS_BINARIZED_PVALUE - p-value for different thresholds of
% binarised matrices
% -COLOR - double array; color of the graphs
%
% Returns:
% figure plot
%
% Dependencies: 
% - NONE 
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



figure('Position',[100 100 700 600])



%frobenius, the frobenius distance is strictly speaking the L1 distance
%because of norm 1. 
subplot(2,2,1)
p_norm = plot(threshold_scan,thresholds_pvalue.Frobenius,'-o','Color',color);
hold on
p_bin = plot(threshold_scan,thresholds_binarized_pvalue.Frobenius,'--o','Color',color./1.2);
title(['L1, raw p-value = ' num2str(raw_pvalue.Frobenius)])
%p-value significance threshold at 0.05
p_sign = plot([threshold_scan(1) threshold_scan(end)],[0.05 0.05],'-r');
legend([p_norm, p_bin],{'thresholded','thresholded + binarized'})
ylim([0 1])
ylabel('p value')



%clustering coefficient
subplot(2,2,4)
p_norm = plot(threshold_scan,thresholds_pvalue.Clustering,'-o','Color',color);
hold on
p_bin = plot(threshold_scan,thresholds_binarized_pvalue.Clustering,'--o','Color',color./1.2);
title(['Clustering Coefficient, raw p-value = ' num2str(raw_pvalue.Clustering)])
%p-value significance threshold at 0.05
p_sign = plot([threshold_scan(1) threshold_scan(end)],[0.05 0.05],'-r');
legend([p_norm, p_bin],{'thresholded','thresholded + binarized'})
ylim([0 1])
xlabel('Thresholding')



%Charactersitic Path
subplot(2,2,3)
p_norm = plot(threshold_scan,thresholds_pvalue.Charpath,'-o','Color',color);
hold on
p_bin = plot(threshold_scan,thresholds_binarized_pvalue.Charpath,'--o','Color',color./1.2);
title(['Characteristic Path, raw p-value = ' num2str(raw_pvalue.Charpath)])
%p-value significance threshold at 0.05
p_sign = plot([threshold_scan(1) threshold_scan(end)],[0.05 0.05],'-r');
legend([p_norm, p_bin],{'thresholded','thresholded + binarized'})
ylim([0 1])
xlabel('Thresholding')
ylabel('p value')



%Node strength
subplot(2,2,2)
p_norm = plot(threshold_scan,thresholds_pvalue.NodeStrength,'-o','Color',color);
hold on
p_bin = plot(threshold_scan,thresholds_binarized_pvalue.NodeStrength,'--o','Color',color./1.2);
title(['Node strength, raw p-value = ' num2str(raw_pvalue.NodeStrength)])
%p-value significance threshold at 0.05
p_sign = plot([threshold_scan(1) threshold_scan(end)],[0.05 0.05],'-r');
legend([p_norm, p_bin],{'thresholded','thresholded + binarized'})
ylim([0 1])



end