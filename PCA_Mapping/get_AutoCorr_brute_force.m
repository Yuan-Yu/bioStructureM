function [AutoCorr] = get_AutoCorr_brute_force(traj)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Calculate the autocorrelation function over time of a mode trajectory.
%	This function calculate the correlation function from original difinition.
%	Since it is a brute-force formula, it will be time-consuming.
%	Not recommended to use!!
% input:
%	traj is the PCA mode projection trajectory (1xM). The input num_of_frames should be even.
%
% return:
%	Normalized_AutoCorr is time autocorrelation function normalized by the first C(0) value.
%	The dimension is (1xM).
%
% Editor: Hong-Rei
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	Num_of_frames = length(traj);
	traj = traj./norm(traj);
	AutoCorr = zeros(Num_of_frames,1);
	for n = 0:(Num_of_frames-1)
		unshifted_sequence = traj(n+1:end);
		unshifted_sequence = unshifted_sequence./norm(unshifted_sequence);
		shifted_sequence = traj(1:end-n);
		shifted_sequence = shifted_sequence./norm(shifted_sequence);

    	AutoCorr(n+1) = (unshifted_sequence*shifted_sequence');
	end
end
