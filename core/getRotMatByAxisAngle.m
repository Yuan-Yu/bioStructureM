function [rotationMatrix]=getRotMatByAxisAngle(axis,angle)
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%   axis: the rotational axis 
%   angle: rotational angle in rad
% return:
%   rotationMatrix: a rotation Matrix is form by argunment.
%%%%%%%%%%%%%%%%%%%%%%%%%%%

C = cos(angle);
ux=axis(1);
uy=axis(2);
uz=axis(3);
S=sin(angle);
t=1-C;
rotationMatrix =[t*ux^2+C t*ux*uy-S*uz t*ux*uz+S*uy;t*ux*uy+S*uz,t*uy^2+C t*uy*uz-S*ux;t*ux*uz-S*uy t*uy*uz+S*ux t*uz^2+C]';