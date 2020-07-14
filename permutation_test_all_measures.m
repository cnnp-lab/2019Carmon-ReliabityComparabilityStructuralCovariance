function [raw_pvalue, thresholds_pvalue, thresholds_binarized_pvalue] = permutation_test_all_measures(data1,data2,thresholds)
%This function computes for different network measures of the structural 
%covariance matrix the p-value given the H0: data 1 = data 2. 
%The p-value is computed for the raw matrices, thresholded matrices and 
%thresholded and binarised matrices. The p-values are computed with a
%permutation test
%
% Arguments:
% -DATA1 - double array; data set 1
% -DATA1 - double array; data set 2
% -THRESHOLDS - double array; thresholds of strongest correlations
%
% Returns:
% -RAW_PVALUE - struct; p-value of the not thresholded matrix
% -THRESHOLDS_PVALUE - struct; p-values for different thresholds
% -THRESHOLDS_BINARIZED_PVALUE - struct; p-value for different thresholds of
% binrized matrices
%
% Dependencies: 
% - BCT folder 
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



%set number of permutations
number_permuations = 1000;

%get number of brain regions and subjects
number_regions =size(data1,2);
number_subj_data1 =size(data1,1);
number_subj_data2 =size(data2,1);
number_subj_all =number_subj_data1 + number_subj_data2;

%combine data sets
data_all = [data1; data2];

%compute structural covaraince
struct_cov1 =corr(data1);
struct_cov2 =corr(data2);






%On raw data:



%compute distance of structural covaraince and matrix measures of data 1 and
%data 2

%frobenious
frobenius_distance = sum(sum(abs(struct_cov1-struct_cov2)));

%clustering coefficient
clustering_coeff_1 = clustering_coef_wu(abs(struct_cov1));
clustering_coeff_2 = clustering_coef_wu(abs(struct_cov2));
clustering_distance = sum(abs(clustering_coeff_1-clustering_coeff_2));

%charactersitic path and global efficiency
shortest_path_1 = distance_wei(1./struct_cov1);
[charactersitic_path_1, global_efficiency_1] = charpath(shortest_path_1,0,0);
shortest_path_2 = distance_wei(1./struct_cov2);
[charactersitic_path_2, global_efficiency_2] = charpath(shortest_path_2,0,0);

charcteristic_path_distance = abs(charactersitic_path_1-charactersitic_path_2);
global_efficiency_distance = abs(global_efficiency_1 - global_efficiency_2);

%node degree
node_degree_distance = sum(abs(sum(abs(struct_cov1))-sum(abs(struct_cov2)))); 

%assortativity
struct_cov1_ = struct_cov1;
struct_cov1_(1:size(struct_cov1_,1)+1:end)=0; %set diagonal to 0
struct_cov2_ = struct_cov2;
struct_cov2_(1:size(struct_cov2_,1)+1:end)=0; %set diagonal to 0
assortativity_distance = sum(abs(assortativity_wei(struct_cov1_,0)-assortativity_wei(struct_cov2_,0)));

%eigenvector centrality
eigenvector_centrality_distance = sum(abs(eigenvector_centrality_und(struct_cov1)-eigenvector_centrality_und(struct_cov2)));



%On thresholded versions of raw data:



%set distance matrices for all thresholds
z = zeros(size(thresholds));

thresh_frobenius_distance = z;
thresh_clustering_coeff_distance = z;
thresh_chractersitic_path_distance = z;
thresh_global_efficiency_distance = z;
thresh_node_degree_distance = z;
thresh_eigenvector_centrality_distance = z;
thresh_assortativity_distance = z;

%set distance matrices for all thresholds of binarized matrices
thresh_bin_frobenius_distance = z;
thresh_bin_clustering_coeff_distance = z;
thresh_bin_chractersitic_path_distance = z;
thresh_bin_global_efficiency_distance = z;
thresh_bin_node_degree_distance = z;
thresh_bin_assortativity_distance = z;
thresh_bin_kcoreness_distance = z;



%compute distance of thresholded structural covaraince and matrix measures of data 1 and
%data 2
for t=1:length(thresholds)
    
    %compute thresholded and binarized structural covaraince matrices
    [thresh_struct_cov_1, thresh_bin_struct_cov_1] = threshold_percent_absolute(struct_cov1,thresholds(t));
    [thresh_struct_cov_2, thresh_bin_struct_cov_2] = threshold_percent_absolute(struct_cov2,thresholds(t));
    
    
    
    %compute differnces of thresholded matrices and network measures
    
    %frobenius
    thresh_frobenius_distance(t)=sum(sum(abs(thresh_struct_cov_1-thresh_struct_cov_2)));
    
    %clustering coefficient
    thresh_clustering_coeff_distance(t)=sum(abs(...
        clustering_coef_wu(thresh_struct_cov_1)-clustering_coef_wu(thresh_struct_cov_2)));
    
    %characterestic path and global efficiency
    shortest_path_1 = distance_wei(1./thresh_struct_cov_1);
    [chp1, gle1] = charpath(shortest_path_1,0,0);
    shortest_path_2 = distance_wei(1./thresh_struct_cov_2);
    [chp2, gle2] = charpath(shortest_path_2,0,0);
    
    thresh_chractersitic_path_distance(t) = abs(chp1-chp2);
    thresh_global_efficiency_distance(t) = abs(gle1-gle2);
    
    %node degree
    thresh_node_degree_distance(t) = sum(abs(sum(thresh_struct_cov_1)-sum(thresh_struct_cov_2)));
    
    %eigen vector centrality
    thresh_eigenvector_centrality_distance(t)=sum(abs(...
        eigenvector_centrality_und(thresh_struct_cov_1)-eigenvector_centrality_und(thresh_struct_cov_2)));
    
    %assortativity
    thresh_struct_cov_1_ = thresh_struct_cov_1; 
    thresh_struct_cov_2_ = thresh_struct_cov_2;
    thresh_struct_cov_1_(1:size(thresh_struct_cov_1,1)+1:end)=0; %set diagonal to 0
    thresh_struct_cov_2_(1:size(thresh_struct_cov_2,1)+1:end)=0; %set diagonal to 0
    thresh_assortativity_distance(t) = sum(abs(...
        assortativity_wei(thresh_struct_cov_1_,0)-assortativity_wei(thresh_struct_cov_2_,0)));
    
    
    
    %compute differnces of thresholded and binarised matrices and network
    %measures
    
    %frobenius
    thresh_bin_frobenius_distance(t)=sum(sum(abs(thresh_bin_struct_cov_1-thresh_bin_struct_cov_2)));
    
    %clustering coefficient
    thresh_bin_clustering_coeff_distance(t) = sum(abs(...
        clustering_coef_bu(thresh_bin_struct_cov_1)-clustering_coef_bu(thresh_bin_struct_cov_2)));
    
    %charactersitic path and global efficiency
    shortest_path_1=distance_bin(thresh_bin_struct_cov_1);
    [chp1, gle1]=charpath(shortest_path_1,0,0);
    shortest_path_2=distance_bin(thresh_bin_struct_cov_2);
    [chp2, gle2]=charpath(shortest_path_2,0,0);
    thresh_bin_chractersitic_path_distance(t)=abs(chp1-chp2);
    thresh_bin_global_efficiency_distance(t)=abs(gle1-gle2);
    
    %node degree
    thresh_bin_node_degree_distance(t)=sum(abs(sum(thresh_bin_struct_cov_1)-sum(thresh_bin_struct_cov_2)));
    
    %k-core centrality
    thresh_bin_kcoreness_distance(t)=sum(abs(kcoreness_centrality_bu(...
        thresh_bin_struct_cov_1)-kcoreness_centrality_bu(thresh_bin_struct_cov_2)));
    
    
    %assortativity
    thresh_bin_struct_cov_1_ = thresh_bin_struct_cov_1;
    thresh_bin_struct_cov_2_ = thresh_bin_struct_cov_2;
    thresh_bin_struct_cov_1_(1:size(thresh_bin_struct_cov_1,1)+1:end)=0;
    thresh_bin_struct_cov_2_(1:size(thresh_bin_struct_cov_2,1)+1:end)=0;
    thresh_bin_assortativity_distance(t)=sum(abs(....
        assortativity_bin(thresh_bin_struct_cov_1_,0)-assortativity_bin(thresh_bin_struct_cov_2_,0)));
   
end






%compute the distances for permuted subjects



%set disatnce vectors
z = zeros(number_permuations,1);

%raw data
perm_frobenius = z;
perm_clustering_coeff = z;
perm_charactersitic_path = z;
perm_global_efficiency = z;
perm_node_degree = z;
perm_assortativity = z;
perm_eigenvector_centrality = z;

%thresholded matrices
z=zeros(number_permuations,length(thresholds));
perm_thresh_frobenius = z;
perm_thresh_clustering_coeff = z;
perm_thresh_characterstic_path =z;
perm_thresh_gloabl_efficiency = z;
perm_thresh_node_degree = z;
perm_thresh_eigenvector_centrality = z;
perm_thresh_assortativity = z;

%thresholded and binarized matrices
perm_thresh_bin_frobenius = z;
perm_thresh_bin_clustering_coeff = z;
perm_thresh_bin_charectirsitc_path = z;
perm_thresh_bin_global_efficiency = z;
perm_thresh_bin_node_degree = z;
perm_thresh_bin_kcoreness = z;
perm_thresh_bin_assortativity = z;



%permute subjects to compute distances of random permutations
for k=1:number_permuations
    
    %permute subjects
    random_index = randperm(number_subj_all);
    permuted_data_all = data_all(random_index,:);
    permuted_data_1 = permuted_data_all(1:number_subj_data1,:);
    permuted_data_2 = permuted_data_all(number_subj_data1+1:end,:);
    
    %compute permuted structural covariances
    permuted_struct_cov_1 = corr(permuted_data_1);
    permuted_struct_cov_2 = corr(permuted_data_2);
    
    
 
    %on raw data:
    
    
    
    %frobenius
    perm_frobenius(k)=sum(sum(abs(permuted_struct_cov_1-permuted_struct_cov_2)));
    
    %clustering
    perm_clustering_coeff(k)=sum(abs(clustering_coef_wu(...
        abs(permuted_struct_cov_1))-clustering_coef_wu(abs(permuted_struct_cov_2))));
    
    %charactersitc path
    D1 = distance_wei(1./permuted_struct_cov_1);
    D2 = distance_wei(1./permuted_struct_cov_2);
    perm_charactersitic_path(k)=sum(abs(charpath(D1,0,0)-charpath(D2,0,0)));
    
    %nodestrength
    perm_node_degree(k)=sum(abs(sum(abs(permuted_struct_cov_1))...
        -sum(abs(permuted_struct_cov_2))));
    
    %assortativity
    SC_1_=permuted_struct_cov_1;SC_1_(1:69:end)=0;SC_2_=permuted_struct_cov_2;SC_2_(1:69:end)=0;
    perm_assortativity(k)=sum(abs(assortativity_wei(SC_1_,0)-assortativity_wei(SC_2_,0)));
    
    %eigenvector centrality
    perm_eigenvector_centrality(k)=sum(abs(eigenvector_centrality_und(...
        permuted_struct_cov_1)-eigenvector_centrality_und(permuted_struct_cov_2)));
     
   
    
    %on thresholded matrices:
    
    
    
    for t=1:length(thresholds)
        
        %compute thresholded and binarized structural covaraince for
        %permuted subjects
        [permuted_thresh_struct_cov_1, permuted_thresh_bin_struct_cov_1]=...
            threshold_percent_absolute(permuted_struct_cov_1,thresholds(t));
        [permuted_thresh_struct_cov_2, permuted_thresh_bin_struct_cov_2]=...
            threshold_percent_absolute(permuted_struct_cov_2,thresholds(t));
        
        
        
        %compute differnces of thresholded matrices and network
        %measures
        
        %frobenius
        perm_thresh_frobenius(k,t)=sum(sum(abs(permuted_thresh_struct_cov_1-permuted_thresh_struct_cov_2)));
        
        %clustering coefficient
        perm_thresh_clustering_coeff(k,t)=sum(abs(clustering_coef_wu(...
            permuted_thresh_struct_cov_1)-clustering_coef_wu(permuted_thresh_struct_cov_2)));
        
        %charactersitc path and global efficiency
        shortest_path_1=distance_wei(1./permuted_thresh_struct_cov_1);
        [chp1,gle1]=charpath(shortest_path_1,0,0);
        shortest_path_1=distance_wei(1./permuted_thresh_struct_cov_2);
        [chp2,gle2]=charpath(shortest_path_1,0,0);
        perm_thresh_characterstic_path(k,t)=abs(chp1-chp2);
        perm_thresh_gloabl_efficiency(k,t)=abs(gle1-gle2);
        
        %node degree
        perm_thresh_node_degree(k,t)=sum(abs(sum((permuted_thresh_struct_cov_1))...
            -sum((permuted_thresh_struct_cov_2))));
        
        %eigenvector centrality
        perm_thresh_eigenvector_centrality(k,t)=sum(abs(...
            eigenvector_centrality_und(permuted_thresh_struct_cov_1)-....
            eigenvector_centrality_und(permuted_thresh_struct_cov_2)));
        
        %assortativity
        permuted_thresh_struct_cov_1_ = permuted_thresh_struct_cov_1;
        permuted_thresh_struct_cov_2_ = permuted_thresh_struct_cov_2;
        permuted_thresh_struct_cov_1_(1:69:end)=0; %set diagonals to 0
        permuted_thresh_struct_cov_2_(1:69:end)=0; %set diagonals to 0
        perm_thresh_assortativity(k,t)=sum(abs(assortativity_wei(...
            permuted_thresh_struct_cov_1_,0)-assortativity_wei(permuted_thresh_struct_cov_2_,0)));
        
       
        
        %compute differnces of thresholded and binarised matrices and network
        %measures
        
        %frobenius
        perm_thresh_bin_frobenius(k,t)=sum(sum(abs(permuted_thresh_bin_struct_cov_1-permuted_thresh_bin_struct_cov_2)));
        
        %clustering coefficient
        perm_thresh_bin_clustering_coeff(k,t)=sum(abs(clustering_coef_bu(permuted_thresh_bin_struct_cov_1)-clustering_coef_bu(permuted_thresh_bin_struct_cov_2)));
        
        %charactersitc path and global efficiency
        shortest_path_1 = distance_bin(permuted_thresh_bin_struct_cov_1);
        [chp1,gle1]=charpath(shortest_path_1,0,0);
        shortest_path_1 = distance_bin(permuted_thresh_bin_struct_cov_2);
        [chp2,gle2]=charpath(shortest_path_1,0,0);
        perm_thresh_bin_charectirsitc_path(k,t)=abs(chp1-chp2);
        perm_thresh_bin_global_efficiency(k,t)=abs(gle1-gle2);

        %node degree
        perm_thresh_bin_node_degree(k,t)=sum(abs(sum((...
            permuted_thresh_bin_struct_cov_1))-sum((permuted_thresh_bin_struct_cov_2))));
        
        %k-coreness centrality
        perm_thresh_bin_kcoreness(k,t)=sum(abs(kcoreness_centrality_bu(...
            permuted_thresh_bin_struct_cov_1)-kcoreness_centrality_bu(permuted_thresh_bin_struct_cov_2)));
        
        %assortativity
        permuted_thresh_bin_struct_cov_1_ = permuted_thresh_bin_struct_cov_1;
        permuted_thresh_bin_struct_cov_2_ = permuted_thresh_bin_struct_cov_2;
        permuted_thresh_bin_struct_cov_1_(1:69:end)=0; %set diagonals to 0, needed for assortativity
        permuted_thresh_bin_struct_cov_2_(1:69:end)=0; % set diagonals to 0, needed for assortativity
        perm_thresh_bin_assortivity(k,t)=sum(abs(assortativity_bin(...
            permuted_thresh_bin_struct_cov_1_,0)-assortativity_bin(...
            permuted_thresh_bin_struct_cov_2_,0)));
        
    end
    runs = k %to see the number of runs while running the code
end






%p-values:
%compute from the actual distances and the permuted distances the p-value



%on raw data:

pvalue_frobenius = numel(find(perm_frobenius>=frobenius_distance))/number_permuations;
pvalue_clustering_coeff = numel(find(perm_clustering_coeff>=clustering_distance))/number_permuations;
pvalue_charactersitc_path = numel(find(perm_charactersitic_path>=charcteristic_path_distance))/number_permuations;
pvalue_global_efficiency = numel(find(perm_global_efficiency>=global_efficiency_distance))/number_permuations;
pvalue_node_degree = numel(find(perm_node_degree>=node_degree_distance))/number_permuations;
pvalue_assortativity = numel(find(perm_assortativity>=assortativity_distance))/number_permuations;
pvalue_eigenvector_centrality = numel(find(perm_eigenvector_centrality>=eigenvector_centrality_distance))/number_permuations;



%set p-value vectors for thresholds
z=zeros(size(thresholds));

pvalue_thresh_frobenius = z;
pvalue_thresh_clustering_coeff = z;
pvalue_thresh_characterstic_path = z;
pvalue_thresh_global_efficiency = z;
pvalue_thresh_node_degree = z;
pvalue_thresh_eigenvector_centrality=z;
pvalue_thresh_assortativity = z;



%set p-value vectors for thresholds of binarised matrices
pvalue_thresh_bin_frobenius = z;
pvalue_thresh_bin_clustering_coeff = z;
pvalue_thresh_bin_charactersitc_path = z;
pvalue_thresh_bin_global_efficiency = z;
pvalue_thresh_bin_node_degree = z;
pvalue_thresh_bin_kcoreness = z;
pvalue_thresh_bin_assortativity = z;



%compute p-values for different thresholds
for t=1:length(thresholds)
    
    
    
    %p-values for thresholded matrices
    pvalue_thresh_frobenius(t) = numel(find(perm_thresh_frobenius(:,t)...
        >=thresh_frobenius_distance(t)))/number_permuations;
    pvalue_thresh_clustering_coeff(t) = numel(find(perm_thresh_clustering_coeff(:,t)...
        >=thresh_clustering_coeff_distance(t)))/number_permuations;
    pvalue_thresh_characterstic_path(t) = numel(find(perm_thresh_characterstic_path(:,t)...
        >=thresh_chractersitic_path_distance(t)))/number_permuations;
    pvalue_thresh_global_efficiency(t) = numel(find(perm_thresh_gloabl_efficiency(:,t)...
        >=thresh_global_efficiency_distance(t)))/number_permuations;
    pvalue_thresh_node_degree(t) = numel(find(perm_thresh_node_degree(:,t)...
        >=thresh_node_degree_distance(t)))/number_permuations;
    pvalue_thresh_eigenvector_centrality(t) = numel(find(perm_thresh_eigenvector_centrality(:,t)...
        >=thresh_eigenvector_centrality_distance(t)))/number_permuations;
    pvalue_thresh_assortativity(t) = numel(find(perm_thresh_assortativity(:,t)...
        >=thresh_assortativity_distance(t)))/number_permuations;
   
    
    
    %p-value for thresholded and binarized matrices
    pvalue_thresh_bin_frobenius(t) = numel(find(...
        perm_thresh_bin_frobenius(:,t)>=thresh_bin_frobenius_distance(t)))/number_permuations;
    pvalue_thresh_bin_clustering_coeff(t) = numel(find(...
        perm_thresh_bin_clustering_coeff(:,t)>=thresh_bin_clustering_coeff_distance(t)))/number_permuations;
    pvalue_thresh_bin_charactersitc_path(t) = numel(find(...
        perm_thresh_bin_charectirsitc_path(:,t)>=thresh_bin_chractersitic_path_distance(t)))/number_permuations;
    pvalue_thresh_bin_global_efficiency(t) = numel(find(...
        perm_thresh_bin_global_efficiency(:,t)>=thresh_bin_global_efficiency_distance(t)))/number_permuations;
    pvalue_thresh_bin_node_degree(t) = numel(find(...
        perm_thresh_bin_node_degree(:,t)>=thresh_bin_node_degree_distance(t)))/number_permuations;
    pvalue_thresh_bin_kcoreness(t) = numel(find(...
        perm_thresh_bin_kcoreness(:,t)>=thresh_bin_kcoreness_distance(t)))/number_permuations;
    pvalue_thresh_bin_assortativity(t) = numel(find(...
        perm_thresh_bin_assortativity(:,t)>=thresh_bin_assortativity_distance(t)))/number_permuations;
    
end



%save p-avlues



%for raw data
raw_pvalue.Frobenius=pvalue_frobenius;
raw_pvalue.Clustering=pvalue_clustering_coeff;
raw_pvalue.Charpath=pvalue_charactersitc_path;
raw_pvalue.GlobalEff=pvalue_global_efficiency;
raw_pvalue.NodeStrength=pvalue_node_degree;
raw_pvalue.Assortativity=pvalue_assortativity;
raw_pvalue.EVC=pvalue_eigenvector_centrality;



%for thresholded matrices
thresholds_pvalue.Frobenius=pvalue_thresh_frobenius;
thresholds_pvalue.Clustering=pvalue_thresh_clustering_coeff;
thresholds_pvalue.Charpath=pvalue_thresh_characterstic_path;
thresholds_pvalue.GlobalEff=pvalue_thresh_global_efficiency;
thresholds_pvalue.NodeStrength=pvalue_thresh_node_degree;
thresholds_pvalue.EVC=pvalue_thresh_eigenvector_centrality;
thresholds_pvalue.Assortativity=pvalue_thresh_assortativity;



%for thresholded and binarized matrices
thresholds_binarized_pvalue.Frobenius=pvalue_thresh_bin_frobenius;
thresholds_binarized_pvalue.Clustering=pvalue_thresh_bin_clustering_coeff;
thresholds_binarized_pvalue.Charpath=pvalue_thresh_bin_charactersitc_path;
thresholds_binarized_pvalue.GlobalEff=pvalue_thresh_bin_global_efficiency;
thresholds_binarized_pvalue.NodeStrength=pvalue_thresh_bin_node_degree;
thresholds_binarized_pvalue.kcoreCentr=pvalue_thresh_bin_kcoreness;
thresholds_binarized_pvalue.Assortativity=pvalue_thresh_bin_assortativity;



end