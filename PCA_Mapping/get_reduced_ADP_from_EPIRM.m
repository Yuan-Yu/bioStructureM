function [reduced_ADP_from_EPIRM] = get_reduced_ADP_from_EPIRM(PDB_Structure)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	To calculate the reduced ADP by stepwise removing the slowest mode contribution.
% input:
%   PDB_Structure: the protein structure gotten from readPDB.
% return:
%	reduced_ADP_from_EPIRM: A (NXM) matrix, N is the atom number and M is the mode number. 
%
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	PDB_Structure = atomselect('name CA',PDB_Structure);
	num_of_atoms = length(PDB_Structure);
	num_of_modes_EPIRM = 3*num_of_atoms-3;
	[PDB_Structure,EPIRMValue] = EPIRM(PDB_Structure,num_of_modes_EPIRM);
	reduced_ADP_from_EPIRM = zeros(num_of_atoms*6,num_of_modes_EPIRM);

	for i = 1:num_of_modes_EPIRM
		mode_selection = i:num_of_modes_EPIRM;
		reduced_ADP_from_EPIRM(:,i) = getADPfromEPIRM(PDB_Structure,EPIRMValue,mode_selection);
	end

	save('reduced_ADP_from_EPIRM.mat','reduced_ADP_from_EPIRM','-v7.3');
end
