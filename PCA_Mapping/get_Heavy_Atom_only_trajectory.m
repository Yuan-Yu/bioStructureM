function [Heavy_Atom_only_trajectory] = get_Heavy_Atom_only_trajectory(trajectory,PDB_Structure)
%%%%%%%%%%%%%%%%%%%%%%%Need readPDB%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%	trajectory: The (3NxM) trajectory gotten from MD Simulation. (should be a .mat file here!!)
%	PDB_Structure: PDB structure array gotten from readPDB.
%
% return:
%	Heavy_Atom_only_trajectory: The trajectory that only contains heavy atoms of each residue.
%	The first H atoms of each residue are INCLUDED since we need them in further NMR order parameter calculation.
%
% Editor: Hong-Rui
%%%%%%%%%%%%%%%%%%%%%%%Need readPDB%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	[three_N,num_of_modes] = size(trajectory);
	Heavy_Atom_index = zeros(three_N,1);
	protein = atomselect('protein',PDB_Structure);

	Heavy_Atom = atomselect('not name H* or name H1 or name H',protein);
	Heavy_Atom_num = length(Heavy_Atom);

	for i = 0:(Heavy_Atom_num-1)
		current_Heavy_Atom = Heavy_Atom(i+1).atomno;
		current_index = (current_Heavy_Atom-1)*3+1;
		Heavy_Atom_index(current_index:(current_index+2)) = 1;
	end

	
	Heavy_Atom_index = logical(Heavy_Atom_index);
	Heavy_Atom_only_trajectory = trajectory(Heavy_Atom_index,:);
end
