function [reduced_covariance] = getReducedCovariancefromPCA(eigvalues,eigvectors,mode_selection)
%%%%%%%%%%%%%%%%%%%%need%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%	eigvalues and eigvectors are from PCA covariance decomposition.
%	IMPORTANT: The input eigvalues and eigvectors should have smallest variance mode at top (MATLAB default!!) 
%				and the first six zero-modes should be already eliminated.
%   mode_selection is an array that specify the index of modes you want to use to reform covariance.
% return:
%   reduced_covariance is the covariance reformed by eigenvalues and eigenvectors chosen in mode_selection.
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	[three_N,num_of_modes] = size(eigvectors);

	if ~exist('mode_selection','var')
		mode_selection = 1:num_of_modes;
	end

	eigvalues = fliplr(eigvalues')';
	eigvectors = fliplr(eigvectors);
	eigvalues = eigvalues(mode_selection);
	eigvalues = diag(eigvalues);
	eigvectors = eigvectors(:,mode_selection);
	reduced_covariance = eigvectors*eigvalues*(eigvectors');
end