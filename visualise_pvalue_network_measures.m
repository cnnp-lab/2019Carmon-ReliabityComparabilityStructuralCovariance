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



figure('Position',[100 100 1357 365])



%frobenius, the frobenius distance is strictly speaking the L1 distance
%because of norm 1. 
subplot(1,4,1)
p_norm = plot(threshold_scan,thresholds_pvalue.Frobenius,'-s','Color',color,'MarkerFaceColor',color);
hold on
p_bin = plot(threshold_scan,thresholds_binarized_pvalue.Frobenius,'-o','Color',color./1.2);

% color code significant p-values in black
index_significant = find(0.05>thresholds_pvalue.Frobenius);
plot(threshold_scan(index_significant),thresholds_pvalue.Frobenius(index_significant)...
    ,'s','Color',[0 0 0],'MarkerFaceColor',[0 0 0])
index_significant = find(0.05>thresholds_binarized_pvalue.Frobenius);
plot(threshold_scan(index_significant),thresholds_binarized_pvalue.Frobenius(index_significant)...
    ,'o','Color',[0 0 0])

title('L1 distance')
%p-value significance threshold at 0.05
p_sign = plot([threshold_scan(1)-0.025, threshold_scan(end) + 0.05],[0.05 0.05],'-k');
hold on
p_raw = plot(NaN,NaN, 'linestyle', 'none'); % place holder in legend
text_raw_pvlaue =  ['unthresholded p-value = ' num2str(round(raw_pvalue.Frobenius,2))];
legend([p_norm, p_bin,p_raw],{'thresholded','thresholded + binarised',text_raw_pvlaue},'Location','southoutside')
ylim([0 1])
xlabel('Thresholding')
ylabel('p value')





%clustering coefficient
subplot(1,4,2)
p_norm = plot(threshold_scan,thresholds_pvalue.Clustering,'-s','Color',color,'MarkerFaceColor',color);
hold on
p_bin = plot(threshold_scan,thresholds_binarized_pvalue.Clustering,'-o','Color',color./1.2);

% color code significant p-values in black
index_significant = find(0.05>thresholds_pvalue.Clustering);
plot(threshold_scan(index_significant),thresholds_pvalue.Clustering(index_significant)...
    ,'s','Color',[0 0 0],'MarkerFaceColor',[0 0 0])
index_significant = find(0.05>thresholds_binarized_pvalue.Clustering);
plot(threshold_scan(index_significant),thresholds_binarized_pvalue.Clustering(index_significant)...
    ,'o','Color',[0 0 0])

title('Clustering Coefficient')
%p-value significance threshold at 0.05
p_sign = plot([threshold_scan(1)-0.025, threshold_scan(end)+0.05],[0.05 0.05],'-k');
hold on
p_raw = plot(NaN,NaN, 'linestyle', 'none'); % place holder in legend
text_raw_pvlaue =  ['unthresholded p-value = ' num2str(round(raw_pvalue.Clustering,2))];
legend([p_norm, p_bin,p_raw],{'thresholded','thresholded + binarised',text_raw_pvlaue},'Location','southoutside')
ylim([0 1])
xlabel('Thresholding')
yticks([])



%Charactersitic Path
subplot(1,4,3)
p_norm = plot(threshold_scan,thresholds_pvalue.Charpath,'-s','Color',color,'MarkerFaceColor',color);
hold on
p_bin = plot(threshold_scan,thresholds_binarized_pvalue.Charpath,'-o','Color',color./1.2);

% color code significant p-values in black
index_significant = find(0.05>thresholds_pvalue.Charpath);
plot(threshold_scan(index_significant),thresholds_pvalue.Charpath(index_significant)...
    ,'s','Color',[0 0 0],'MarkerFaceColor',[0 0 0])
index_significant = find(0.05>thresholds_binarized_pvalue.Charpath);
plot(threshold_scan(index_significant),thresholds_binarized_pvalue.Charpath(index_significant)...
    ,'o','Color',[0 0 0])

title('Characteristic Path')
%p-value significance threshold at 0.05
p_sign = plot([threshold_scan(1)-0.025, threshold_scan(end)+0.05],[0.05 0.05],'-k');
hold on
p_raw = plot(NaN,NaN, 'linestyle', 'none'); % place holder in legend
text_raw_pvlaue =  ['unthresholded p-value = ' num2str(round(raw_pvalue.Charpath,2))];
legend([p_norm, p_bin,p_raw],{'thresholded','thresholded + binarised',text_raw_pvlaue},'Location','southoutside')
ylim([0 1])
xlabel('Thresholding')
yticks([])



%Node strength
subplot(1,4,4)
p_norm = plot(threshold_scan,thresholds_pvalue.NodeStrength,'-s','Color',color,'MarkerFaceColor',color);
hold on
p_bin = plot(threshold_scan,thresholds_binarized_pvalue.NodeStrength,'-o','Color',color./1.2);

% color code significant p-values in black
index_significant = find(0.05>thresholds_pvalue.NodeStrength);
plot(threshold_scan(index_significant),thresholds_pvalue.NodeStrength(index_significant)...
    ,'s','Color',[0 0 0],'MarkerFaceColor',[0 0 0])
index_significant = find(0.05>thresholds_binarized_pvalue.NodeStrength);
plot(threshold_scan(index_significant),thresholds_binarized_pvalue.NodeStrength(index_significant)...
    ,'o','Color',[0 0 0])

title('Node strength')
%p-value significance threshold at 0.05
p_sign = plot([threshold_scan(1)-0.025, threshold_scan(end)+0.05],[0.05 0.05],'-k');
hold on
p_raw = plot(NaN,NaN, 'linestyle', 'none'); % place holder in legend
text_raw_pvlaue =  ['unthresholded p-value = ' num2str(round(raw_pvalue.NodeStrength,2))];
legend([p_norm, p_bin,p_raw],{'thresholded','thresholded + binarised',text_raw_pvlaue},'Location','southoutside')
ylim([0 1])
xlabel('Thresholding')
yticks([])



end