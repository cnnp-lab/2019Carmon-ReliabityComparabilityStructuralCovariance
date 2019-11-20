%This script produces all figures of the supplementary material
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



%%
%supp 
%network analysis 



%access functions of main results
addpath(fileparts(pwd))
%access BCT functions
addpath([fileparts(pwd),'\BCT'])



%Compute the p-values on your device (will take some time) or load the
%prerun p-values 

% load('data_site_comparison.mat') 
% threshold_scan=0.025:0.025:0.35;
% 
% [raw_pvalue, thresholds_pvalue, thresholds_binarized_pvalue]=permutation_test_all_measures(Hcp.thick, ...
%    CamCAN.thick,threshold_scan);
% save('pvalue_network_measures.mat','raw_pvalue', 'thresholds_pvalue', 'thresholds_binarized_pvalue','threshold_scan')

load('pvalue_network_measures.mat')

%panel a-e
visualise_pvalue_all_network_measures(threshold_scan,raw_pvalue, thresholds_pvalue,thresholds_binarized_pvalue,...
    ([0.1 0.9 0.5]+[0.7 0.8 0])/2)



%%
%supp
%comparison of correlation strength between cortical measures



%access functions of main results
addpath(fileparts(pwd))



%panel a
clear
load('data_site_comparison.mat')
%HCP 
corr_strength_comparison(Hcp.thick, Hcp.vol, Hcp.area,[0.9 0.9 0.1])
%Cam-CAN
corr_strength_comparison(CamCAN.thick, CamCAN.vol, CamCAN.area,[0.1 0.9 0.1])



%panel b
clear
load('data_scanner.mat')
%HCP scan
corr_strength_comparison(HcpScan.thick, HcpScan.vol, HcpScan.area,[0 0 0.9])
%HCP rescan
corr_strength_comparison(HcpRescan.thick, HcpRescan.vol, HcpRescan.area,[0.7 0 0.9])



%panel c
clear
load('data_freesurfer.mat')
%Cam-CAN FS 6.0
corr_strength_comparison(CamCAN.thick, CamCAN.vol, CamCAN.area,[0.9 0 0])
%Cam-CAN FS 5.3
corr_strength_comparison(CamCAN53.thick, CamCAN53.vol, CamCAN53.area,[0.9 0.5 0.1])




%%
%supp
%attenuation analysis
%analysing the estimated correlation for all brain regions of the Desikan Killiany atlas 



%access functions of main results
addpath(fileparts(pwd))



%panel a & b
clear
load('data_scanner.mat')

%panel a
attenuation_analysis(HcpScan.thick, HcpScan.vol, HcpScan.area,HcpRescan.thick, ...
    HcpRescan.vol, HcpRescan.area,[0 0 0.9])

%panel b
attenuation_analysis(HcpRescan.thick, HcpRescan.vol, HcpRescan.area,HcpScan.thick,...
    HcpScan.vol, HcpScan.area,[0.7 0 0.9])



%panel c & d
clear
load('data_freesurfer.mat')

%panel c
attenuation_analysis(CamCAN.thick, CamCAN.vol, CamCAN.area,CamCAN53.thick,...
    CamCAN53.vol, CamCAN53.area,[0.9 0 0])

%panel d
attenuation_analysis(CamCAN53.thick, CamCAN53.vol, CamCAN53.area,...
    CamCAN.thick, CamCAN.vol, CamCAN.area,[0.9 0.5 0.1])



%%
%supp
%attenuation by correlation strength



%access functions of main results
addpath(fileparts(pwd))



%panel a & b
clear
load('data_scanner.mat')

%panel a
attenuation_by_correlation_strength(HcpScan.thick, HcpScan.vol, HcpScan.area,...
    HcpRescan.thick, HcpRescan.vol, HcpRescan.area,[0 0 0.9])

%panel b
attenuation_by_correlation_strength(HcpRescan.thick, HcpRescan.vol, HcpRescan.area,...
    HcpScan.thick, HcpScan.vol, HcpScan.area,[0.7 0 0.9])



%panel c & d
clear
load('data_freesurfer.mat')

%panel c
attenuation_by_correlation_strength(CamCAN.thick, CamCAN.vol, CamCAN.area,...
    CamCAN53.thick, CamCAN53.vol, CamCAN53.area,[0.9 0 0])

%panel d
attenuation_by_correlation_strength(CamCAN53.thick, CamCAN53.vol, CamCAN53.area,...
    CamCAN.thick, CamCAN.vol, CamCAN.area,[0.9 0.5 0.1])



%%
%supp attenuation reliability
%additonal data sets for figure 7



%access functions of main results
addpath(fileparts(pwd))



%Fig HCP rescan panel a-c
clear
load('data_scanner.mat')

attenuation_and_reliability(HcpRescan.thick, HcpRescan.vol, HcpRescan.area,HcpScan.thick, HcpScan.vol,...
    HcpScan.area,[0.7 0 0.9],[0.55 0.15 0.4 0.2 0.5 0.8 0.4 0.7 0.4],{'Rescan','Scan'})



%Fig FS 6.0 and fig FS 5.3
clear
load('data_freesurfer.mat')

%Fig FS 6.0 panel a - c
attenuation_and_reliability(CamCAN.thick, CamCAN.vol, CamCAN.area,CamCAN53.thick, CamCAN53.vol, ...
    CamCAN53.area,[0.9 0 0],[0.5 0.15 0.4 0.2 0.5 0.8 0.4 0.7 0.4],{'FS 6.0','FS 5.3'})

%Fig FS 5.3 panel a - c
attenuation_and_reliability(CamCAN53.thick, CamCAN53.vol, CamCAN53.area,CamCAN.thick, CamCAN.vol, ...
    CamCAN.area,[0.9 0.5 0.1],[0.5 0.15 0.4 0.2 0.5 0.8 0.4 0.7 0.4],{'FS 5.3','FS 6.0'})



%%
%supp test attenuation_and_reliability 
%include our estimates to simulation



%access functions of main results
addpath(fileparts(pwd))



test_error_on_attenuation_and_reliability(0.7,0.4,0.25,0.5,10000)



%%
%supp
%test correlation estimate



%access functions of main results
addpath(fileparts(pwd))



test_correlation_estimates



%%
%supp
%ROI size and p-value



%access functions of main results
addpath(fileparts(pwd))



%panel a
clear
load('data_scanner_no_site_correction.mat') 
roi_size_pvalue(HcpScan.thick,HcpRescan.thick,HcpScan.vol,HcpRescan.vol,HcpScan.area,HcpRescan.area,...
    ([0 0 0.9]+[0.7 0 0.9])/2,'Uncorrected volume HCP scan data')



%panel b
clear
load('data_freesurfer_no_site_correction.mat') 
roi_size_pvalue(CamCAN.thick,CamCAN53.thick,CamCAN.vol,CamCAN53.vol,CamCAN.area,CamCAN53.area,...
    ([0.9 0 0]+[0.9 0.5 0.1])/2,'Uncorrected volume Freesurfer 6.0')



%panel c
clear
load('data_site_comparison_no_site_correction.mat')
roi_size_pvalue(CamCAN.thick,Hcp.thick,CamCAN.vol,Hcp.vol,CamCAN.area,Hcp.area,...
    ([0.1 0.9 0.1]+[0.9 0.9 0.1])/2,'Uncorrected volume CamCAN')



%%
%supp 
%Spaerman correlation coefficient 



%access functions of main results
addpath(fileparts(pwd))



%panel a from script_figures



%panel b
clear
load('data_site_comparison.mat')
diff_morph_measures_spearman(CamCAN.thick, Hcp.thick, CamCAN.vol, Hcp.vol, CamCAN.area, Hcp.area,...
    ([0.1 0.9 0.1]+[0.9 0.9 0.1])/2, [0.03 0.25 0 4],{'Cam-CAN and HCP'})

clear
load('data_scanner.mat')
diff_morph_measures_spearman(HcpScan.thick, HcpRescan.thick, HcpScan.vol, HcpRescan.vol, HcpScan.area, HcpRescan.area,...
    ([0 0 0.9]+[0.7 0 0.9])/2, [0.03 0.25 0 4],{'Scan and Rescan'})

clear
load('data_freesurfer.mat')
diff_morph_measures_spearman(CamCAN.thick, CamCAN53.thick, CamCAN.vol, CamCAN53.vol, CamCAN.area, CamCAN53.area,...
    ([0.9 0 0]+[0.9 0.5 0.1])/2, [0.03 0.25 0 4],{'FS 6.0 and FS 5.3'})



%%
%supp
%coefficient of variation 



%panel a
clear
load('data_site_comparison_no_site_correction.mat')
coeff_variation(CamCAN.thick, CamCAN.vol, CamCAN.area,[0.1 0.9 0.1],{'Cam-CAN'})
coeff_variation(Hcp.thick, Hcp.vol, Hcp.area,[0.9 0.9 0.1],{'HCP'})



%panel b
clear
load('data_scanner_no_site_correction.mat')
coeff_variation(HcpScan.thick,HcpScan.vol,HcpScan.area,[0 0 0.9],{'HCP Scan'})
coeff_variation(HcpRescan.thick,HcpRescan.vol,HcpRescan.area,[0.7 0 0.9],{'HCP Rescan'})



%panel c
clear
load('data_freesurfer_no_site_correction.mat')
coeff_variation(CamCAN.thick,CamCAN.vol,CamCAN.area,[0.9 0 0],{'Freesurfer 6.0'})
coeff_variation(CamCAN53.thick,CamCAN53.vol,CamCAN53.area,[0.9 0.5 0.1],{'Freesurfer 5.3'})


