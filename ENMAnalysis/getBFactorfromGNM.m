function [B_factor] = getBFactorfromGNM(pdb,eigvalues,mode_selection)
%%%%%%%%%%%%%%%%%%%%need GNM attributes in PDBStructure%%%%%%%%%%%%%%
% input:
%   pdb is the structure gotten from cafrompdb with GNM attributes.
%	eigvalues is the GNM eigenvalues.
%   mode_selection is an array that specify the index of modes you want to use to reform covariance.
% return:
%   B_factor: an array which can be compared with experimental B_factors.
%	The unit of B_factor is in (angstorm)^2.
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	atom_num = length(pdb);
	SpringConst = getSpringConstGNM(pdb,eigvalues);

	if ~exist('mode_selection','var')
		mode_selection = 1:(atom_num-1);
	end

	B_factor = zeros(atom_num,1);
	eigvalues = eigvalues(mode_selection);
	eigvalues = diag(eigvalues);
	eigvectors = getGNM(pdb,mode_selection);

	reduced_hessian = eigvectors*inv(eigvalues)*(eigvectors');
	reduced_covariance = 1.38064852*10^(-23)*300/SpringConst*10^(20)*8*pi^(2)*reduced_hessian;

	for i = 1:atom_num
		B_factor(i) = reduced_covariance(i,i);
	end
end
