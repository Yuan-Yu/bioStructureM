function [reduced_Bval_from_PCA,reduced_Bval_from_GNM,reduced_Bval_from_ANM] = get_reduced_B_factors(PDB_Structure,PCA_eigvalues,PCA_eigvectors)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	To calculate the reduced B-factors by stepwise removing the slowest mode contribution. Then save them.
% input:
%   PDB_Structure: the protein structure gotten from readPDB.
%   PCA_eigvalues is the PCA eigenvalues after removing six zero modes.
%   PCA_eigvectors is the PCA eigenvectors after removing six zero modes.
% return:
%	reduced_Bval_from_PCA: A (NXM) matrix, N is the atom number and M is the mode number. 
%	reduced_Bval_from_GNM: A (NXM) matrix, N is the atom number and M is the mode number. 
%	reduced_Bval_from_ANM: A (NXM) matrix, N is the atom number and M is the mode number. 
%
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	[three_N,num_of_modes_PCA] = size(PCA_eigvectors);
	num_of_atoms = three_N/3;
	num_of_modes_GNM = num_of_atoms-1;
	num_of_modes_ANM = 3*num_of_atoms-6;
	PDB_Structure = atomselect('name CA',PDB_Structure);
	[PDB_Structure,GNMValue] = GNM(PDB_Structure,num_of_modes_GNM);
	[PDB_Structure,ANMValue] = ANM(PDB_Structure,num_of_modes_ANM);
	reduced_Bval_from_PCA = zeros(num_of_atoms,num_of_modes_PCA);
	reduced_Bval_from_GNM = zeros(num_of_atoms,num_of_modes_GNM);
	reduced_Bval_from_ANM = zeros(num_of_atoms,num_of_modes_ANM);

	for i = 1:num_of_modes_PCA
		mode_selection = i:num_of_modes_PCA;
		reduced_Bval_from_PCA(:,i) = getBFactorfromPCA(PCA_eigvalues,PCA_eigvectors,mode_selection);
	end

	for j = 1:num_of_modes_GNM
		mode_selection = j:num_of_modes_GNM;
		reduced_Bval_from_GNM(:,j) = getBFactorfromGNM(PDB_Structure,GNMValue,mode_selection);
	end

	for k = 1:num_of_modes_ANM
		mode_selection = k:num_of_modes_ANM;
		reduced_Bval_from_ANM(:,k) = getBFactorfromANM(PDB_Structure,ANMValue,mode_selection);
	end

	save('reduced_Bval_from_PCA.mat','reduced_Bval_from_PCA','-v7.3');
	save('reduced_Bval_from_GNM.mat','reduced_Bval_from_GNM','-v7.3');
	save('reduced_Bval_from_ANM.mat','reduced_Bval_from_ANM','-v7.3');
end
