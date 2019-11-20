%This script produces all figures of the main results
%
% Licence: CC-BY
%

% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



%%
%figure 3



%panel a & b
clear
load('data_site_comparison') 

%panel a
%two brain region must be chosen 
compare_mean_std_covariance(CamCAN.thick(:,[11,3]),...
    Hcp.thick(:,[11, 3]),[0.1 0.9 0.1],[0.9 0.9 0.1],...
    {'Cam-CAN','HCP'},{'left lateralorbitofrontal',...
    'left caudalmiddlefrontal'})
    %11 and 3 are ROI indices to be correlated
 
    
    
%panel b - site comparison
compare_structural_covariance(CamCAN.thick, Hcp.thick, [0.1 0.9 0.1],...
    [0.9 0.9 0.1],{'Cam-CAN','HCP'})

% for plots on the brain surface include a lh.pial and lh.aparc.annot file
% in the root folder & use the following function:
%brain_surface_plot(CamCAN.thick, Hcp.thick)



%panel c - scan rescan
clear
load('data_scanner.mat') 

compare_structural_covariance(HcpScan.thick, HcpRescan.thick, [0 0 0.9],...
    [0.7 0 0.9],{'Scan','Rescan'}) %[0 0 0.9] and [0.7 0 0.9] are RGB colour codes

% for plots on the brain surface include a lh.pial and lh.aparc.annot file
% in the root folder & use the following function:
%brain_surface_plot(HcpScan.thick, HcpRescan.thick)



%panel d - Freesurfer version
clear
load('data_freesurfer.mat') 

compare_structural_covariance(CamCAN.thick, CamCAN53.thick,[0.9 0 0],...
    [0.9 0.5 0.1],{'FS 6.0','FS 5.3'})

% for plots on the brain surface include a lh.pial and lh.aparc.annot file
% in the root folder & use the following function:
%brain_surface_plot(CamCAN.thick, CamCAN53.thick)



%%
%figure 4



%add Brain connecitivity toolbox functions to path
addpath('BCT')



%Compute the p-values on your device (will take some time) or load the
%prerun p-values 

% clear
% load('data_site_comparison') 
% 
% threshold_scan=0.025:0.025:0.35;
% [raw_pvalue, thresholds_pvalue, thresholds_binarized_pvalue] = ...
%     permutation_test_all_measures(Hcp.thick,CamCAN.thick,threshold_scan);
% save('pvalue_network_measures.mat','raw_pvalue', 'thresholds_pvalue', ...
%     'thresholds_binarized_pvalue','threshold_scan')
load('pvalue_network_measures.mat')

visualise_pvalue_network_measures(threshold_scan,raw_pvalue, thresholds_pvalue,thresholds_binarized_pvalue,...
    ([0.1 0.9 0.5]+[0.7 0.8 0])/2)



%%
%figure 5 



%panel a
clear
load('data_site_comparison') 
axlimits=[0 0.25 0 4];
compare_morph_measures(CamCAN.thick, Hcp.thick, CamCAN.vol, Hcp.vol, ...
    CamCAN.area, Hcp.area,([0.1 0.9 0.5]+[0.7 0.8 0])/2, ...
    axlimits,{'Cam-CAN and HCP'})



%panel b 
clear
load('data_scanner.mat') 
axlimits=[0 0.25 0 4];
compare_morph_measures(HcpScan.thick, HcpRescan.thick, HcpScan.vol, ...
    HcpRescan.vol, HcpScan.area, HcpRescan.area,...
    ([0 0 0.9]+[0.7 0 0.9])/2, axlimits,{'Scan and Rescan'})



%panel c
clear
load('data_freesurfer.mat') 
axlimits=[0 0.25 0 4];
compare_morph_measures(CamCAN.thick, CamCAN53.thick, CamCAN.vol,...
    CamCAN53.vol, CamCAN.area, CamCAN53.area,...
    ([0.9 0 0]+[0.9 0.5 0.1])/2, axlimits,{'FS 6.0 and FS 5.3'})



%%
%figure 6



%panel a
clear
load('data_hemispheres_site_comparison.mat')  

struct_cov_lh_rh(CamCAN.thick,Hcp.thick,CamCAN.vol,...
    Hcp.vol, CamCAN.area,Hcp.area,[0.1 0.9 0.1],[0.9 0.9 0.1],{'Cam-CAN','HCP'},3)

clear
load('data_hemispheres_scanner.mat')
struct_cov_lh_rh(HcpScan.thick,HcpRescan.thick,HcpScan.vol,...
    HcpRescan.vol, HcpScan.area,HcpRescan.area,[0 0 0.9],[0.7 0 0.9],{'Scan','Rescan'},3)

clear
load('data_hemispheres_freesurfer.mat')
struct_cov_lh_rh(CamCAN.thick,CamCAN53.thick,CamCAN.vol,...
    CamCAN53.vol, CamCAN.area,CamCAN53.area,[0.9 0 0],[0.9 0.5 0.1],{'FS 6.0','FS 5.3'},3)



%panel b

clear
load('data_hemispheres_scanner.mat')

%retest error
est_error_lh_rh(HcpRescan.thick,HcpScan.thick,HcpRescan.vol,...
    HcpScan.vol,HcpRescan.area,HcpScan.area,3,[0 0 0.9]) 

%test error
% est_error_lh_rh(HcpScan.thick,HcpRescan.thick,HcpScan.vol,...
%     HcpRescan.vol,HcpScan.area,HcpRescan.area,3,[0.7 0 0.9]) 



%panel c

clear
load('data_hemispheres_freesurfer.mat')

%freesurfer 6.0 error
est_error_lh_rh(CamCAN.thick,CamCAN53.thick,CamCAN.vol,...
    CamCAN53.vol,CamCAN.area,CamCAN53.area,3,[0.9 0 0])

% freesurfer 5.3 error
% est_error_lh_rh(CamCAN53.thick,CamCAN.thick,CamCAN53.vol,...
%     CamCAN.vol,CamCAN53.area,CamCAN.area,3,[0.9 0.5 0.1])



%%
%figure 7



%panel a
simulate_error_effect_on_attenuation_and_reliability(0.7,0.4,0.25,0.5,10000)



%panel b,c & d
clear
load('data_scanner.mat')

attenuation_and_reliability(HcpScan.thick, HcpScan.vol, HcpScan.area,...
    HcpRescan.thick, HcpRescan.vol,HcpRescan.area,[0 0 0.9],...
    [0.55 0.15 0.4 0.2 0.5 0.8 0.4 0.7 0.4],{'Scan','Rescan'})


