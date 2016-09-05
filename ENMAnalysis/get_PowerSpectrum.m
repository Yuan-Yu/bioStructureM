function [Normalized_PowerSpectrum] = get_PowerSpectrum(traj)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Calculate the power spectrum as a function of frequency of a mode trajectory.
%	This function calculate the power spectrum by FFT.
% input:
%	traj is the PCA mode projection trajectory (1xM). The input num_of_frames should be even.
%
% return:
%	Normalized_PowerSpectrum is power spectrum normalized by the maximum intensity value.
%	The dimension is (1xM/2).
%
% Editor: Hong-Rei
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	Num_of_frames = length(traj);
	traj_fourier = fft(traj);
	traj_fourier = traj_fourier(1:Num_of_frames/2);
	PowerSpectrum = traj_fourier.*conj(traj_fourier);
	Normalized_PowerSpectrum = PowerSpectrum./max(PowerSpectrum);
end
