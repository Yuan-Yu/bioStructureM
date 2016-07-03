function [axis,angle] = getRotationAxisAngle(rotatedAxis,targetAxis)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% return the rotation axis and angle  for rotating the rotated axis to target axis
% input:
%   rotatedAxis: a 1 by 3 row vector
%   targetAxis:  a 1 by 3 row vector
% return:
%   axis: the rotation axis
%   angle: the rotation angle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rotatedAxis = normr(rotatedAxis);
    targetAxis = normr(targetAxis);
    axis = normr(cross(rotatedAxis,targetAxis));
    angle = acos(rotatedAxis*targetAxis');
