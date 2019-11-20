function [] = brain_surface_plot(data1, data2)
%This function computes the average ROI differnce of the structural covariance
%of data 1 and data 2. The differnce is displayed with a heatmap on the brain. 
%
% Arguments:
% -DATA1 - data set 1
% -DATA2 - data set 2
%     
% Returns:
% figure plot
%
% Dependencies: 
% -FSmatlab folder
% -aparc files
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



%compute the average difference between the structural covariance 

%fisher transform the correlation
corr1 = atanh(corr(data1,'type','Pearson'));
corr2 = atanh(corr(data2,'type','Pearson'));

%average difffernce of the structural covarainces of each ROI
temp = abs(corr1 - corr2);
temp(isnan(temp)) = 0;
struct_cov_average_diff = sum(temp)/68;



%plot the colors on the left hemisphere

%Add functions of the FSmatalb folder to the path
addpath('FSmatlab')
[pialv,pialf]=freesurfer_read_surf('lh.pial');
[~,label,colortable]=read_annotation('lh.aparc.annot');



%create a map from ROI average difference to the right label
roi_map = zeros([36,2]);
roi_map(:,1) = colortable.table(:,5);
roi_map([2:4,6:end],2) = struct_cov_average_diff(:,1:34).';



%change the label to the average struct cov differnce
%walk through all labels
for i = 1:numel(roi_map(:,1))
    %match the labels with the corresponding numbers
    label(label == roi_map(i,1)) = roi_map(i,2);
end



figure('Position',[200, 200, 600, 400])
trisurf(pialf,pialv(:,1),pialv(:,2),pialv(:,3),label,'FaceLighting','gouraud','LineStyle','none')
material dull
camlight(-90,0)
view(-90, 0)
axis off
grid off
title('Average ROI difference')
colorbar 
colormap([linspace(1,0,100).',linspace(1,0,100).',linspace(1,0,100).']) 
caxis([0.1 0.2])



end