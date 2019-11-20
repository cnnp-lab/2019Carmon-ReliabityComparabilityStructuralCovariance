function [cov_corrected,cov_error, var_corrected1,var_corrected2,var_error1,var_error2] = estimate_noise_and_corr(data1,data2)
%This function estimates the error varaince, error covaraince, underlying 
%varaince and undelying covaraince for data 1. 
%The code is computationally very inefficient which is in faviour of the 
%readability. 
%
% Arguments:
% -DATA1 - double array; data set 1
% -DATA2 - double array; data set 2
%     
% Returns:
% -COV_CORRECTED - double array; corrected covariance of data set 1
% -COV_ERROR - double array; error covaraince of data set 1
% -VAR_CORRECTED1 - double array; corrected variance of data set 1
% -VAR_CORRECTED2 - double array; corrected variance of data set 1 
%var corrected1 = var_corrected2.'. But because of corrected correlations =
% cov_corrected./sqrt(var_corrected1.*var_corrected2) we compute for better
%readability both variables. 
% -VAR_ERROR1 - double array; error variance of data set 1 
% -VAR_ERROR2 - double array; error variance of data set 1. For the same
% reason of above we compute both error variance variables. 
%
% Dependencies: 
% -NONE
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



number_brain_regions = numel(data1(1,:));
temp = zeros([number_brain_regions,number_brain_regions]);
var_error1 = temp;
var_error2 = temp;
cov_error = temp;
var_corrected1= temp;
var_corrected2= temp;
cov_corrected = temp;



for region1 = 1:number_brain_regions
    
    for region2 = 1:number_brain_regions
        
        a_1 = var(data1(:,region1)-data2(:,region1));
        b_1 = var(data1(:,region1));
        c_1 = var(data2(:,region1));
        
        a_2 = var(data1(:,region2)-data2(:,region2));
        b_2 = var(data1(:,region2));
        c_2 = var(data2(:,region2));
        
        d = cov(data1(:,region1),data1(:,region2));
        d = d(1,2);
        e = cov(data2(:,region1),data2(:,region2));
        e = e(1,2);
        f = cov(data1(:,region1) - data2(:,region1), data1(:,region2)-data2(:,region2));
        f = f(1,2);
        
        %var(E1)
        var_e1 = b_1/2 - c_1/2 + 1/2*a_1;
        %var(E2) not estimated
        %var_e2 = - b_1/2 + c_1/2 + 1/2*a_1;
        
        %var(D1)
        var_d1 = b_2/2 - c_2/2 + 1/2*a_2;
        %var(D2) not estimated
        
        %var(region 1)
        var_region1 = c_1/2 +b_1/2 - 1/2*a_1;
        %var(region 2)
        var_region2 = c_2/2 + b_2/2 - 1/2*a_2;
        
        %cov(E1,D1)
        cov_e1d1 = d/2 - e/2 + f/2;
        %cov(E2,D2) not estimated
        cov_e2d2 = -d/2 + e/2 +f/2;
        
        %cov(region 1,region 2)
        cov_12 = d/2 + e/2 - f/2;

        
        
        %save estimates 
        var_error1(region1,region2) = var_e1;
        var_error2(region1,region2) = var_d1;
        cov_error(region1,region2) = cov_e1d1;
        var_corrected1(region1,region2) = var_region1;
        var_corrected2(region1,region2) = var_region2;
        cov_corrected(region1,region2) = cov_12; 
        
    end
    
end



end