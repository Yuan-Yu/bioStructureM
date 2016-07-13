function [CA_only_trajectory] = get_CA_only_trajectory(trajectory,PDB_Structure)
%%%%%%%%%%%%%%%%%%%%%%%Need readPDB%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%	trajectory: The (3NxM) trajectory gotten from MD Simulation. (should be a .mat file here!!)
%	PDB_Structure: PDB structure array gotten from readPDB.
%
% return:
%	CA_only_trajectory: The trajectory that only contains CA atoms of each residue.
%
% Editor: Hong-Rui
%%%%%%%%%%%%%%%%%%%%%%%Need readPDB%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	[three_N,num_of_modes] = size(trajectory);
	CA_index = zeros(three_N,1);
	protein = atomselect('protein',PDB_Structure);
	CA = atomselect('name CA',protein);
	protein_res_num = length(CA);

	for i = 0:(protein_res_num-1)
		current_CA = CA(i+1).atomno;
		current_index = (current_CA-1)*3+1;
		CA_index(current_index:(current_index+2)) = 1;
	end
	
	CA_index = logical(CA_index);
	CA_only_trajectory = trajectory(CA_index,:);
end
