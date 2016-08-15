function [NH_only_eigvectors] = get_NH_only_eigvectors(eigvectors,PDB_Structure)
%%%%%%%%%%%%%%%%%%%%%%%Need readPDB%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%	eigvectors: The (3NxM) eigvectors gotten from PCA of MD Simulation. (should be a .mat file here!!)
%	PDB_Structure: PDB structure array gotten from readPDB.
%
% return:
%	NH_only_eigvectors: The eigvectors that only contains N and the first H atoms of each residue.
%	EXCLUDE Proline residues since they don't have a NH bond vector!!
%
% Editor: Hong-Rui
%%%%%%%%%%%%%%%%%%%%%%%Need readPDB%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	[three_N,num_of_modes] = size(eigvectors);
	NH_index = zeros(three_N,1);
	protein = atomselect('protein',PDB_Structure);
	NH = atomselect('not resname PRO and (name N or name H or name H1)',protein);
	NH_num = length(NH);

	for i = 0:(NH_num-1)
		current_NH = NH(i+1).atomno;
		current_index = (current_NH-1)*3+1;
		NH_index(current_index:(current_index+2)) = 1;
	end
	
	NH_index = logical(NH_index);
	NH_only_eigvectors = eigvectors(NH_index,:);
end
