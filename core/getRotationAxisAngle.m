function [axis,angle] = getRotationAxisAngle(rotatedAxis,tergetAxis)
    rotatedAxis = normr(rotatedAxis);
    tergetAxis = normr(tergetAxis);
    axis = normr(cross(rotatedAxis,tergetAxis));
    angle = acos(rotatedAxis*tergetAxis');
