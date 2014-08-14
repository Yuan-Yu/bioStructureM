function [gnmEigVector]=getGNMfromCa(pdb,fromModth,toModth)
%%%%%%%%%%%%% need %%%%%%%%%%%%%%
% input:
%   pdb
%   fromModth
%   toModth
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
if ~exist('toModth','var')
    toModth=fromModth;
end
gnmEigVector=reshape([pdb.GNM;],length([pdb(1).GNM]),length(pdb))';
gnmEigVector=gnmEigVector(:,fromModth:toModth);
