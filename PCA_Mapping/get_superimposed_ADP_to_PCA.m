function [superimposed_ADP] = get_superimposed_ADP_to_PCA(ADP,from_structure,to_structure,PCA_mean_coord)
	from_structure = atomselect('name CA',from_structure);
	to_structure = atomselect('name CA',to_structure);
	num_of_res = length(to_structure);

	for i = 1:num_of_res
		to_structure(i).coord = PCA_mean_coord(i,:)';
	end

	[from_structure,RMSD,R,T] = autoSuperimpose(from_structure,to_structure);
	display(RMSD);

	superimposed_ADP = zeros(length(ADP),1);
	residue_covariance = zeros(3,3);

	for j = 0:(num_of_res-1)
		residue_covariance(1,1) = ADP(j*6+1);
		residue_covariance(2,2) = ADP(j*6+2); 
		residue_covariance(3,3) = ADP(j*6+3);
		residue_covariance(1,2) = ADP(j*6+4);
		residue_covariance(1,3) = ADP(j*6+5);
		residue_covariance(2,3) = ADP(j*6+6);
		aligned_residue_covariance = R*residue_covariance*R';
		superimposed_ADP(j*6+1) = aligned_residue_covariance(1,1);
		superimposed_ADP(j*6+2) = aligned_residue_covariance(2,2);
		superimposed_ADP(j*6+3) = aligned_residue_covariance(3,3);
		superimposed_ADP(j*6+4) = aligned_residue_covariance(1,2);
		superimposed_ADP(j*6+5) = aligned_residue_covariance(1,3);
		superimposed_ADP(j*6+6) = aligned_residue_covariance(2,3);
	end
end
