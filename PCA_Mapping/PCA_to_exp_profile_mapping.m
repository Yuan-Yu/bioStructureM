function [PCA_to_exp_profile_mode_mapping,correlation_information] = PCA_to_exp_profile_mapping(exp_profile,reduced_profile)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	To do the mapping of the experimental profile to PCA modes by comparing with reduced profiles.
% input:
%   exp_profile: The real experimental profile.
%   reduced_profile: The (NxM) matrix containing reduced profile from PCA.
%	IMPORTANT!! If the profile is NMR NOE order parameter, then order parameter profile should have missing residues removed!!
% return:
%	PCA_to_exp_profile_mode_mapping: The mode mapping result. The matrix is (1x4).
%	The first column is the top mapped PC mode index, second is the corresponding correlation coefficient.
%	The third column is its p-value, fourth is the total area ratio between the two profile.
%
%	correlation_information: The (Mx3) matrix containing mapping information.
%	The first column is the correlation coefficient of each PC mode to experimental profile.
%	The second coulmn is the p-value and third is the total area ratio.
%
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	[~,num_of_modes] = size(reduced_profile);
	PCA_to_exp_profile_mode_mapping = zeros(1,4);
	correlation_information = zeros(num_of_modes,3);
	for i = 1:num_of_modes
		[corr,p_value] = corrcoef(exp_profile,reduced_profile(:,i));
		correlation_information(i,1) = corr(1,2);
		correlation_information(i,2) = p_value(1,2);
		correlation_information(i,3) = sum(exp_profile)/sum(reduced_profile(:,i));
	end
	[max_corr,index] = max(correlation_information(:,1));
	PCA_to_exp_profile_mode_mapping(1) = index;
	PCA_to_exp_profile_mode_mapping(2) = max_corr;
	PCA_to_exp_profile_mode_mapping(3) = correlation_information(index,2);
	PCA_to_exp_profile_mode_mapping(4) = correlation_information(index,3);
end
