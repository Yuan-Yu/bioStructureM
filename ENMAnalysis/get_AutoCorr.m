function [Normalized_AutoCorr] = get_AutoCorr(traj)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Calculate the autocorrelation function over time of a mode trajectory.
%	This function calculate the correlation function from convolution theorem by FFT.
%	I recommend to use this function.
% input:
%	traj is the PCA mode projection trajectory (1xM). The input num_of_frames should be even.
%
% return:
%	Normalized_AutoCorr is time autocorrelation function normalized by the first C(0) value.
%	The dimension is (1xM).
%
% Editor: Hong-Rei
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	original_num_of_frames = length(traj);
	traj = [traj zeros(1,original_num_of_frames-1)];
	new_num_of_frames = length(traj);
	traj_fourier = fft(traj); 
	intensity = traj_fourier.*conj(traj_fourier); %Wiener Khintchine theorem
	AutoCorr = ifft(intensity)/new_num_of_frames; %Wiener Khintchine theorem
	Normalized_AutoCorr = AutoCorr./AutoCorr(1);
	Normalized_AutoCorr = Normalized_AutoCorr(1:original_num_of_frames);
end
