function [gnmEigVector]=getGNM(pdb,modth)
%%%%%%%%%%%%% need %%%%%%%%%%%%%%
% input:
%   pdb is the structure gotten from cafrompdb.
%   modth is an array that the modth you want.
% return:
%   gnmEigVector:
%   the format is like
%           
%       mode1_atom1     mode2_atom1     mode3_atom1 ------
%       mode1_atom2     mode2_atom2     mode3_atom2 ------
%       mode1_atom3     mode2_atom3     mode3_atom3 ------
%       mode1_atom4     mode2_atom4     mode3_atom4 ------
%           |               |               |
%           |               |               |
gnmEigVector=[pdb.GNM]';
gnmEigVector=gnmEigVector(:,modth);
end