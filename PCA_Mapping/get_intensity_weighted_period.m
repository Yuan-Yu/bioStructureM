function [intensity_weighted_period] = get_intensity_weighted_period(power_spectrum,time_interval)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Calculate the intensity weighted period of a trajectory.
%	This intensity weighted period is computed from the power spectrum of the trajectory.
% input:
%	power_spectrum is the PCA power spectrum of a given mode, the dimension should be (1xM/2).
%	time_interval is the time elapse of each snapshot when you were saving MD trajectories.
%	The unit of time_interval should be picosecond.
%
% return:
%	intensity_weighted_period is the estimated time scale from Fourier Analysis.
%	The unit is in picosecond.
%
% Editor: Hong-Rei
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	[Num_of_modes,freq_vector_length] = size(power_spectrum);
	Num_of_frames = freq_vector_length*2;
	sampling_frequency = 1/time_interval;
	frequency_vector = sampling_frequency*(0:((Num_of_frames/2)-1))/Num_of_frames;
	current_frequency_vector = frequency_vector(2:end);
	effective_period = 1./current_frequency_vector;
	current_intensity = power_spectrum(2:end);
	intensity_weighted_period = sum(current_intensity.*effective_period)/sum(current_intensity);
end
