function [R,T,eRMSD,oRMSD,fromXYZ1] = rmsdfitm(toXYZ,fromXYZ,massx)
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

mass_center1 = sum(fromXYZ.*repmat(massx,1,3))./sum(massx) ;
mass_center2 = sum(toXYZ.*repmat(massx,1,3))./sum(massx) ;

  t1 = fromXYZ-repmat(mass_center1,ln1,1);
  t2 = toXYZ-repmat(mass_center2,ln2,1);

  [u,s,w] = svd( (repmat(massx,1,3).*t2)'*t1);
  
  %R = u*[1 0 0 ; 0 1 0; 0 0 det(u*w')]*w';
  R = w*[1 0 0 ; 0 1 0; 0 0 1]*u';
  
  if (abs(norm(mass_center2))<1.0e-07)
      
  T=-mass_center1*R;%in the case, the ref is already centered in (0,0,0)
  else
  T = mass_center2 - mass_center1*R;
  end
  
  %err = toXYZ - R*fromXYZ - repmat(T,1,ln2);
  fromXYZ1=fromXYZ*R + repmat(T,ln2,1);
  oRMSD = sqrt(sum(sum((toXYZ - fromXYZ).^2))/(ln2));
  eRMSD = sqrt(sum(sum((toXYZ - fromXYZ*R - repmat(T,ln2,1)).^2))/(ln2));

