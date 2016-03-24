function [pdbStructure] = assignInternalResno(pdbStructure)
%%%%%%%%%%%%%%%%%%%%
% reassign the internalresidue id 
% input:
%   pdbStructure:
% return:
%   pdbStructure
%%%%%%%%%%%%%%%%%%%%
interalResno = 0;
iCodes = {pdbStructure.iCode};
alternates = {pdbStructure.alternate};
resnos = {pdbStructure.resno};
segments = {pdbStructure.segment};
issameRes = false(1,length(pdbStructure));
issameRes(2:end)= strcmp(iCodes(2:end),iCodes(1:end-1)) & strcmp(resnos(2:end),resnos(1:end-1)) & strcmp(alternates(2:end),alternates(1:end-1)) & strcmp(segments(2:end),segments(1:end-1));

for i =1:length(pdbStructure)
    if issameRes(i)
        pdbStructure(i).internalResno = interalResno;
    else
        interalResno = interalResno + 1;
        pdbStructure(i).internalResno = interalResno;
    end
end