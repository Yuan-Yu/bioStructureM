function [reduced_ADP_from_PCA] = get_reduced_ADP_from_PCA(PCA_eigvalues,PCA_eigvectors)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	To calculate the reduced ADP by stepwise removing the slowest mode contribution.
% input:
%   PCA_eigvalues is the PCA eigenvalues after removing six zero modes.
%   PCA_eigvectors is the PCA eigenvectors after removing six zero modes.
% return:
%	reduced_ADP_from_PCA: A (NXM) matrix, N is the atom number and M is the mode number. 
%
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	[three_N,num_of_modes_PCA] = size(PCA_eigvectors);
	num_of_atoms = three_N/3;
	reduced_ADP_from_PCA = zeros(num_of_atoms*6,num_of_modes_PCA);

	for i = 1:num_of_modes_PCA
		mode_selection = i:num_of_modes_PCA;
		reduced_ADP_from_PCA(:,i) = getADPfromPCA(PCA_eigvalues,PCA_eigvectors,mode_selection);
	end

	save('reduced_ADP_from_PCA.mat','reduced_ADP_from_PCA','-v7.3');
end
