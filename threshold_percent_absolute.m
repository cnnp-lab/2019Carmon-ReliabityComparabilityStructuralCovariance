function [thresholded_matrix, thresholded_binarized_matrix] = threshold_percent_absolute(matrix, threshold)
%This function sets for the inputed matrix all correlations below a threshold 
% to 0. The threshold is computed for the absolute value. 
%Additionally it computes for this thresholded matrix its binarised
% version.
%
% Arguments:
% -MATRIX - double array; original matrix
% -THRESHOLD - double; percentage of (strongest) maintained correlations  
%
% Returns:
% -THRESHOLED_MATRIX - double array; the inputed correlation matrix with 
% all correlations below a threshold equal 0
% -THRESHOLED_BINARIZED_MATRIX - double array; the binarized version of the 
% thresholed matrix 
%
% Dependencies: 
% - NONE 
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



matrix(1:size(matrix,1)+1:end) = 0; %set diagonal to 0 
matrix= abs(matrix); %take absolute value

%compute thresholded matrix 
w = squareform(matrix); %?, 

%what is w? maybe a different name will make it clearer
[s,sid]=sort(w,'descend');
t = floor(length(s)*threshold);%top threshold kept
if t==0; t=1; end 
s(t:end)=0; %set values below threshold to 0?

w(sid)=s; %?



thresholded_matrix = squareform(w);
% put diagnonals back in again (for network measures)
thresholded_matrix(1:size(thresholded_matrix,1)+1:end)=1; 



%compute thresholded and binarized matrix
thresholded_binarized_matrix = thresholded_matrix;
thresholded_binarized_matrix(thresholded_binarized_matrix>0) = 1;



end