function [R,T,eRMSD,oRMSD,fromXYZ1] = rmsdfitm(toXYZ,fromXYZ,masses)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculating the rotation,translation matrix and RMSD between to structures. (mass weighted)
% input:
%   toXYZ: the target coordinates
%   fromXYZ: the coordinates that will be moved.
%   masses: a colunm vector contain all the masses of each point
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
  if ~exist('masses','var')
    masses = ones(ln1,1);
  else
    if size(masses,2) ~= 1
        masses = masses';
    end
  end
  mass_center1 = sum(fromXYZ.*repmat(masses,1,3))./sum(masses) ;
  mass_center2 = sum(toXYZ.*repmat(masses,1,3))./sum(masses) ;

  t1 = fromXYZ-repmat(mass_center1,ln1,1);
  t2 = toXYZ-repmat(mass_center2,ln2,1);

  [u,s,w] = svd( (repmat(masses,1,3).*t2)'*t1);
  % [1 0 0;0 1 0;0 0 det(u*w')] to prevent more than one solution if the
  % all point are on the same plane.
  R = w*[1 0 0;0 1 0;0 0 det(u*w')]*u';
  
  if (abs(norm(mass_center2))<1.0e-07)
      
  T=-mass_center1*R;%in the case, the ref is already centered in (0,0,0)
  else
  T = mass_center2 - mass_center1*R;
  end
  fromXYZ1=fromXYZ*R + repmat(T,ln2,1);
  oRMSD = sqrt(sum(sum((toXYZ - fromXYZ).^2))/(ln2));
  eRMSD = sqrt(sum(sum((toXYZ - fromXYZ*R - repmat(T,ln2,1)).^2))/(ln2));

