function [rotatMat]= alignAxis(movedAxis,targetAxis)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% return a rotation matrix for rotation the movedAxis to targetAxis
% input:
%   movedAxis: a 1 by 3 vector 
%   targetAxis: a 1 by 3 vecotr
% return:
%   rotatMat: a 3 by 3 rotation matrix. 
%       To apply the rotation matrix to PDB structure: moveStructure function 
%       To apply the rotation matrix to coord (n by 3): coord * rotatMat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    [mRownum,mColnum]=size(movedAxis);
    [tRownum,tColnum]=size(targetAxis);
    if mRownum == 3
        movedAxis = movedAxis';
    end
    if tRownum == 3
        movedAxis = movedAxis';
    end
    [axis,angle] = getRotationAxisAngle(movedAxis,targetAxis);
    rotatMat= getRotMatByAxisAngle(axis,angle);
end