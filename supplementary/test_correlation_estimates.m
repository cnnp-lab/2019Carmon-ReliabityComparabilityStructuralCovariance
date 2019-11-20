function [] = test_correlation_estimates()
%This function visualises for simulated data the comparison of simulated "true" 
%correlations with our estimated corrected correlations and simulated measured 
%correlations of two generated sites. This comparsion is visualised for 
%the whole range of correlation strengths and different magnitudes of noise  
%
% Arguments:
% -None
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



figure('Position',[ 0 0 900 1000])



%generate data for region 1 and region 2
index = 1;
for corr_strength = linspace(0,1,50)
  
    data = mvnrnd([0 0],[1 corr_strength; corr_strength 1],1000);
    
    %region 1 corresponds to one brain region and region 2 another brain region
    region1_random_data(index,:) = data(:,1).';
    region2_random_data(index,:) = data(:,2).';
    
    index = index + 1;
end



%generate correlations 
index_figure = 1;
for noise_region1 = [0.1,0.6,0.8]
    
    for noise_region2 = [0.1 0.6 0.8]
  
        for index2 = 1:50
            
            %compute correlation
            real_corr(index2) = corr(region1_random_data(index2,:).',...
                region2_random_data(index2,:).');
            
            
            
            %add noise1 to region 1 and noise2 to region 2
            
            %site 1
            noise_site1_region1 = noise_region1.*randn([1,1000]);
            site1_region1 = region1_random_data(index2,:) + noise_site1_region1;
            noise_site1_region2 = noise_region2.*randn([1,1000]);
            site1_region2 = region2_random_data(index2,:) + noise_site1_region2;
            
            %site 2
            noise_site2_region1 = noise_region1.*randn([1,1000]);
            site2_region1 = region1_random_data(index2,:) + noise_site2_region1;
            noise_site2_region2 = noise_region2.*randn([1,1000]);
            site2_region2 = region2_random_data(index2,:) + noise_site2_region2;
            
            
            
            %measured correlation
            measured_corr_site1(index2) = corr(site1_region1.',site1_region2.');
            measured_corr_site2(index2) = corr(site2_region1.', site2_region2.');
            
            
            
            %try to recover the underlying correlation
            [cov_xy,~, var_x,var_y,~,~] = estimate_noise_and_corr([site1_region1.',site1_region2.'],...
                [site2_region1.',site2_region2.']);
            corr_xy = cov_xy./sqrt(var_x.*var_y);
            estimated_corr(index2) = corr_xy(1,2);
            
            
            
            %compute percentage of noise for current correlation size 
            %this should roughly equal noise_region1 and noise_region2
            
            %region 1
            noise_percentage_region1(index2) = (mean(abs(noise_site1_region1))/mean(abs(region1_random_data(index2,:))) + ...
                mean(abs(noise_site2_region1))/mean(abs(region1_random_data(index2,:))))/2;
            
            %region 2
            noise_percentage_region2(index2) = (mean(abs(noise_site1_region2))/mean(abs(region2_random_data(index2,:))) + ...
                mean(abs(noise_site2_region2))/mean(abs(region2_random_data(index2,:))))/2;
            
        end
        
        
        
        %plot for every noise level the real correlation against its estimate
        
        subplot(3,3,index_figure)
        a = plot(real_corr,estimated_corr,'-o','Color',[0 0 0]);
        hold on
        b = plot(real_corr,measured_corr_site1,'-x','Color',[0.6 0.6 0.6]);
        hold on
        c = plot(real_corr,measured_corr_site2,'-x','Color',[0.3 0.3 0.9]);
        refline(1,0)
        
        legend([a,b,c],{'estimated corr','measured corr 1', 'measured corr 2'},'Location','northwest')
        xlabel('real correlation')
        ylabel(['region 1 mean % noise = ',num2str(mean(noise_percentage_region1))])
        title(['region 2 mean % noise = ',num2str(mean(noise_percentage_region2))]);
        ylim([0 1])
        
        
       
        index_figure = index_figure + 1;
        
    end
    
end



end