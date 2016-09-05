function [reduced_order_parameter_from_PCA] = get_reduced_order_parameters_from_PCA(eigvalues,eigvectors,mean_struct)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	To calculate the reduced NMR NOE order parameters (S^2) by stepwise removing the slowest mode contribution.
% input:
%   PCA_eigvalues is the PCA eigenvalues after removing six zero modes.
%   PCA_eigvectors is the PCA eigenvectors after removing six zero modes.
%	IMPORTANT!! The PCA_eigvalues and PCA_eigvectors should only contain NH atom ONLY!!
%	mean_struct: mean structure gotten from PCA rmsdfit results.
% return:
%	reduced_order_parameter_from_PCA: A (NXM) matrix, N is the residue number and M is the mode number. 
%
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	[three_N,num_of_modes] = size(eigvectors);
	num_of_atoms = three_N/3;
	num_of_res = num_of_atoms/2;	
	reduced_order_parameter_from_PCA = zeros(num_of_res,num_of_modes);

	for i = 1:num_of_modes
		mode_selection = i:num_of_modes;
		reduced_order_parameter_from_PCA(:,i) = getNMROrderParameterfromPCA(eigvalues,eigvectors,mean_struct,mode_selection);
	end
	
	save('reduced_order_parameter_from_PCA.mat','reduced_order_parameter_from_PCA','-v7.3');
end
