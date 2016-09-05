function [Normalized_AutoCorr] = get_AutoCorr_brute_force(traj)
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
	AutoCorr = zeros(Num_of_frames,1);
	for n = 1:Num_of_frames
    	covariance = 0;
    	for i = 1:(Num_of_frames-n)
        	covariance = covariance + traj(i)*traj(i+n);
    	end
    	AutoCorr(n) = covariance/(Num_of_frames-n);
	end

	Normalized_AutoCorr = AutoCorr./AutoCorr(1);
end
