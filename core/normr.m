function [matrix] = normr(matrix)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Normalize all the row vecoter in matrix
% input:
%   matrix
% return:
%   matrix: normalized matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

matrix = bsxfun(@rdivide,matrix,sqrt(sum(matrix.^2,2)));