function [B_factor] = getBFactorfromAeGNM(pdb,eigvalues,mode_selection)
%%%%%%%%%%%%%%%%%%%%need AeGNM attributes in PDBStructure%%%%%%%%%%%%%%
% input:
%   pdb is the structure gotten from cafrompdb with AeGNM attributes.
%	eigvalues is the AeGNM eigenvalues.
%   mode_selection is an array that specify the index of modes you want to use to reform covariance.
% return:
%   B_factor: an array which can be compared with experimental B_factors.
%	The unit of B_factor is in (angstorm)^2.
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	atom_num = length(pdb);
	SpringConst = getSpringConstAeGNM(pdb,eigvalues);

	if ~exist('mode_selection','var')
		mode_selection = 1:(atom_num*3-3);
	end

	B_factor = zeros(atom_num,1);
	eigvalues = eigvalues(mode_selection);
	eigvalues = diag(eigvalues);
	eigvectors = getAeGNM(pdb,mode_selection);

	reduced_hessian = eigvectors*inv(eigvalues)*(eigvectors');
	reduced_covariance = 1.38064852*10^(-23)*300/SpringConst*10^(20)*8*pi^(2)/3*reduced_hessian;

	for i = 0:(atom_num-1)
		B_factor(i+1) = sum([reduced_covariance(i*3+1,i*3+1) reduced_covariance(i*3+2,i*3+2) reduced_covariance(i*3+3,i*3+3)]);
	end
end