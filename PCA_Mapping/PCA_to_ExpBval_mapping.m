function [PCA_to_ExpBval_mode_mapping,correlation_information] = PCA_to_ExpBval_mapping(PDB_Structure,reduced_Bval_from_PCA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	To do the mapping of the experimental B-factors to PCA modes by comparing with reduced B-factors.
% input:
%   PDB_Structure: The protein structure gotten from readPDB.
%   reduced_Bval_from_PCA: The (NxM) matrix containing reduced B-factors from PCA.
% return:
%	PCA_to_ExpBval_mode_mapping: The mode mapping result. The matrix is (1x4).
%	The first column is the top mapped PC mode index, second is the corresponding correlation coefficient.
%	The third column is its p-value, fourth is the total area ratio between the two profile.
%
%	correlation_information: The (Mx3) matrix containing mapping information.
%	The first column is the correlation coefficient of each PC mode to experimental B-factor profile.
%	The second coulmn is the p-value and third is the total area ratio.
%
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	PDB_Structure = atomselect('name CA',PDB_Structure);
	ExpBval = [PDB_Structure.bval];
	[~,num_of_modes_PCA] = size(reduced_Bval_from_PCA);
	PCA_to_ExpBval_mode_mapping = zeros(1,4);
	correlation_information = zeros(num_of_modes_PCA,3);
	for i = 1:num_of_modes_PCA
		[corr,p_value] = corrcoef(ExpBval,reduced_Bval_from_PCA(:,i));
		correlation_information(i,1) = corr(1,2);
		correlation_information(i,2) = p_value(1,2);
		correlation_information(i,3) = sum(ExpBval)/sum(reduced_Bval_from_PCA(:,i));
	end
	[max_corr,index] = max(correlation_information(:,1));
	PCA_to_ExpBval_mode_mapping(1) = index;
	PCA_to_ExpBval_mode_mapping(2) = max_corr;
	PCA_to_ExpBval_mode_mapping(3) = correlation_information(index,2);
	PCA_to_ExpBval_mode_mapping(4) = correlation_information(index,3);
end