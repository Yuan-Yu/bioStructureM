function [PCA_to_exp_ADP_mode_mapping,correlation_information] = PCA_to_exp_ADP_mapping(exp_ADP,reduced_ADP_from_PCA,from_structure,to_structure,PCA_mean_coord)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	To do the frequency mapping of exp_ADP to PCA modes by comparing reduced ADPs.
% input:
%   exp_ADP: The (6Nx1) real experimental ADP profile.
%   reduced_ADP_from_PCA: The (6NxM) matrix containing reduced ADP from PCA.
%	PDB_Structure: PDB Structure gotten from cafrompdb.
% return:
%	PCA_to_exp_ADP_mode_mapping: The mode mapping result. The matrix is (1x4).
%	The first column is the top mapped PCA mode index, second is the corresponding correlation coefficient.
%	The third column is its p-value, fourth is the total area ratio between the two profile.
%
%	correlation_information: The (Mx3) matrix containing mapping information.
%	The first column is the correlation coefficient of each PCA mode to experimental profile.
%	The second coulmn is the p-value and third is the total area ratio.
%
%
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	exp_ADP = get_superimposed_ADP_to_PCA(exp_ADP,from_structure,to_structure,PCA_mean_coord);
	[PCA_to_exp_ADP_mode_mapping,correlation_information] = PCA_to_exp_profile_mapping(exp_ADP,reduced_ADP_from_PCA);
end
