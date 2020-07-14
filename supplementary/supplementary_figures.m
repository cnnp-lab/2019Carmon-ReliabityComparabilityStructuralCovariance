%This script produces all figures of the supplementary material
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, April 2020 
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

load('pvalue_network_measures_site.mat')

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



%% 
% supp
% quantify differences on brain surface / compare thickness, volume, surface
% area

%access functions of main results
addpath(fileparts(pwd))
%access FSmatlab functions
addpath([fileparts(pwd),'\FSmatlab'])



clear
load('data_site_comparison') 

% for plots on the brain surface include a lh.pial and lh.aparc.annot file
% in the supplementary folder & use the following function:
brain_surface_plot_all(CamCAN.thick, Hcp.thick, CamCAN.vol, Hcp.vol, ...
    CamCAN.area, Hcp.area,{'Site comparison HCP vs. CamCAN'})



clear
load('data_scanner') 

% for plots on the brain surface include a lh.pial and lh.aparc.annot file
% in the supplementary folder & use the following function:
brain_surface_plot_all(HcpScan.thick, HcpRescan.thick, HcpScan.vol, ...
    HcpRescan.vol, HcpScan.area, HcpRescan.area,{'HCP scan vs. rescan'})



clear
load('data_freesurfer') 

% for plots on the brain surface include a lh.pial and lh.aparc.annot file
% in the supplementary folder & use the following function:
brain_surface_plot_all(CamCAN.thick, CamCAN53.thick, CamCAN.vol,...
    CamCAN53.vol, CamCAN.area, CamCAN53.area,{'Cam-CAN Freesurfer version 5.3 vs 6.0'})




%%
% supp
% Site comparison NKI and Cam-CAN 6.0

%access functions of main results
addpath(fileparts(pwd))
%access FSmatlab functions
addpath([fileparts(pwd),'\FSmatlab'])
%access BCT functions
addpath([fileparts(pwd),'\BCT'])

load('data_site_comparison_nki_camcan.mat')



% CamCAN vs NKI for Fig 3
compare_structural_covariance(CamCAN.thick, NKI.thick, [0.1 0.9 0.1],...
    [0.5 0.5 0.5],{'Cam-CAN (FS 6.0)','NKI'})

% for plots on the brain surface include a lh.pial and lh.aparc.annot file
% in the supplmentary folder & use the following function:
brain_surface_plot(CamCAN.thick, NKI.thick)



% CamCAN vs NKI for Fig 4

load('pvalue_network_measures_camcan60_nki.mat') 

% threshold_scan=0.025:0.025:0.35;
% [raw_pvalue, thresholds_pvalue, thresholds_binarized_pvalue] = ...
%     permutation_test_all_measures(NKI.thick,CamCAN.thick,threshold_scan);
% save('pvalue_network_measures_camcan60_nki.mat','raw_pvalue', 'thresholds_pvalue', ...
%     'thresholds_binarized_pvalue','threshold_scan')

visualise_pvalue_network_measures(threshold_scan,raw_pvalue, thresholds_pvalue,thresholds_binarized_pvalue,...
    ([0.1 0.9 0.1]+[0.5 0.5 0.5])/2)



% CamCAN vs NKI for Fig 5

axlimits=[0 0.25 0 4];
compare_morph_measures(CamCAN.thick, NKI.thick, CamCAN.vol,...
    NKI.vol, CamCAN.area, NKI.area,...
    ([0.5 0.5 0.5]+[0.1 0.9 0.1])/2, axlimits,{'Cam-CAN (FS 6.0) and NKI'})



%%
% supp
% Site comparison NKI and Cam-CAN 53

%access functions of main results
addpath(fileparts(pwd))
%access FSmatlab functions
addpath([fileparts(pwd),'\FSmatlab'])
%access BCT functions
addpath([fileparts(pwd),'\BCT'])

load('data_site_comparison_nki_camcan53.mat')



% CamCAN vs NKI for Fig 3
compare_structural_covariance(CamCAN.thick, NKI.thick, [0.9 0.5 0.1],...
    [0.5 0.5 0.5],{'Cam-CAN (FS 5.3)','NKI'})

% for plots on the brain surface include a lh.pial and lh.aparc.annot file
% in the supplmentary folder & use the following function:
brain_surface_plot(CamCAN.thick, NKI.thick)



% CamCAN vs NKI for Fig 4

load('pvalue_network_measures_camcan53_nki.mat') 

% threshold_scan=0.025:0.025:0.35;
% [raw_pvalue, thresholds_pvalue, thresholds_binarized_pvalue] = ...
%     permutation_test_all_measures(NKI.thick,CamCAN.thick,threshold_scan);
% save('pvalue_network_measures_camcan53_nki.mat','raw_pvalue', 'thresholds_pvalue', ...
%     'thresholds_binarized_pvalue','threshold_scan')

visualise_pvalue_network_measures(threshold_scan,raw_pvalue, thresholds_pvalue,thresholds_binarized_pvalue,...
    ([0.9 0.5 0.1]+[0.5 0.5 0.5])/2)



% CamCAN vs NKI for Fig 5

axlimits=[0 0.25 0 4];
compare_morph_measures(CamCAN.thick, NKI.thick, CamCAN.vol,...
    NKI.vol, CamCAN.area, NKI.area,...
    ([0.5 0.5 0.5]+[0.9 0.5 0.1])/2, axlimits,{'Cam-CAN (FS 5.3) and NKI'})



%%
% supp
% Scanner session BNU test retest 

%access functions of main results
addpath(fileparts(pwd))
%access FSmatlab functions
addpath([fileparts(pwd),'\FSmatlab'])



clear
load('data_scanner_bnu.mat')



% BNU test vs retest for Fig 3 
compare_structural_covariance(BnuScan.thick, BnuRescan.thick,[0.5 0.5 0.5],...
    [0.5 0.5 0.5],{'BNU scan','BNU rescan'})

% for plots on the brain surface include a lh.pial and lh.aparc.annot file
% in the supplementary folder & use the following function:
brain_surface_plot(BnuScan.thick, BnuRescan.thick)



% BNU test vs retest for Fig 5 
axlimits=[0 0.25 0 4];
compare_morph_measures(BnuScan.thick, BnuRescan.thick, BnuScan.vol,...
    BnuRescan.vol, BnuScan.area, BnuRescan.area,...
    ([0.5 0.5 0.5]+[0.5 0.5 0.5])/2, axlimits,{'BNU scan and rescan'})




%%
% supp
% HCP vs HCP downsampled  

%access functions of main results
addpath(fileparts(pwd))
%access FSmatlab functions
addpath([fileparts(pwd),'\FSmatlab'])



clear
load('data_hcp_downsampled.mat')



% HCP vs HCP 1mm for Fig 3 
compare_structural_covariance(HCP.thick, HCP1mm.thick,[0.9 0.9 0.1],...
    [0.5 0.5 0.5],{'HCP normal','HCP 1mm'})

% for plots on the brain surface include a lh.pial and lh.aparc.annot file
% in the supplementary folder & use the following function:
brain_surface_plot(HCP.thick, HCP1mm.thick)


% HCP vs HCP 1mm for Fig 5 
axlimits=[0 0.25 0 4];
compare_morph_measures(HCP.thick, HCP1mm.thick, HCP.vol,...
    HCP1mm.vol, HCP.area, HCP1mm.area,...
    ([0.9 0.9 0.1]+[0.5 0.5 0.5])/2, axlimits,{'HCP normal vs HCP 1mm'})



% HCP vs HCP 1.5mm for Fig 3 
compare_structural_covariance(HCP.thick, HCP1_5mm.thick,[0.9 0.9 0.1],...
    [0.5 0.5 0.5],{'HCP normal','HCP 1.5mm'})

% for plots on the brain surface include a lh.pial and lh.aparc.annot file
% in the supplementary folder & use the following function:
brain_surface_plot(HCP.thick, HCP1_5mm.thick)


% HCP vs HCP 1.5mm for Fig 5 
axlimits=[0 0.25 0 4];
compare_morph_measures(HCP.thick, HCP1_5mm.thick, HCP.vol,...
    HCP1_5mm.vol, HCP.area, HCP1_5mm.area,...
    ([0.9 0.9 0.1]+[0.5 0.5 0.5])/2, axlimits,{'HCP normal vs HCP 1.5mm'})



% HCP vs HCP 2mm for Fig 3 
compare_structural_covariance(HCP.thick, HCP2mm.thick,[0.9 0.9 0.1],...
    [0.5 0.5 0.5],{'HCP normal','HCP 2mm'})

% for plots on the brain surface include a lh.pial and lh.aparc.annot file
% in the supplementary folder & use the following function:
brain_surface_plot(HCP.thick, HCP2mm.thick)


% HCP vs HCP 2mm for Fig 5 
axlimits=[0 0.25 0 4];
compare_morph_measures(HCP.thick, HCP2mm.thick, HCP.vol,...
    HCP2mm.vol, HCP.area, HCP2mm.area,...
    ([0.9 0.9 0.1]+[0.5 0.5 0.5])/2, axlimits,{'HCP normal vs HCP 2mm'})



% Summary figure for all resolutions 
diff_in_resolutions(HCP,HCP1mm, HCP1_5mm,HCP2mm)



%%
% supp
% effect of number of subjects on comparability

clear
load('data_several_subjects_camcan.mat') % 228 subjects from Cam-CAN in age range 18-45



number_of_subjects_effect_cmp(CamCAN_more.thick,CamCAN_more.vol,CamCAN_more.area, 110)



%%
% supp
% effect of number of subjects on reliability

clear

%access functions of main results
addpath(fileparts(pwd))

load('data_scanner.mat') % (45 subjects)



number_of_subjects_effect_rlb(HcpScan.thick,HcpScan.vol,HcpScan.area,...
    HcpRescan.thick,HcpRescan.vol,HcpRescan.area, 45)


