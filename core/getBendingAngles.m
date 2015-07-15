function  [Angles]=getBendingAngles(ca,unit)
%%%%% need Coordfromca %%%%%%%%%%
% input:
%   ca is the object gotten from cafrompdb
%   unit can be 'Radian' or 'Degrees'
% return:
%%%%% need Coordfromca %%%%%%%%%%
coord=getCoordfromca(ca);
vectorBetweenAtoms=coord(2:end,:)-coord(1:end-1,:);
dotProduct=dot(vectorBetweenAtoms(2:end,:),vectorBetweenAtoms(1:end-1,:),2);
blength=sum(vectorBetweenAtoms.^2,2).^(0.5);

if ~exist('unit', 'var') 
    unit='Radian';
end
if strcmp(unit,'Radian')
    Angles=acos(dotProduct./(blength(2:end).*blength(1:end-1)));
elseif strcmp(unit,'Degrees')
    Angles=acos(dotProduct./(blength(2:end).*blength(1:end-1)))*(180/pi);
end