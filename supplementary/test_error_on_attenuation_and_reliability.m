function [] = test_error_on_attenuation_and_reliability(corr_strength_strong, corr_strength_weak, weak_noise,strong_noise,...
iterations)
%This function computes the effect of error on attenuation and reliability
%on simulated data. Additonally it computes and visualzes for the simulated 
%data the estimates of the error variance and covariance and the underlying 
%correlation.  
%Four intial correlations (2 genertaed variables per correlation) are computed 
%(2 strong correlations, 2 weak correlations). These four correlations simulate 
%the ground truth. To each of this correlations noise (strong or weak) is 
%added twice independently. The two by that generated versions of each 
%intial correlation should correspond to the meuasered correlations of two 
%sites (like of HCP scan and rescan).  
%
% Arguments:
% -CORR_STREGNTH_STRONG - double; strength of intial strong correlation
% -CORR_STREGNTH_WEAK - double; strength of intial weak correlation
% -WEAK_NOISE - double; strength of (weak) noise added to the correlations
% -STRONG_NOISE - double; strength of (strong) noise added to the correlations
% -ITERATIONS - integer; number of iterations of the simulation
%
% Returns:
% - figure plot
%
% Dependencies: 
% - estimate_noise_and_corr
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



%generate data
%data 1
data = mvnrnd([0 0],[1 corr_strength_strong; corr_strength_strong 1],1000);
region1_random_data1 = data(:,1);
region2_random_data1 = data(:,2);

%data 2
region1_random_data2 = region1_random_data1;
region2_random_data2 = region2_random_data1;

%data 3
data = mvnrnd([0 0],[1 corr_strength_weak; corr_strength_weak 1],1000);
region1_random_data3 = data(:,1);
region2_random_data3 = data(:,2);

%data 4
region1_random_data4 = region1_random_data3;
region2_random_data4 = region2_random_data3;



%compute true underlying correlations 
real_corr_data1 = corr(region1_random_data1,region2_random_data1);
real_corr_data2 = corr(region1_random_data2,region2_random_data2);
real_corr_data3 = corr(region1_random_data3,region2_random_data3);
real_corr_data4 = corr(region1_random_data4,region2_random_data4);



for index=1:iterations 

%data 1 
%region 1
noise = strong_noise*randn([1000,1]); 
region1_measurement1_data1 = region1_random_data1 + noise;
noise = strong_noise*randn([1000,1]); 
region1_measurement2_data1 = region1_random_data1 + noise;
%region 2
noise = strong_noise*randn([1000,1]); 
region2_measurement1_data1 = region2_random_data1 + noise;
noise = strong_noise*randn([1000,1]); 
region2_measurement2_data1 = region2_random_data1 + noise;
%measured correlations
measured1_corr_data1(index)=corr(region1_measurement1_data1,region2_measurement1_data1);
measured2_corr_data1(index)=corr(region1_measurement2_data1,region2_measurement2_data1);

%data 2 
%region 1
noise = weak_noise*randn([1000,1]); 
region1_measurement1_data2 = region1_random_data2 + noise;
noise = weak_noise*randn([1000,1]); 
region1_measurement2_data2 = region1_random_data2 + noise;
noise = weak_noise*randn([1000,1]); 
%region 2
region2_measurement1_data2 = region2_random_data2 + noise;
noise = weak_noise*randn([1000,1]); 
%measured correlations
region2_measurement2_data2 = region2_random_data2 + noise;
measured1_corr_data2(index)=corr(region1_measurement1_data2,region2_measurement1_data2);
measured2_corr_data2(index)=corr(region1_measurement2_data2,region2_measurement2_data2);

%data 3 
%region 1
noise = strong_noise*randn([1000,1]); 
region1_measurement1_data3 = region1_random_data3 + noise;
noise = strong_noise*randn([1000,1]); 
region1_measurement2_data3 = region1_random_data3 + noise;
noise = strong_noise*randn([1000,1]); 
%region 2
region2_measurement1_data3 = region2_random_data3 + noise;
noise = strong_noise*randn([1000,1]); 
%measured correlations
region2_measurement2_data3 = region2_random_data3 + noise;
measured1_corr_data3(index)=corr(region1_measurement1_data3,region2_measurement1_data3);
measured2_corr_data3(index)=corr(region1_measurement2_data3,region2_measurement2_data3);

%data 4
%region 1
noise = weak_noise*randn([1000,1]); 
region1_measurement1_data4 = region1_random_data4 + noise;
noise = weak_noise*randn([1000,1]); 
region1_measurement2_data4 = region1_random_data4 + noise;
noise = weak_noise*randn([1000,1]); 
%region 2
region2_measurement1_data4 = region2_random_data4 + noise;
noise = weak_noise*randn([1000,1]); 
%measured correlations
region2_measurement2_data4 = region2_random_data4 + noise;
measured1_corr_data4(index)=corr(region1_measurement1_data4,region2_measurement1_data4);
measured2_corr_data4(index)=corr(region1_measurement2_data4,region2_measurement2_data4);



%try to recover the underlying correlation

%data 1
[cov_xy,cov_error, var_x,var_y,~,var_error] = estimate_noise_and_corr([region1_measurement1_data1,region2_measurement1_data1],...
    [region1_measurement2_data1,region2_measurement2_data1]);
corr_xy = cov_xy./sqrt(var_x.*var_y);
estimated_corr_data1(index) = corr_xy(1,2);
cov_error_data1(index) = cov_error(1,2);
var_error_data1(index) = (var_error(1,2) + var_error(1,1))/2;

%data 2
[cov_xy,cov_error, var_x,var_y,~,var_error] = estimate_noise_and_corr([region1_measurement1_data2,region2_measurement1_data2],...
    [region1_measurement2_data2,region2_measurement2_data2]);
corr_xy = cov_xy./sqrt(var_x.*var_y);
estimated_corr_data2(index) = corr_xy(1,2);
cov_error_data2(index) = cov_error(1,2);
var_error_data2(index) = (var_error(1,2) + var_error(1,1))/2;

%data 3
[cov_xy,cov_error, var_x,var_y,~,var_error] = estimate_noise_and_corr([region1_measurement1_data3,region2_measurement1_data3],...
    [region1_measurement2_data3,region2_measurement2_data3]);
corr_xy = cov_xy./sqrt(var_x.*var_y);
estimated_corr_data3(index) = corr_xy(1,2);
cov_error_data3(index) = cov_error(1,2);
var_error_data3(index) = (var_error(1,2) + var_error(1,1))/2;

%data 4
[cov_xy,cov_error, var_x,var_y,~,var_error] = estimate_noise_and_corr([region1_measurement1_data4,region2_measurement1_data4],...
    [region1_measurement2_data4,region2_measurement2_data4]);
corr_xy = cov_xy./sqrt(var_x.*var_y);
estimated_corr_data4(index) = corr_xy(1,2);
cov_error_data4(index) = cov_error(1,2);
var_error_data4(index) = (var_error(1,2) + var_error(1,1))/2;

end



%attenuation and unreliability
%computed with measurment 1. For sufficient iterations these computations 
%should be the same for measurement 2
attenuation_data1 = real_corr_data1 - mean(measured1_corr_data1);%attenuation
unreliality_data1 = std(measured1_corr_data1); % unreliability

attenuation_data2 = real_corr_data2 - mean(measured1_corr_data2);%attenuation
unreliality_data2 = std(measured1_corr_data2); % unreliability

attenuation_data3 = real_corr_data3 - mean(measured1_corr_data3);%attenuation
unreliality_data3 = std(measured1_corr_data3); % unreliability

attenuation_data4 = real_corr_data4 - mean(measured1_corr_data4);%attenuation
unreliality_data4 = std(measured1_corr_data4); % unreliability



%plot the properties
figure('Position', [50 50 700 500])



%first group
%data 1
scatter(0.75,real_corr_data1,'o','MarkerEdgeColor',[0 0 0],'LineWidth',1)
hold on
errorbar(1.25,mean(estimated_corr_data1),std(estimated_corr_data1),'o','LineWidth',1,'Color',[0.6 0.6 0.6])
hold on 
errorbar(0,mean(measured1_corr_data1),std(measured1_corr_data1),'o','LineWidth',1,'Color',[0 0 0])
hold on 
errorbar(2,mean(measured2_corr_data1),std(measured2_corr_data1),'o','LineWidth',1,'Color',[0 0 0])

%data 2
scatter(3.75,real_corr_data2,'o','MarkerEdgeColor',[0 0 0],'LineWidth',1)
hold on
errorbar(4.25,mean(estimated_corr_data2),std(estimated_corr_data2),'o','LineWidth',1,'Color',[0.6 0.6 0.6])
hold on 
errorbar(3,mean(measured1_corr_data2),std(measured1_corr_data2),'o','LineWidth',1,'Color',[0 0 0])
hold on 
errorbar(5,mean(measured2_corr_data2),std(measured2_corr_data2),'o','LineWidth',1,'Color',[0 0 0])



%second group
%data 3
scatter(10.75,real_corr_data3,'o','MarkerEdgeColor',[0 0 0],'LineWidth',1)
hold on
errorbar(11.25,mean(estimated_corr_data3),std(estimated_corr_data3),'o','LineWidth',1,'Color',[0.6 0.6 0.6])
hold on 
errorbar(10,mean(measured1_corr_data3),std(measured1_corr_data3),'o','LineWidth',1,'Color',[0 0 0])
hold on 
errorbar(12,mean(measured2_corr_data3),std(measured2_corr_data3),'o','LineWidth',1,'Color',[0 0 0])


%data 4
scatter(14.75,real_corr_data4,'o','MarkerEdgeColor',[0 0 0],'LineWidth',1)
hold on
errorbar(15.25,mean(estimated_corr_data4),std(estimated_corr_data4),'o','LineWidth',1,'Color',[0.6 0.6 0.6])
hold on 
errorbar(14,mean(measured1_corr_data4),std(measured1_corr_data4),'o','LineWidth',1,'Color',[0 0 0])
hold on 
errorbar(16,mean(measured2_corr_data4),std(measured2_corr_data4),'o','LineWidth',1,'Color',[0 0 0])



box on
ylabel('correlation strength')
xticks([0 4 11 15])
xticklabels({'++', '+-', '-+','--'})
xlim([-2 17])
ylim([0.2 0.8])



%print standard deviation of correlations (= reliability)
title(['std measured corr (unrleiability): left = ', num2str(unreliality_data1), ' middle =', ...
    num2str(unreliality_data2),' right = ', num2str(unreliality_data3),...
    ' far right = ', num2str(unreliality_data4)])



%print mean errors
xlabel({['error percentage: strong = ', num2str(strong_noise),' weak = ',num2str(weak_noise),...
    '    attenuation: left = ', num2str(attenuation_data1), ' middle = ', num2str(attenuation_data2),...
    ' right = ', num2str(attenuation_data3), ' far right = ', num2str(attenuation_data4)],...
    ['var error: left = ', num2str(mean(var_error_data1)),' middle = ', num2str(mean(var_error_data2)), ...
    ' right = ' ,num2str(mean(var_error_data3)),' far right = ' ,num2str(mean(var_error_data4))]...
    ,['abs cov error: left = ', num2str(mean(abs(cov_error_data1))),' middle = ', ...
    num2str(mean(abs(cov_error_data2))),' right = ' ,num2str(mean(abs(cov_error_data3))),...
    ' far right = ' ,num2str(mean(abs(cov_error_data4)))]})



end