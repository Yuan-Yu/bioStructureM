function [PCA_to_ADP_mode_mapping] = PCA_to_ADP_mapping(reduced_ADP_from_PCA,reduced_ADP_from_ENM,PDB_Structure,PCA_mean_coord)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	To do the frequency mapping from each ENM mode to PCA modes by comparing reduced ADPs.
%	Then the mapping results are saved.
% input:
%   reduced_ADP_from_PCA: The (6NxM) matrix containing reduced ADP from PCA.
%   reduced_ADP_from_ENM: The (6NxM) matrix containing reduced ADP from ENM.
%	PDB_Structure: PDB Structure gotten from cafrompdb.
%	PCA_mean_coord: mean coordinate gotten from PCA rmsdfit.
% return:
%	PCA_to_ADP_mode_mapping: The mode mapping results. The matrix is (Mx4). M is the number of ENM modes.
%	The first column is the ENM mode index, second is the corresponding mapped PC mode index.
%	The third and fourth column contains the top correlation coefficient and the corresponding p-values (of the mapped PC mode). 
%
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	[~,num_of_modes_PCA] = size(reduced_ADP_from_PCA);
	[~,num_of_modes_ENM] = size(reduced_ADP_from_ENM);
	PCA_to_ADP_mode_mapping = zeros(num_of_modes_ENM,4);
	PCA_to_ADP_mode_mapping(:,1) = (1:num_of_modes_ENM)';

	for n = 1:num_of_modes_ENM
		reduced_ADP_from_ENM(:,n) = get_superimposed_ADP_to_PCA(reduced_ADP_from_ENM(:,n),PDB_Structure,PDB_Structure,PCA_mean_coord);
	end

	for i = 1:num_of_modes_ENM
		correlation_information = zeros(num_of_modes_ENM,2);
		for j = 1:num_of_modes_PCA
			[corr,p_value] = corrcoef(reduced_ADP_from_ENM(:,i),reduced_ADP_from_PCA(:,j));
			correlation_information(j,1) = corr(1,2);
			correlation_information(j,2) = p_value(1,2);
		end
		[max_corr,index] = max(correlation_information(:,1));
		PCA_to_ADP_mode_mapping(i,2) = index;
		PCA_to_ADP_mode_mapping(i,3) = max_corr;
		PCA_to_ADP_mode_mapping(i,4) = correlation_information(index,2);

		if PCA_to_ADP_mode_mapping(i,4) >= 0.05
			disp(['p_value is too high for ENM mode' num2str(i)]);
		end
	end

	save('PCA_to_ADP_mode_mapping.mat','PCA_to_ADP_mode_mapping','-v7.3');
end
