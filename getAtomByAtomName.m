function [ca]=getAtomByAtomName(ca,atomName)
%%
% input:
%   ca is the object got from cafrompdb.
%   atomName is the string array. ex. [CA] or [CA N O]
% output:
%   ca  is same as input ca, but just contain target atoms
%%
atomName=regexp(atomName,'\s+','split');
temp=ismember({ca.atmname},atomName);
ca=ca(temp);