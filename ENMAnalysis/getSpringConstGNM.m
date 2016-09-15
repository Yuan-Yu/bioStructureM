function [SpringConst] = getSpringConstGNM(pdb,eigvalues)
%%%%%%%%%%%%%%%%%%%%need GNM attributes in PDBStructure%%%%%%%%%%%%%%
% input:
%   pdb is the structure gotten from cafrompdb with GNM attributes.
%	eigvalues is the GNM eigenvalues.
% return: spring constant for GNM of this input protein.
% Here the spring constant has the unit of kcal/(mol*A^2).
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	atom_num = length(pdb);
	B_factor = zeros(atom_num,1);
	eigvalues = diag(eigvalues);
	eigvectors = getGNM(pdb,[1:(atom_num-1)]);

	reduced_hessian = eigvectors*inv(eigvalues)*(eigvectors');
	reduced_covariance = 1.38064852*10^(-23)*300/1*10^(20)*8*pi^(2)*reduced_hessian;

	for i = 1:atom_num
		B_factor(i) = reduced_covariance(i,i);
	end
	
	SpringConst = sum([pdb.bval])/sum(B_factor);
	SpringConst = 1/SpringConst;
end