%86 subjects of a narrow age range and same number of males and females are 
%selected in HCP and Cam-CAN respectively.
%No sote correction is performed.
%
% Dependencies: 
% - site_correction
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



clear 



%access functions of main results
addpath(fileparts(pwd))



%read data, outliers are removed on both data sets seperately
data_hcp
data_camcan_6



%remove one extreme outlier
thick_hcp_lh(91,:) = [];
thick_hcp_rh(91,:) = [];

vol_hcp_lh(91,:) = [];
vol_hcp_rh(91,:) = [];

area_hcp_lh(91,:) = [];
area_hcp_rh(91,:) = [];



%match sub groups
%same number of males and females in age range 22-34 and with same number of subjects (41)
index_camcan_m = find(gender_camcan == 'm' & age_camcan >= 22 & age_camcan <= 34); % 43 subjects
index_camcan_f = find(gender_camcan == 'f' & age_camcan >= 22 & age_camcan <= 34); % 61 subjects
index_camcan_f = index_camcan_f(1:numel(index_camcan_m(:,1)),:); %take the first 43 subjects

index_hcp_m = find(gender_hcp == 'm' & age_hcp >= 22 & age_hcp <= 34); %45 subjects
index_hcp_m = index_hcp_m(1:numel(index_camcan_m(:,1)),:); %take the first 43 subjects
index_hcp_f = find(gender_hcp == 'f' & age_hcp >= 22 & age_hcp <= 34); %51 subjects
index_hcp_f = index_hcp_f(1:numel(index_camcan_m(:,1)),:); %take the first 43 subjects



%create  equal subsets for hcp and camcan
thick_hcp_lh_m = thick_hcp_lh([index_hcp_f;index_hcp_m],:);
thick_hcp_rh_m = thick_hcp_rh([index_hcp_f;index_hcp_m],:);
thick_camcan_lh_m = thick_camcan_lh([index_camcan_f; index_camcan_m],:);
thick_camcan_rh_m = thick_camcan_rh([index_camcan_f; index_camcan_m],:);

vol_hcp_lh_m = vol_hcp_lh([index_hcp_f;index_hcp_m],:);
vol_hcp_rh_m = vol_hcp_rh([index_hcp_f;index_hcp_m],:);
vol_camcan_lh_m = vol_camcan_lh([index_camcan_f; index_camcan_m],:);
vol_camcan_rh_m = vol_camcan_rh([index_camcan_f; index_camcan_m],:);

area_hcp_lh_m = area_hcp_lh([index_hcp_f;index_hcp_m],:);
area_hcp_rh_m = area_hcp_rh([index_hcp_f;index_hcp_m],:);
area_camcan_lh_m = area_camcan_lh([index_camcan_f; index_camcan_m],:);
area_camcan_rh_m = area_camcan_rh([index_camcan_f; index_camcan_m],:);

age_hcp_m = age_hcp([index_hcp_f;index_hcp_m]);
age_camcan_m = age_camcan([index_camcan_f;index_camcan_m]);

gender_hcp_m = gender_hcp([index_hcp_f;index_hcp_m]);
gender_camcan_m = gender_camcan([index_camcan_f;index_camcan_m]);

subjects_hcp_m = subjects_hcp([index_hcp_f;index_hcp_m]);
subjects_camcan_m = subjects_camcan([index_camcan_f;index_camcan_m]);



%merge hemispheres in one data matrix of each cortical measure
area_camcan = [area_camcan_lh,area_camcan_rh];
vol_camcan = [vol_camcan_lh,vol_camcan_rh];
thick_camcan = [thick_camcan_lh,thick_camcan_rh];

area_hcp = [area_hcp_lh,area_hcp_rh];
vol_hcp = [vol_hcp_lh,vol_hcp_rh];
thick_hcp = [thick_hcp_lh,thick_hcp_rh];

%matched data
area_camcan_m = [area_camcan_lh_m,area_camcan_rh_m];
vol_camcan_m = [vol_camcan_lh_m,vol_camcan_rh_m];
thick_camcan_m = [thick_camcan_lh_m,thick_camcan_rh_m];

area_hcp_m = [area_hcp_lh_m,area_hcp_rh_m];
vol_hcp_m = [vol_hcp_lh_m,vol_hcp_rh_m];
thick_hcp_m = [thick_hcp_lh_m,thick_hcp_rh_m];

%brain regions
brain_regions_camcan = [brain_regions_camcan_lh, brain_regions_camcan_rh];
brain_regions_hcp = [brain_regions_hcp_lh, brain_regions_hcp_rh];



%save data
Hcp.thick = thick_hcp_m;
Hcp.vol = vol_hcp_m;
Hcp.area = area_hcp_m;
Hcp.subject_id = subjects_hcp_m;
Hcp.brain_regions = brain_regions_hcp;
clear CamCAN %this name has already been used for a different struct
CamCAN.thick = thick_camcan_m;
CamCAN.vol = vol_camcan_m;
CamCAN.area = area_camcan_m;
CamCAN.subjects = subjects_camcan_m;
CamCAN.brain_regions = brain_regions_camcan;
save('data_site_comparison_no_site_correction.mat','Hcp','CamCAN')



