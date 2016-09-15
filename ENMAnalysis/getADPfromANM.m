function [ADP] = getADPfromANM(pdb,eigvalues,mode_selection)
%%%%%%%%%%%%%%%%%%%%need ANM attributes in PDBStructure%%%%%%%%%%%%%%
% input:
%   pdb is the structure gotten from cafrompdb with ANM attributes.
%	eigvalues is the ANM eigenvalues.
%   mode_selection is an array that specify the index of modes you want to use to reform covariance.
% return:
%   ADP: an array which can be compared with experimental Anisopropic Displacement Parameters.
%	The unit of ADP is in (angstorm)^2.
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	atom_num = length(pdb);
	SpringConst = getSpringConstANM(pdb,eigvalues);

	if ~exist('mode_selection','var')
		mode_selection = 1:(atom_num*3-6);
	end

	ADP = zeros(atom_num*6,1);

	eigvalues = eigvalues(mode_selection);
	eigvalues = diag(eigvalues);
	eigvectors = getANM(pdb,mode_selection);

	reduced_hessian = eigvectors*inv(eigvalues)*(eigvectors');
	reduced_covariance = 1.38064852*10^(-23)*300/SpringConst*10^(20)*reduced_hessian;

	for i = 0:(atom_num-1)
		ADP(i*6+1) = reduced_covariance(i*3+1,i*3+1);
		ADP(i*6+2) = reduced_covariance(i*3+2,i*3+2);
		ADP(i*6+3) = reduced_covariance(i*3+3,i*3+3);
		ADP(i*6+4) = reduced_covariance(i*3+1,i*3+2);
		ADP(i*6+5) = reduced_covariance(i*3+1,i*3+3);
		ADP(i*6+6) = reduced_covariance(i*3+2,i*3+3);
	end
end
