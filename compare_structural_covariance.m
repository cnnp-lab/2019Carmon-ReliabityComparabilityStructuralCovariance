function [] = compare_structural_covariance(data1, data2, color1, color2,tags)
%This function computes and displays the structural covariance of data 1 and 2
%as well as their Fisher transformed difference
%
% Arguments:
% -DATA1 - double array; data set 1
% -DATA2 - double array; data set 2
% -cOLOR1 - double array; color of data set 1
% -COLOR2 - double array; color of data set 2
%     
% Returns:
% figure plot
%
% Dependencies: 
%-NONE
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



figure('Position',[200,200,1350,300])



%compute the structural covarainces
corr1 = (corr(data1,'type','Pearson'));
corr2 = (corr(data2,'type','Pearson'));



%struct cov data 1
subplot(1,3,1)
imagesc(corr1)
colorbar
colormap(gca,[linspace(color1(1),1,100).',linspace(color1(2),1,100).',...
    linspace(color1(3),1,100).'])
title(tags(1))
caxis(gca,[-1,1])



%struct cov data 2
subplot(1,3,2)
imagesc(corr2)
colormap(gca,[linspace(color2(1),1,100).',linspace(color2(2),1,100).',...
    linspace(color2(3),1,100).'])
colorbar
title(tags(2))
caxis(gca,[-1,1])
set(gca,'YTick',[])



%fisher transform the structural covarinces 
corr1 = atanh(corr1);
corr2 = atanh(corr2);



%differnce of struct covs
subplot(1,3,3)
imagesc(abs(corr1 - corr2))
colormap(gca,[linspace(1,0,100).',linspace(1,0,100).',linspace(1,0,100).']) 
colorbar
caxis(gca,[0 0.4])
title('Differences')
set(gca,'YTick',[])


end