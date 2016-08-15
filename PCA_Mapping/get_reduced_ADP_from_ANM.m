function [reduced_ADP_from_ANM] = get_reduced_ADP_from_ANM(PDB_Structure)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	To calculate the reduced ADP by stepwise removing the slowest mode contribution.
% input:
%   PDB_Structure: the protein structure gotten from readPDB.
% return:
%	reduced_ADP_from_ANM: A (NXM) matrix, N is the atom number and M is the mode number. 
%
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	PDB_Structure = atomselect('name CA',PDB_Structure);
	num_of_atoms = length(PDB_Structure);
	num_of_modes_ANM = 3*num_of_atoms-6;
	[PDB_Structure,ANMValue] = ANM(PDB_Structure,num_of_modes_ANM);
	reduced_ADP_from_ANM = zeros(num_of_atoms*6,num_of_modes_ANM);

	for i = 1:num_of_modes_ANM
		mode_selection = i:num_of_modes_ANM;
		reduced_ADP_from_ANM(:,i) = getADPfromANM(PDB_Structure,ANMValue,mode_selection);
	end

	save('reduced_ADP_from_ANM.mat','reduced_ADP_from_ANM','-v7.3');
end
