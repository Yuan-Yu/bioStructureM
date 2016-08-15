function plot_PowerSpectrum(Normalized_PowerSpectrum,time_interval)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	To plot the given autocorrelation function profile as a function of time.
% input:
%   Normalized_AutoCorr: Normalized Power Spectrum of a certain mode.
%   time_interval: The time elapse of each snapshot when you were saving MD trajectories.
%
% Editor: Hong Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	half_Num_of_frames = length(Normalized_PowerSpectrum);
	sampling_frequency = 1/time_interval;
	frequency_vector = sampling_frequency*(0:(half_Num_of_frames-1))./(half_Num_of_frames*2);
	stem(frequency_vector(1:1000).*(10^4),Normalized_PowerSpectrum(1:1000),'r.')
	xlabel('Frequency (10^{8} Hz)')
	ylabel('Normalized Intensity')
	title('Power Spectrum')
	axis tight
	ylim([0,1])
%	xlim([0,3])
end
