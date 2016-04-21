function rotationalMatrix = composeRotation(x, y, z)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%   x: rotational angle by x axis in rad 
%   y: rotational angle by y axis in rad 
%   z: rotational angle by z axis in rad 
% return:
%   rotationalMatrix: a rotational Matrix is formed by argument
%%%%%%%%%%%%%%%%%%%%%
	X = eye(3,3);
	Y = eye(3,3);
	Z = eye(3,3);

    X(2,2) = cos(x);
    X(2,3) = -sin(x);
    X(3,2) = sin(x);
    X(3,3) = cos(x);

    Y(1,1) = cos(y);
    Y(1,3) = sin(y);
    Y(3,1) = -sin(y);
    Y(3,3) = cos(y);

    Z(1,1) = cos(z);
    Z(1,2) = -sin(z);
    Z(2,1) = sin(z);
    Z(2,2) = cos(z);

	rotationalMatrix = Z*Y*X;
end