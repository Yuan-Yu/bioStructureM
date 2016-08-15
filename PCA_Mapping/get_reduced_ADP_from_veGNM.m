function [reduced_ADP_from_veGNM] = get_reduced_ADP_from_veGNM(PDB_Structure)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	To calculate the reduced ADP by stepwise removing the slowest mode contribution.
% input:
%   PDB_Structure: the protein structure gotten from readPDB.
% return:
%	reduced_ADP_from_veGNM: A (NXM) matrix, N is the atom number and M is the mode number. 
%
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	PDB_Structure = atomselect('name CA',PDB_Structure);
	num_of_atoms = length(PDB_Structure);
	num_of_modes_veGNM = 3*num_of_atoms-6;
	[PDB_Structure,veGNMValue] = veGNM(PDB_Structure,num_of_modes_veGNM);
	reduced_ADP_from_veGNM = zeros(num_of_atoms*6,num_of_modes_veGNM);

	for i = 1:num_of_modes_EPIRM
		mode_selection = i:num_of_modes_veGNM;
		reduced_ADP_from_veGNM(:,i) = getADPfromveGNM(PDB_Structure,veGNMValue,mode_selection);
	end

	save('reduced_ADP_from_veGNM.mat','reduced_ADP_from_veGNM','-v7.3');
end
