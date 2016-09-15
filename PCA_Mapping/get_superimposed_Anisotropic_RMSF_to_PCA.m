function [superimposed_Anisotropic_RMSF] = get_superimposed_Anisotropic_RMSF_to_PCA(Anisotropic_RMSF,from_structure,to_structure,PCA_mean_coord)
	from_structure = atomselect('name CA',from_structure);
	to_structure = atomselect('name CA',to_structure);
	num_of_res = length(to_structure);

	for i = 1:num_of_res
		to_structure(i).coord = PCA_mean_coord(i,:)';
	end

	[from_structure,RMSD,R,T] = autoSuperimpose(from_structure,to_structure);
	display(RMSD);

	superimposed_Anisotropic_RMSF = zeros(length(Anisotropic_RMSF),1);
	residue_covariance = zeros(3,3);

	for j = 0:(num_of_res-1)
		residue_covariance(1,1) = Anisotropic_RMSF(j*3+1);
		residue_covariance(2,2) = Anisotropic_RMSF(j*3+2); 
		residue_covariance(3,3) = Anisotropic_RMSF(j*3+3);
		aligned_residue_covariance = R*residue_covariance*R';
		superimposed_Anisotropic_RMSF(j*3+1) = aligned_residue_covariance(1,1);
		superimposed_Anisotropic_RMSF(j*3+2) = aligned_residue_covariance(2,2);
		superimposed_Anisotropic_RMSF(j*3+3) = aligned_residue_covariance(3,3);
	end
end