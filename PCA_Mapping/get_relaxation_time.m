function [relaxation_time] = get_relaxation_time(AutoCorr,time_interval)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Calculate the relaxation time scale of a trajectory.
%	This relaxation time scale is estimated from exponential decay approximation of the diffusion property.
% input:
%	AutoCorr is the PCA autocorrelation function of a given mode, the dimension should be (1xM).
%	time_interval is the time elapse of each snapshot when you were saving MD trajectories.
%	The unit of time_interval should be picosecond.
%
% return:
%	relaxation_time is estimated relaxation time scale.
%	The unit is in picosecond.
%
% Editor: Hong-Rei
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Num_of_frames = length(AutoCorr);
	t=(-1)*time_interval*[0:1:(Num_of_frames-1)]';
	exponent=log(AutoCorr);
	x = t\(exponent');
	relaxation_time = 1/x;
end
