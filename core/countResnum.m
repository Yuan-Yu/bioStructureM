function [current_ResidueID]=countResnum(PDBStructure)
%%%%%%%%%%%%%%% need %%%%%%%%%%%%%%
% count the total number of residues which contain protein,ion,water....
% input:
%   PDBStructure: the structure array gotten by readPDB.
% return:
%   resnum: number of residues
%%%%%%%%%%%%%%% need %%%%%%%%%%%%%%
atomNum=length(PDBStructure);
current_ResidueID=1;
last_ResidueNum_iCode=[ PDBStructure(1).resno  PDBStructure(1).iCode PDBStructure(1).segment];
for i = 1:atomNum
    current_ResidueNum_iCode = [ PDBStructure(i).resno  PDBStructure(i).iCode PDBStructure(i).segment];
    if ~strcmp(last_ResidueNum_iCode,current_ResidueNum_iCode)
        current_ResidueID =current_ResidueID+1;
        last_ResidueNum_iCode =current_ResidueNum_iCode;
    end
end