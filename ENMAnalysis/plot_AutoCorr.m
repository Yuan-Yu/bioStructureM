function plot_AutoCorr(Normalized_AutoCorr,time_interval)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	To plot the given autocorrelation function profile as a function of time.
% input:
%   Normalized_AutoCorr: Normalized Autocorrelation Function of a certain mode.
%   time_interval: The time elapse of each snapshot when you were saving MD trajectories.
%
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	Num_of_frames = length(Normalized_AutoCorr);
	time_vector = time_interval*(0:(Num_of_frames-1));
	plot(time_vector./1000,Normalized_AutoCorr)
%	xlabel('Time (picosecond)')
%	ylabel('Normalized Autocorrelation Function')
%	title('Autocorrelation Function')
end
