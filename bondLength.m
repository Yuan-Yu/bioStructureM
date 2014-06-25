function [blength]=bondLength(ca)
% input:
%   ca is the object gotten cafrompdb
% return:
% blength is a vector that contain all boundlength.
% the format is  length of 1-2 
%                length of 2-3 
%                length of 3-4 
%                length of 4-5 
%                       |
%                length of (n-1)-n 
 crd=Coordfromca(ca);
 d=crd(2:end,:)-crd(1:end-1,:);
 blength=sum(d.^2,2).^(0.5);