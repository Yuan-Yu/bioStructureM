function [characteristic_time] = get_characteristic_time(AutoCorr,time_interval)	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Calculate the characteristic time scale of a trajectory.
%	This characteristic time scale is computed from the difinition in statistical mechanics.
%	Basically it measures the effective time length that the particle reveived environmental molecular impact.
%	After tihs time scale, the motion of this particle is independent from its history. 
% input:
%	AutoCorr is the PCA autocorrelation function of a given mode, the dimension should be (1xM).
%	time_interval is the time elapse of each snapshot when you were saving MD trajectories.
%	The unit of time_interval should be picosecond.
%
% return:
%	characteristic_time is the estimated correlation time scale.
%	The unit is in picosecond.
%
% Editor: Hong-Rei
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	characteristic_time = time_interval*sum(AutoCorr)/AutoCorr(1);
end
