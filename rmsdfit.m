function [R,T,eRMSD,oRMSD,fromXYZ1,m1] = rmsdfit(toXYZ,fromXYZ,ca1,ca2,filename1,filename2,varargin)
if length(varargin)==2
    o=char(varargin(1));
    c=char(varargin(2));
else
    o=char.empty(1,0);
    c=char.empty(1,0);
end
%function [R,T,eRMSD] = kabsch(toXYZ:reference:t2,fromXYZ:current:t1)
% find R and T that best maps
% also find:
% eRMSD = std(R*fromXYZ + T - toXYZ)
% which will rotate (R: 3x3 matrix) and translate (T: 3 x 1 vector)
% coordinates: fromXYZ (3 x N matrix) to toXYZ (3 x N matrix) and returns root-mean-squared error (eRMSD)
% ||R*fromXYZ + T - toXYZ||^2

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
  R = w*[1 0 0 ; 0 1 0; 0 0 1]*u';
  
  if (abs(norm(m2))<1.0e-07)
  T=-m1*R  ;%in the case, the ref is already centered in (0,0,0)
  else
  T = m2 - m1*R;
  end
  fromXYZ1=fromXYZ*R + repmat(T,ln2,1);
  oRMSD = sqrt(sum(sum((toXYZ - fromXYZ).^2))/(ln2));
  eRMSD = sqrt(sum(sum((toXYZ - fromXYZ*R - repmat(T,ln2,1)).^2))/(ln2));


