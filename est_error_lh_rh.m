function [] = est_error_lh_rh(thick1,thick2,vol1, vol2, area1, area2,frame_size,color)
%This function computes the estimated error variance and covariance for all 
%morphological measures of data set 1 as well as an estimate of the corrected underlying 
%variance and covariance. The estimated covariance structures are displayed 
%with error ellipses.   
%
% Arguments:
% -THICK1 - double array; average cortical thickness of data set 1
% -VOL1 - double array; volume of data set 1
% -AREA1 - double array; surface area of data set 1 
% -THICK2 - double array; average cortical thickness of data set 2
% -VOL2 - double array; volume of data set 2
% -AREA2 - double array; surface area of data set 2
% -FRAME_SIZE - double array; size of plots 
% -COLOR - double array; color of the displayed scatter plots. 
%     
% Returns:
% figure plot
%
% Dependencies: 
%-estimate_noise_and_corr
%-error_ellipse
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



figure('Position', [0 0 900 900])



%deconvolution for average cortical thickness
%estimate corrected (co)variance and error (co)variance
[cov_xy,cov_e1d1, var_x,var_y,var_e1,var_d1] = estimate_noise_and_corr(thick1, thick2);
convoluted_cov = cov(thick1(:,1),thick1(:,2));
%compute empisically measured covariance matrix
convoluted_cov_matrix = [var(thick1(:,1)),convoluted_cov(2,1); convoluted_cov(2,1),var(thick1(:,2))];
%estimated error covariance matrix
noise_cov_matrix = [var_e1(1,1),cov_e1d1(2,1); cov_e1d1(2,1),var_d1(2,2)];
%estimated corrected covariance matrix
corrected_cov_matrix = [var_x(1,1),cov_xy(2,1); cov_xy(2,1),var_y(2,2)];



a1 = subplot(3,3,1);
scatter(thick1(:,1),thick1(:,2),6,'filled','MarkerEdgeAlpha',0.5,'MarkerFaceAlpha',0.5,'MarkerEdgeColor', color, 'MarkerFaceColor', color)
hold on 
error_ellipse(convoluted_cov_matrix,color);
corr_value = convoluted_cov_matrix(2,1)/sqrt(convoluted_cov_matrix(1,1)*convoluted_cov_matrix(2,2));
title(['Measured correlation  \rho =',' ',num2str(round(corr_value,2))])
ylabel('right hemisphere')
set(gca,'XTick',[])
%box around figure
box on

c1 = subplot(3,3,2);
error_ellipse(noise_cov_matrix,color);
title("Error covariance")
set(gca,'XTick',[],'YTick',[])
%box around figure
box on

b1 = subplot(3,3,3);
error_ellipse(corrected_cov_matrix,color);
corr_value = corrected_cov_matrix(2,1)/sqrt(corrected_cov_matrix(1,1)*corrected_cov_matrix(2,2));
title(['Underlying correlation  \rho =',' ',num2str(round(corr_value,2))])
set(gca,'XTick',[],'YTick',[])
%box around figure
box on



%deconvolution for volume
[cov_xy,cov_e1d1, var_x,var_y,var_e1,var_d1] = estimate_noise_and_corr(vol1, vol2);
convoluted_cov = cov(vol1(:,1),vol1(:,2));
convoluted_cov_matrix = [var(vol1(:,1)),convoluted_cov(2,1); convoluted_cov(2,1),var(vol1(:,2))];
noise_cov_matrix = [var_e1(1,1),cov_e1d1(2,1); cov_e1d1(2,1),var_d1(2,2)];
corrected_cov_matrix = [var_x(1,1),cov_xy(2,1); cov_xy(2,1),var_y(2,2)];



a2 = subplot(3,3,4);
scatter(vol1(:,1),vol1(:,2),6,'filled','MarkerEdgeAlpha',0.5,'MarkerFaceAlpha',0.5,'MarkerEdgeColor', color, 'MarkerFaceColor', color)
hold on
error_ellipse(convoluted_cov_matrix,color);
corr_value = convoluted_cov_matrix(2,1)/sqrt(convoluted_cov_matrix(1,1)*convoluted_cov_matrix(2,2));
title(['\rho =',' ',num2str(round(corr_value,2))])
ylabel('right hemisphere')
set(gca,'XTick',[])
%box around figure
box on



c2 = subplot(3,3,5);
error_ellipse(noise_cov_matrix,color);
set(gca,'XTick',[],'YTick',[])
%box around figure
box on



b2 = subplot(3,3,6);
error_ellipse(corrected_cov_matrix,color);
corr_value = corrected_cov_matrix(2,1)/sqrt(corrected_cov_matrix(1,1)*corrected_cov_matrix(2,2));
title(['\rho =',' ',num2str(round(corr_value,2))])
set(gca,'XTick',[],'YTick',[])
%box around figure
box on



%deconvolution for average cortical thickness
[cov_xy,cov_e1d1, var_x,var_y,var_e1,var_d1] = estimate_noise_and_corr(area1, area2);
convoluted_cov = cov(area1(:,1),area1(:,2));
convoluted_cov_matrix = [var(area1(:,1)),convoluted_cov(2,1); convoluted_cov(2,1),var(area1(:,2))];
noise_cov_matrix = [var_e1(1,1),cov_e1d1(2,1); cov_e1d1(2,1),var_d1(2,2)];
corrected_cov_matrix = [var_x(1,1),cov_xy(2,1); cov_xy(2,1),var_y(2,2)];



a3 = subplot(3,3,7);
scatter(area1(:,1),area1(:,2),6,'filled','MarkerEdgeAlpha',0.5,'MarkerFaceAlpha',0.5,'MarkerEdgeColor', color, 'MarkerFaceColor', color)
hold on
error_ellipse(convoluted_cov_matrix,color);
corr_value = convoluted_cov_matrix(2,1)/sqrt(convoluted_cov_matrix(1,1)*convoluted_cov_matrix(2,2));
title(['\rho =',' ',num2str(round(corr_value,2))])
ylabel('right hemisphere')
xlabel('left hemisphere')
%box around figure
box on

c3 = subplot(3,3,8);
error_ellipse(noise_cov_matrix,color);
xlabel('left hemisphere')
set(gca,'YTick',[])
%box around figure
box on

b3 = subplot(3,3,9);
error_ellipse(corrected_cov_matrix,color);
corr_value = corrected_cov_matrix(2,1)/sqrt(corrected_cov_matrix(1,1)*corrected_cov_matrix(2,2));
title(['\rho =','  ',num2str(round(corr_value,2))])
xlabel('left hemisphere')
set(gca,'YTick',[])
%box around figure
box on



%linka axes of all subplots
linkaxes([a1,b1,c1,a2,b2,c2,a3,b3,c3],'xy')
axis([-frame_size, frame_size, -frame_size, frame_size])



end