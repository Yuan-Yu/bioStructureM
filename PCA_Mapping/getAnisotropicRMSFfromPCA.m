function [Anisotropic_RMSF] = getAnisotropicRMSFfromPCA(eigvalues,eigvectors,mode_selection)
%%%%%%%%%%%%%%%%%%%%need%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%	eigvalues and eigvectors are from PCA covariance decomposition.
%	IMPORTANT: The input eigvalues and eigvectors should have smallest variance mode at top (MATLAB default!!) 
%				and the first six zero-modes should be already eliminated.
%   mode_selection is an array that specify the index of modes you want to use to reform covariance.
% return:
%   Anisotropic_RMSF: an array which can be compared with experimental Anisotropic_RMSF.
%	The unit of RMSF is in (angstorm)^2.
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	[three_N,num_of_modes] = size(eigvectors);
	num_of_atoms = three_N/3;

	if ~exist('mode_selection','var')
		mode_selection = 1:num_of_modes;
	end

	Anisotropic_RMSF = zeros(three_N,1);
	reduced_covariance = getReducedCovariancefromPCA(eigvalues,eigvectors,mode_selection);

	for i = 0:(num_of_atoms-1)
		Anisotropic_RMSF(i*3+1) = reduced_covariance(i*3+1,i*3+1);
		Anisotropic_RMSF(i*3+2) = reduced_covariance(i*3+2,i*3+2);
		Anisotropic_RMSF(i*3+3) = reduced_covariance(i*3+3,i*3+3);
	end
end