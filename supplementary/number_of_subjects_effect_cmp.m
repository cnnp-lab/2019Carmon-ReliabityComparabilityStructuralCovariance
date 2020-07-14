function [] = number_of_subjects_effect_cmp(thick,vol,area, max_subject_num)
%This function computes the effect of the number of subjects on the
%comparability of the structural covariance. It computes the average 
%difference between SC matrices (of distinct subjects) 
%for different numbers of subjects.  
%
% Arguments:
% -THICK - double array; thickness of data set 
% -VOL - double array; volume of data set 
% -AREA - double array; surface area of data set 
% -MAX_SUBJECT_NUM - double array; highest number of subjects for the
% computation of the SC difference 
%
% Returns:
% - figure plot
%
% Dependencies: 
% - NONE 
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, March 2020 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com



% thickness
subject_num_index = 1;

for subject_num = 5:5:max_subject_num
    for iterations = 1:1000
        
        %create 2 random splits of the size of subject_num
        index = randperm(2*subject_num);
        data1 = thick(index(1:subject_num),:);
        data2 = thick(index((1 : subject_num) + subject_num),:); %this is also the length of subject_num
        
        %get correlations
        corr1 = corr(data1);
        corr2 = corr(data2);
        
        %compute difference in correlation and sum up to one number
        hist_vector(iterations) = sum(sum(abs(corr1 - corr2)));
        
    end
    % compute the average differnce of the 1000 iterations
    sc_difference_thick(subject_num_index) = mean(hist_vector);
    sc_difference_thick_std(subject_num_index) = std(hist_vector);
    
    subject_num_index = subject_num_index + 1; 
end



% volume
subject_num_index = 1;

for subject_num = 5:5:max_subject_num
    for iterations = 1:1000
        
        %create 2 random splits of the size of subject_num
        index = randperm(2*subject_num);
        data1 = vol(index(1:subject_num),:);
        data2 = vol(index((1 : subject_num) + subject_num),:); %this is also the length of subject_num
        
        %get correlations
        corr1 = corr(data1);
        corr2 = corr(data2);
        
        %compute difference in correlation and sum up to one number
        hist_vector(iterations) = sum(sum(abs(corr1 - corr2)));
        
    end
    % compute the average differnce of the 1000 iterations
    sc_difference_vol(subject_num_index) = mean(hist_vector);
    sc_difference_vol_std(subject_num_index) = std(hist_vector);
    
    subject_num_index = subject_num_index + 1; 
end



% surface area
subject_num_index = 1;

for subject_num = 5:5:max_subject_num
    for iterations = 1:1000
        
        %create 2 random splits of the size of subject_num
        index = randperm(2*subject_num);
        data1 = area(index(1:subject_num),:);
        data2 = area(index((1 : subject_num) + subject_num),:); %this is also the length of subject_num
        
        %get correlations
        corr1 = corr(data1);
        corr2 = corr(data2);
        
        %compute difference in correlation and sum up to one number
        hist_vector(iterations) = sum(sum(abs(corr1 - corr2)));
        
    end
    % compute the average differnce of the 1000 iterations
    sc_difference_area(subject_num_index) = mean(hist_vector);
    sc_difference_area_std(subject_num_index) = std(hist_vector);
    
    subject_num_index = subject_num_index + 1; 
end



% plot the results
figure('Position',[0 0 1200 700]) 
a = subplot(2,4,1);
errorbar(5:5:max_subject_num, sc_difference_thick,sc_difference_thick_std,'Color',[0 0 0])
title('thickness')
xlabel('number of subjects')
ylabel('absolute difference between matrices')

b = subplot(2,4,2);
errorbar(5:5:max_subject_num, sc_difference_vol,sc_difference_vol_std,'--','Color',[0 0 0])
title('volume')
xlabel('number of subjects')

c = subplot(2,4,3);
errorbar(5:5:max_subject_num, sc_difference_area,sc_difference_area_std,':','Color',[0 0 0])
title('surface area')
xlabel('number of subjects')

d = subplot(2,4,4);
plot(5:5:max_subject_num, sc_difference_thick,'Color',[0 0 0])
hold on
plot(5:5:max_subject_num, sc_difference_vol,'--','Color',[0 0 0])
hold on 
plot(5:5:max_subject_num, sc_difference_area,'.','Color',[0 0 0])
title('comparison')
xlabel('number of subjects')
legend('thickness','volume','surface area')

linkaxes([a,b,c,d],'xy')



subplot(2,4,[5 6 7 8])
plot(5:5:max_subject_num, gradient(sc_difference_thick),'Color',[0 0 0])
hold on
plot(5:5:max_subject_num, gradient(sc_difference_vol),'--','Color',[0 0 0])
hold on 
plot(5:5:max_subject_num, gradient(sc_difference_area),'.','Color',[0 0 0])
title('gradient')
xlabel('number of subjects')
ylabel('\delta absolute difference between matrices')
legend('thickness','volume','surface area')
xticks(5:5:max_subject_num)



end