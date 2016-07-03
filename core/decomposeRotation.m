function [x,y,z] = decomposeRotation(rotationalMatrix)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% decompose a rotation matrix. The ration matrix is matrix which should be 
%  operated at right. ex. B = A*R ,where the A and B is row vector and B is 
%  rotated A by operated R matrix.
% input:
%   rotationalMatrix: a rotational Matrix is formed by argument
% return:
%   x: rotational angle by x axis in rad 
%   y: rotational angle by y axis in rad 
%   z: rotational angle by z axis in rad 
%%%%%%%%%%%%%%%%%%%%%
    rotationalMatrix = rotationalMatrix';
	x = atan2(rotationalMatrix(3,2), rotationalMatrix(3,3));
	y = atan2(-rotationalMatrix(3,1), sqrt(rotationalMatrix(3,2)*rotationalMatrix(3,2) + rotationalMatrix(3,3)*rotationalMatrix(3,3)));
	z = atan2(rotationalMatrix(2,1), rotationalMatrix(1,1));
end