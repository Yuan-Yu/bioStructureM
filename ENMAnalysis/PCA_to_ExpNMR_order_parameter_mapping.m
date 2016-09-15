function [PCA_to_ExpNMR_order_parameter_mode_mapping,correlation_information] = PCA_to_ExpNMR_order_parameter_mapping(Exp_NMR_order_parameter,reduced_order_parameter)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	To do the mapping of the NMR experimental order parameter to PCA modes by comparing with reduced order parameters.
% input:
%   Exp_NMR_order_parameter: The real NMR NOE experimental order parameter profile.
%   reduced_order_parameter: The (NxM) matrix containing reduced order parameters from PCA.
%	IMPORTANT!! The order parameter profile should have missing residues removed!!
% return:
%	PCA_to_ExpNMR_order_parameter_mode_mapping: The mode mapping result. The matrix is (1x4).
%	The first column is the top mapped PC mode index, second is the corresponding correlation coefficient.
%	The third column is its p-value, fourth is the total area ratio between the two profile.
%
%	correlation_information: The (Mx3) matrix containing mapping information.
%	The first column is the correlation coefficient of each PC mode to experimental B-factor profile.
%	The second coulmn is the p-value and third is the total area ratio.
%
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	[~,num_of_modes] = size(reduced_order_parameter);
	PCA_to_ExpNMR_order_parameter_mode_mapping = zeros(1,4);
	correlation_information = zeros(num_of_modes,3);
	for i = 1:num_of_modes
		[corr,p_value] = corrcoef(Exp_NMR_order_parameter,reduced_order_parameter(:,i));
		correlation_information(i,1) = corr(1,2);
		correlation_information(i,2) = p_value(1,2);
		correlation_information(i,3) = sum(Exp_NMR_order_parameter)/sum(reduced_order_parameter(:,i));
	end
	[max_corr,index] = max(correlation_information(:,1));
	PCA_to_ExpNMR_order_parameter_mode_mapping(1) = index;
	PCA_to_ExpNMR_order_parameter_mode_mapping(2) = max_corr;
	PCA_to_ExpNMR_order_parameter_mode_mapping(3) = correlation_information(index,2);
	PCA_to_ExpNMR_order_parameter_mode_mapping(4) = correlation_information(index,3);
end
