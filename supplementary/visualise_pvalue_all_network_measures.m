function [] = visualise_pvalue_all_network_measures(threshold_scan,raw_pvalue, thresholds_pvalue,thresholds_binarized_pvalue,color)
%This function visualises the p-values for different network  meausres 
%of the structural covariance matrix.  
%
% Arguments:
% -THRESHOLD_SCAN - double array; threshold of strongest correlations in
% the structural covariance matrix
% -RAW_PVALUE - double array; p-value of the not thresholded matrix
% -THRESHOLDS_PVALUE - double array; p-values for different thresholds
% -THRESHOLDS_BINARIZED_PVALUE - p-value for different thresholds of
% binrized matrices
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



figure('Position',[10 10 1000 1000])



%frobenius
subplot(3,3,1)
p_norm = plot(threshold_scan,thresholds_pvalue.Frobenius,'-o','Color',color)
hold on
p_bin = plot(threshold_scan,thresholds_binarized_pvalue.Frobenius,'--o','Color',color./1.2)
title(['L1, raw p-value = ' num2str(raw_pvalue.Frobenius)])
ylabel('p value')
%p-value significance threshold at 0.05
p_sign = plot([threshold_scan(1) threshold_scan(end)],[0.05 0.05],'-r')
legend([p_norm, p_bin],{'thresholded','thresholded + binarized'})
ylim([0 1])



%clustering coefficient
subplot(3,3,5)
p_norm = plot(threshold_scan,thresholds_pvalue.Clustering,'-o','Color',color)
hold on
p_bin = plot(threshold_scan,thresholds_binarized_pvalue.Clustering,'--o','Color',color./1.2)
title(['Clustering Coefficient, raw p-value = ' num2str(raw_pvalue.Clustering)])
%p-value significance threshold at 0.05
p_sign = plot([threshold_scan(1) threshold_scan(end)],[0.05 0.05],'-r')
legend([p_norm, p_bin],{'thresholded','thresholded + binarized'})
ylim([0 1])



%Charactersitic Path
subplot(3,3,4)
p_norm = plot(threshold_scan,thresholds_pvalue.Charpath,'-o','Color',color)
hold on
p_bin = plot(threshold_scan,thresholds_binarized_pvalue.Charpath,'--o','Color',color./1.2)
title(['Characteristic Path, raw p-value = ' num2str(raw_pvalue.Charpath)])
%p-value significance threshold at 0.05
p_sign = plot([threshold_scan(1) threshold_scan(end)],[0.05 0.05],'-r')
legend([p_norm, p_bin],{'thresholded','thresholded + binarized'})
ylim([0 1])
ylabel('p value')



%Global Efficiency
subplot(3,3,3)
p_norm = plot(threshold_scan,thresholds_pvalue.GlobalEff,'-o','Color',color)
hold on
p_bin = plot(threshold_scan,thresholds_binarized_pvalue.GlobalEff,'--o','Color',color./1.2)
title(['Global Efficiency, raw p-value = ' num2str(raw_pvalue.GlobalEff)])
%p-value significance threshold at 0.05
p_sign = plot([threshold_scan(1) threshold_scan(end)],[0.05 0.05],'-r')
legend([p_norm, p_bin],{'thresholded','thresholded + binarized'})
ylim([0 1])



%Node strength
subplot(3,3,2)
p_norm = plot(threshold_scan,thresholds_pvalue.NodeStrength,'-o','Color',color)
hold on
p_bin = plot(threshold_scan,thresholds_binarized_pvalue.NodeStrength,'--o','Color',color./1.2)
title(['Node strength, raw p-value = ' num2str(raw_pvalue.NodeStrength)])
%p-value significance threshold at 0.05
p_sign = plot([threshold_scan(1) threshold_scan(end)],[0.05 0.05],'-r')
legend([p_norm, p_bin],{'thresholded','thresholded + binarized'})
ylim([0 1])



%Assortativity 
subplot(3,3,6)
p_norm = plot(threshold_scan,thresholds_pvalue.Assortativity,'-o','Color',color)
hold on
p_bin = plot(threshold_scan,thresholds_binarized_pvalue.Assortativity,'--o','Color',color./1.2)
title(['Assortativity, raw p-value = ' num2str(raw_pvalue.Assortativity)])
xlabel('Thresholding')
%p-value significance threshold at 0.05
hold on
p_sign = plot([threshold_scan(1) threshold_scan(end)],[0.05 0.05],'-r')
legend([p_norm, p_bin],{'thresholded','thresholded + binarized'})
ylim([0 1])



%Eigenvector centrality
subplot(3,3,7)
p_norm = plot(threshold_scan,thresholds_pvalue.EVC,'-o','Color',color)
title(['Eigenvector Centrality, raw p-value = ' num2str(raw_pvalue.EVC)])
xlabel('Thresholding')
ylabel('p value')
%p-value significance threshold at 0.05
hold on
p_sign = plot([threshold_scan(1) threshold_scan(end)],[0.05 0.05],'-r')
legend(p_norm,{'thresholded'})
ylim([0 1])



%k Core Centrality
subplot(3,3,8)
p_bin = plot(threshold_scan,thresholds_binarized_pvalue.kcoreCentr,'--o','Color',color./1.2)
title(['k Core Centrality, raw p-value = -'])
xlabel('Thresholding')
%p-value significance threshold at 0.05
hold on
p_sign = plot([threshold_scan(1) threshold_scan(end)],[0.05 0.05],'-r')
legend(p_bin,{'thresholded + binarized'})
ylim([0 1])



end