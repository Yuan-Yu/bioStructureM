function [ENM_to_exp_ADP_mode_mapping,correlation_information] = ENM_to_exp_ADP_mapping(exp_ADP,reduced_ADP_from_ENM,from_structure,to_structure)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	To do the frequency mapping of exp_ADP to ENM modes by comparing reduced ADPs.
% input:
%   exp_ADP: The (6Nx1) real experimental ADP profile.
%   reduced_ADP_from_ENM: The (6NxM) matrix containing reduced ADP from ENM.
%	PDB_Structure: PDB Structure gotten from cafrompdb.
% return:
%	ENM_to_exp_ADP_mode_mapping: The mode mapping result. The matrix is (1x4).
%	The first column is the top mapped ENM mode index, second is the corresponding correlation coefficient.
%	The third column is its p-value, fourth is the total area ratio between the two profile.
%
%	correlation_information: The (Mx3) matrix containing mapping information.
%	The first column is the correlation coefficient of each ENM mode to experimental profile.
%	The second coulmn is the p-value and third is the total area ratio.
%
%
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	exp_ADP = get_superimposed_ADP_to_ENM(exp_ADP,from_structure,to_structure);
	[ENM_to_exp_ADP_mode_mapping,correlation_information] = PCA_to_exp_profile_mapping(exp_ADP,reduced_ADP_from_ENM);
end

