function [ca]=getAtomByChainID(ca,chainID,getORremove)
%%
% input:
%   ca is the object got from readPDB.
%   chainID is the string array. ex. ['A'] or ['A B']
%   getORremove is an logic variable. get=0,remove=1; Default:0
% output:
%   ca  is same as input ca, but just contain target atoms
%%
if ~exist('getORremove','var')
    getORremove=0;
end
chainID=regexp(chainID,'\s+','split');
temp=ismember({ca.subunit},chainID);
if getORremove
    temp=temp==0;
end
ca=ca(temp);