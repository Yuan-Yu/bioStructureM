function [NH_only_mean_struct] = get_NH_only_mean_struct(mean_struct,PDB_Structure)
%%%%%%%%%%%%%%%%%%%%%%%Need readPDB%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%	mean_struct: The (Nx3) mean_struct gotten from PCA of MD Simulation. (should be a .mat file here!!)
%	PDB_Structure: PDB structure array gotten from readPDB.
%
% return:
%	NH_only_mean_struct: The mean_struct that only contains N and the first H atoms of each residue.
%	EXCLUDE Proline residues since they don't have a NH bond vector!!
%
% Editor: Hong-Rui
%%%%%%%%%%%%%%%%%%%%%%%Need readPDB%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	[atom_num,~] = size(mean_struct);
	NH_index = zeros(atom_num,1);
	protein = atomselect('protein',PDB_Structure);
	NH = atomselect('not resname PRO and (name N or name H or name H1)',protein);
	NH_num = length(NH);

	for i = 1:NH_num
		current_index = NH(i).atomno;
		NH_index(current_index) = 1;
	end
	NH_index = logical(NH_index);
	NH_only_mean_struct = mean_struct(NH_index,:);
end
