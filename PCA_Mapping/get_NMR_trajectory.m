function [NMR_trajectory] = get_NMR_trajectory(NMR_structure_cell)
%%%%%%%%%%%%%%%%%%%%%%%Need readPDB%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%	NMR_structure_cell is the PDB_Structure from readPDB with NMR argument given.
%
% return:
%	NMR_trajectory is a matlab format NMR trajectory. Each column represents one frame.
%	So the dimension for NMR_trajectory is (3NxM). (M for number of frames)
%
% Editor: Hong-Rei
%%%%%%%%%%%%%%%%%%%%%%%Need readPDB%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	num_of_frames = length(NMR_structure_cell);
	num_of_atoms = length(NMR_structure_cell{1});
	NMR_trajectory = zeros(3*num_of_atoms,num_of_frames);
	
	for i = 1:num_of_frames
		NMR_trajectory(:,i) = reshape([NMR_structure_cell{i}.coord],3*num_of_atoms,1);
	end

	save('NMR_trajectory.mat','NMR_trajectory','-v7.3')
end
