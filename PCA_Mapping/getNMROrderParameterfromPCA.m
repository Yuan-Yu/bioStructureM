function [order_parameter] = getNMROrderParameterfromPCA(eigvalues,eigvectors,mean_struct,mode_selection)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function cauculates the PCA theroretical predicted NMR NOE order parameter profile of a specified bond vector.
% Here you can specify how many modes you want to include in this computation, normally the slowest modes are excluded one step each.
% input:
%	eigvalues and eigvectors are from PCA covariance decomposition.
%	IMPORTANT: The input eigvalues and eigvectors should have smallest variance mode at top (MATLAB default!!) 
%				and the first six zero-modes should be already eliminated.
%	mean_struct is the protein mean structure coordinates from rmsd_fit in PCA protocol.
%   mode_selection is an array that specify the index of modes you want to use to reform covariance.
%	
%
% return:
%	order_parameter: order parameter(S^2) profile calculated theoretically from PCA for each residue.
%	It is a Nx1 column vector. 
%
% Editor: Hong-Rei
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	[~,num_of_modes] = size(eigvectors);

	if ~exist('mode_selection','var')
		mode_selection = 1:num_of_modes;
	end

	reduced_covariance = getReducedCovariancefromPCA(eigvalues,eigvectors,mode_selection);
	[atom_num,~] = size(mean_struct);
	res_num = atom_num/2;
	order_parameter = zeros(res_num,1);
	displacement_product = zeros(6,6);
	for i = 0:(res_num-1)
		mean_struct_res = mean_struct(2*i+1:2*i+2,:);
		covariance_res = reduced_covariance(6*i+1:6*i+6,6*i+1:6*i+6);

		mean_struct_vector = [mean_struct_res(1,:),mean_struct_res(2,:)];
		displacement_product(:,:) = mean_struct_vector'*mean_struct_vector + covariance_res;

		xijxij = displacement_product(1,1) + displacement_product(4,4) - 2*displacement_product(1,4);
		yijyij = displacement_product(2,2) + displacement_product(5,5) - 2*displacement_product(2,5);
		zijzij = displacement_product(3,3) + displacement_product(6,6) - 2*displacement_product(3,6);
		xijyij = displacement_product(1,2) + displacement_product(4,5) - displacement_product(1,5) - displacement_product(4,2);
		xijzij = displacement_product(1,3) + displacement_product(4,6) - displacement_product(1,6) - displacement_product(4,3);
		yijzij = displacement_product(2,3) + displacement_product(5,6) - displacement_product(2,6) - displacement_product(5,3);

		order_parameter(i+1) = (3/2)*(xijxij^(2) + yijyij^(2) + zijzij^(2) + 2*xijyij^(2) + 2*xijzij^(2) + 2*yijzij^(2)) - (1/2);
	end
end
