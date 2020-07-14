function [p_value,hist_vector,corr_diff] = pvalue_threshold(data1, data2,threshold)
%This function computes the p-value of H0: the structural covariance of 
%data 1 = data 2. The p-value is computed with a permutation test. The
%structural covariances are thresholded before estimating the p-avlue. 
%
% Arguments:
% -DATA1 - double array; data set 1
% -DATA1 - double array; data set 2
% - THRESHOLD - percentage of strongest maintained correlations 
%
% Returns:
% -P_VALUE - double array; p-value of the permutation test
% -HIST_VECTOR - double array; reference distribution of the permuation test
%
% Dependencies: 
% - NONE 
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, April 2020
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



data = [data1;data2]; %merged data for permutataion 



subject_num = numel(data(:,1));
subject_num1 = numel(data1(:,1));
%subject_num2 = numel(data2(:,1)) is not necessary to compute



for i = 1:1000
    
    %create 2 random splits of same size as original data 1 and 2
    index = randperm(subject_num);
    data1 = data(index(1:subject_num1),:);
    data2 = data(index(subject_num1 + 1 : end),:); %this is length of subject_num2 
    
    %get correlations
    corr1 = threshold_percent_absolute(corr(data1),threshold);
    corr2 = threshold_percent_absolute(corr(data2),threshold);
    
    %compute difference in correlation and sum up to one number 
    hist_vector(i) = sum(sum(abs(corr1 - corr2)));
    
end



%for p value
%original split
data1 = data(1:subject_num/2,:);
data2 = data(subject_num/2 + 1 : end,:);

%get correlation
corr1 = threshold_percent_absolute(corr(data1),threshold);
corr2 = threshold_percent_absolute(corr(data2),threshold);
corr_diff = sum(sum(abs(corr1-corr2)));

%compute overall p value
hist_vector = sort(hist_vector);
smaller = numel(find(hist_vector > sum(corr_diff)));
p_value = smaller/numel(hist_vector);



end
