function [ca]=getAtomBySegid(ca,segid,getORremove)
%%
% input:
%   ca is the object got from readPDB.
%   segid is the string array. ex. [proA] or [proA proB]
%   getORremove is an logic variable. get=0,remove=1; Default:0
% output:
%   ca  is same as input ca, but just contain target atoms
%%
if ~exist('getORremove','var')
    getORremove=0;
end
segid=regexp(segid,'\s+','split');
temp=ismember({ca.segment},segid);
if getORremove
    temp=temp==0;
end
ca=ca(temp);