function [p_value,hist_vector] = pvalue_univariate_measure(data1, data2)
%This function computes the p-value of H0: mean data 1 = mean data 2. The p-value is 
%computed with a permutation test.
%
% Arguments:
% -DATA1 - double array; data set 1
% -DATA1 - double array; data set 2
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
% Jona Carmon & Yujiang Wang, October 2019 
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
    
    %get mean
    mean1 = mean(data1);
    mean2 = mean(data2);
    
    %compute difference in means and sum up to one number 
    hist_vector(i) = sum(sum(abs(mean1 - mean2)));
    
end

%for p value
%original split
data1 = data(1:subject_num/2,:);
data2 = data(subject_num/2 + 1 : end,:);

%get correlation
mean1 = mean(data1);
mean2 = mean(data2);
corr_diff = sum(sum(abs(mean1-mean2)));

%compute overall p value
hist_vector = sort(hist_vector);
smaller = numel(find(hist_vector > sum(corr_diff)));
p_value = smaller/numel(hist_vector);



end