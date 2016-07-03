function [pdbStructure,GNMValue]=GNM(pdbStructure,mode,cutOff)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%   pdbStructure is the structure that gotten from cafrompdb.
%   mode is a number the meaning is how many mode do you want.
%   cutOff: if the distance of two atom is less than cutOff,the two atom
%       is contact to each other.
%
% return:
%   pdbStructure is the structure that contain GNM attribute.(ex pdbStructure(indexOfAtom).GNM or pdbStructure(indexOfAtom).GNMValue)
%   the format is like
%       pdbStructure(indexOfAtom).GNM(modth)=the eigenvector of the n GNM mode of the atom.
%       pdbStructure(indexOfAtom).GNMValue(modth)=the eigvalue of the n GNM mode.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set parameter%%%
if ~exist('mode','var')
    mode = length(pdbStructure) - 1;
end
if ~exist('cutOff','var')
    cutOff=7.3;
end
%%%%%%%%%%%%%%%%%%

% check parameter%%%
if mode+1>length(pdbStructure)
    error('Useful_func:argumentWrong','mode exceeds number of residues');
end
%%%%%%%%%%%%%%%%%%%%

contactMatrix=getContactMatrix(pdbStructure,cutOff);
[U,S]=eig(contactMatrix);
S=diag(S);

if S(1)>10^(-9)
    error('Useful_func:eigError','warning: the first eigenvalue is not zero.');
end
if S(2)<10^(-9)
	error('Useful_func:eigError','warning: There are more than one zero eigenvalue.')
end
lastMode=1+mode;
for i=1:length(pdbStructure)
    for j=2:lastMode
        pdbStructure(i).GNM(j-1,1)=U(i,j);
    end
end
GNMValue = S(2:lastMode);
end
