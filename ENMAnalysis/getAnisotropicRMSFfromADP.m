function [Anisotropic_RMSF] = getAnisotropicRMSFfromADP(ADP)
%%%%%%%%%%%%%%%%%%%%need%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%	ADP : ADP (6Nx1) vector.
% return:
%   Anisotropic_RMSF: an array which can be compared with experimental Anisotropic_RMSF.
%	The unit of RMSF is in (angstorm)^2.
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	six_N = length(ADP);
	atom_num = six_N/6;
	Anisotropic_RMSF = zeros(atom_num*3,1);
	reduced_covariance = zeros(3,3);

	for i = 0:(atom_num-1)
		reduced_covariance(1,1) = ADP(i*6+1);
		reduced_covariance(2,2) = ADP(i*6+2);
		reduced_covariance(3,3) = ADP(i*6+3);
		reduced_covariance(1,2) = ADP(i*6+4);
		reduced_covariance(1,3) = ADP(i*6+5);
		reduced_covariance(2,3) = ADP(i*6+6);
		[~,eigvalues] = eig(reduced_covariance);
		Anisotropic_RMSF([(i*3+1):(i*3+3)]) = diag(eigvalues);
	end
end