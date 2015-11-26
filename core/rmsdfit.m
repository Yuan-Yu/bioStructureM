function [R,T,eRMSD,oRMSD,newXYZ] = rmsdfit(toXYZ,fromXYZ)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculating the rotation,translation matrix and RMSD between to structures. 
% input:
%   toXYZ: the target coordinates
%   fromXYZ: the coordinates that will be moved.
% return
%   R: the rotation matrix
%   T: the translation matrix
%   eRMSD: RMSD after fromXYZ moved
%   oRMSD: RMSD before fromXYZ moved
%   newXYZ: the coordinates after fromXYZ is moved.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  ln1 = size(fromXYZ,1);
  ln2 = size(toXYZ,1);

  if (ln1 ~= ln2)
    error('unequal array sizes');
  end

  m1 = mean(fromXYZ,1);
  m2 = mean(toXYZ,1);
  t1 = fromXYZ-repmat(m1,ln1,1);
  t2 = toXYZ-repmat(m2,ln2,1);
  [u,s,w] = svd(t2'*t1);
  % [1 0 0;0 1 0;0 0 det(u*w')] to prevent more than one solution if the
  % all point are on the same plane.
  R = w*[1 0 0;0 1 0;0 0 det(u*w')]*u';
  
  if (abs(norm(m2))<1.0e-07)
  T=-m1*R  ;%in the case, the ref is already centered in (0,0,0)
  else
  T = m2 - m1*R;
  end
  newXYZ=fromXYZ*R + repmat(T,ln2,1);
  oRMSD = sqrt(sum(sum((toXYZ - fromXYZ).^2))/(ln2));
  eRMSD = sqrt(sum(sum((toXYZ - fromXYZ*R - repmat(T,ln2,1)).^2))/(ln2));


