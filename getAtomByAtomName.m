function [ca]=getAtomByAtomName(ca,atomName)
%%
% input:
%   ca is the object got from cafrompdb.
%   atomName is the string array. ex. [CA] or [CA N O]
% output:
%   ca  is same as input ca, but just contain target atoms
%%
atomName=regexp(atomName,'\s+','split');
atom=containers.Map(atomName, ones(1,length(atomName)));
temp=[];
for i=1:length(ca)
    if atom.isKey(strtrim(ca(i).atmname))
        temp=[temp,i];
    end
end
ca=ca(temp);