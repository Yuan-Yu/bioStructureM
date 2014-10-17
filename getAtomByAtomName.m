function [ca]=getAtomByAtomName(ca,atomName,getORremove)
%%
% input:
%   ca is the object got from cafrompdb.
%   atomName is the string array. ex. [CA] or [CA N O]
%   getORremove is an logic variable. get=0,remove=1; Default:0
% output:
%   ca  is same as input ca, but just contain target atoms
%%
if ~exist('getORremove','var')
    getORremove=0;
end
atomName=regexp(atomName,'\s+','split');
temp=ismember({ca.atmname},atomName);
if getORremove
    temp=temp==0;
end
ca=ca(temp);