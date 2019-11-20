function [overall_p_value,corr_p_values,hist_vector] = all_pvalues(data1,data2)
%This function computes the p-value of H0: the structural covariance of 
%data 1 = data 2. Additionally it also computes the p-value of each ROI pair. 
%The p-values are computed with a permutation test.
%
% Arguments:
% -DATA1 - double array; data set 1
% -DATA1 - double array; data set 2
%
% Returns:
% -OVERALL_P_VALUE - double array; p-value of the structural covariance
% -CORR_P_VALUE - double array; p-value of ROI pairs
% -HIST_VECTOR - double array; reference distribution of the permuation test
% (each column is the reference distribution of one ROI pair)
%
% Dependencies: 
% - NONE 
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



data = [data1;data2]; %merged data for permutataion 



subject_num = numel(data(:,1));
subject_num1 = numel(data1(:,1));
%subject_num2 = numel(data2(:,1)) is not necessary to compute



for i = 1:1000
    
    %create 2 random splits of same size
    index = randperm(subject_num);
    data1 = data(index(1:subject_num1),:);
    data2 = data(index(subject_num1 + 1 : end),:);
    
    %get correlation 
    corr1_val = corr(data1);
    corr2_val = corr(data2);
    corr1 = corr1_val(:);
    corr2 = corr2_val(:);
    
    %compute difference in correlation
    hist_vector(:,i) = abs(corr1 - corr2).';
    
end



%for p value
%original split
data1 = data(1:subject_num1,:);
data2 = data(subject_num1 + 1 : end,:);

%get correlation
corr1_val = corr(data1);
corr2_val = corr(data2);
corr1 = corr1_val(:);
corr2 = corr2_val(:);
corr_diff = abs(corr1-corr2);

%compute overall p value
summed_hist_vector = sum(hist_vector);
summed_hist_vector = sort(summed_hist_vector);
smaller = numel(find(summed_hist_vector > sum(corr_diff)));
overall_p_value = smaller/numel(summed_hist_vector);



%compute p value per correlation
for specific_corr = 1:numel(data1(1,:))*numel(data1(1,:))
    corr_hist_vector = hist_vector(specific_corr,:);
    corr_hist_vector = sort(corr_hist_vector);
    smaller = numel(find(corr_hist_vector > corr_diff(specific_corr)));
    corr_p_values(specific_corr) = smaller/numel(corr_hist_vector);
end



end