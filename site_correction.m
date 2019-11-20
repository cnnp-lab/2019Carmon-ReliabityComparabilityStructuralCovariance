function [data_corrected] = site_correction(data)
%This function computes site correction (mean = 0, std = 1) for a given data set
%
% Arguments:
% -DATA - double array; data set 1
%
% Returns:
% -DATA_CORRECTED - double array; site corrected data
%
% Dependencies: 
% - NONE 
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



% set mean = 0
data_corrected = data - mean(data);
% set std = 1
data_corrected = data_corrected/std(data_corrected);



end