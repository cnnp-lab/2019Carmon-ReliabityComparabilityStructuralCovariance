function [] = simulate_error_effect_on_attenuation_and_reliability(corr_strength_strong, corr_strength_weak, weak_noise,strong_noise,...
    iterations)
%This function computes the effect of error on attenuation and reliability
%on simulated data. 
%Four intial correlations (2 simulated variables per correlation) are computed 
%(2 strong correlations, 2 weak correlations). These four correlations simulate 
%the ground truth. 
%We simulate strong correlation + strong noise,
%strong correlation + weak noise,
%weak correlation + strong noise,
%weak correlation + weak noise.
%
% Arguments:
% -CORR_STREGNTH_STRONG - double; strength of intial strong correlation
% -CORR_STREGNTH_WEAK - double; strength of intial weak correlation
% -WEAK_NOISE - double; strength of weak noise added to the correlations
% -STRONG_NOISE - double; strength of strong noise added to the correlations
% -ITERATIONS - integer; number of iterations of the simulation

% Returns:
% - figure plot
%
% Dependencies: 
% - NONE
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



%compute "true" underlying correlations 
real_corr_data1 = corr(region1_random_data1,region2_random_data1);
real_corr_data2 = corr(region1_random_data2,region2_random_data2);
real_corr_data3 = corr(region1_random_data3,region2_random_data3);
real_corr_data4 = corr(region1_random_data4,region2_random_data4);



%add noise to the variables and measure the correlations with added noise
for index=1:iterations 

%data 1 
noise = strong_noise*randn([1000,1]); 
region1_measurement_data1 = region1_random_data1 + noise;
noise = strong_noise*randn([1000,1]); 
region2_measurement_data1 = region2_random_data1 + noise;
measured_corr_data1(index)=corr(region1_measurement_data1,region2_measurement_data1);

%data 2 
noise = weak_noise*randn([1000,1]); 
region1_measurement_data2 = region1_random_data2 + noise;
noise = weak_noise*randn([1000,1]); 
region2_measurement_data2 = region2_random_data2 + noise;
measured_corr_data2(index)=corr(region1_measurement_data2,region2_measurement_data2);

%data 3 
noise = strong_noise*randn([1000,1]); 
region1_measurement_data3 = region1_random_data3 + noise;
noise = strong_noise*randn([1000,1]); 
region2_measurement_data3 = region2_random_data3 + noise;
measured_corr_data3(index)=corr(region1_measurement_data3,region2_measurement_data3);

%data 2 
noise = weak_noise*randn([1000,1]); 
region1_measurement_data4 = region1_random_data4 + noise;
noise = weak_noise*randn([1000,1]); 
region2_measurement_data4 = region2_random_data4 + noise;
measured_corr_data4(index)=corr(region1_measurement_data4,region2_measurement_data4);

end



%compute the attenuation and unreliability 
attenuation_data1 = real_corr_data1 - mean(measured_corr_data1);%attenuation
unreliality_data1 = std(measured_corr_data1); % unreliability

attenuation_data2 = real_corr_data2 - mean(measured_corr_data2);%attenuation
unreliality_data2 = std(measured_corr_data2); % unreliability

attenuation_data3 = real_corr_data3 - mean(measured_corr_data3);%attenuation
unreliality_data3 = std(measured_corr_data3); % unreliability

attenuation_data4 = real_corr_data4 - mean(measured_corr_data4);%attenuation
unreliality_data4 = std(measured_corr_data4); % unreliability



%plot the properties
figure('Position', [50 50 700 500])



%first group
%data 1
scatter(1,real_corr_data1,'o','MarkerEdgeColor',[0 0 0],'LineWidth',1)
hold on 
errorbar(1,mean(measured_corr_data1),std(measured_corr_data1),'o','LineWidth',1,'Color',[0 0 0])

%data 2
scatter(4,real_corr_data2,'o','MarkerEdgeColor',[0 0 0],'LineWidth',1)
hold on 
errorbar(4,mean(measured_corr_data2),std(measured_corr_data2),'o','LineWidth',1,'Color',[0 0 0])



%second group
%data 3
scatter(11,real_corr_data3,'o','MarkerEdgeColor',[0 0 0],'LineWidth',1)
hold on 
errorbar(11,mean(measured_corr_data3),std(measured_corr_data3),'o','LineWidth',1,'Color',[0 0 0])

%data 4
scatter(15,real_corr_data4,'o','MarkerEdgeColor',[0 0 0],'LineWidth',1)
hold on 
errorbar(15,mean(measured_corr_data4),std(measured_corr_data4),'o','LineWidth',1,'Color',[0 0 0])



box on
ylabel('correlation strength')
xticks([0 4 11 15])
xticklabels({'++', '+-', '-+','--'})
xlim([-2 17])
ylim([0.2 0.8])



%print standard deviation of correlations (= reliability)
title(['std measured corr (unreliability): left = ', num2str(unreliality_data1), ' middle =', ...
    num2str(unreliality_data2),' right = ', num2str(unreliality_data3),...
    ' far right = ', num2str(unreliality_data4)])



%print mean errors
xlabel(['error percentage: strong = ', num2str(strong_noise),' weak = ',num2str(weak_noise),...
    '    attenuation: left = ', num2str(attenuation_data1), ' middle = ', num2str(attenuation_data2),...
    ' right = ', num2str(attenuation_data3), ' far right = ', num2str(attenuation_data4)])



end