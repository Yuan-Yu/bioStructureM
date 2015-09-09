function [PDBStructure]=setElementSymbol(PDBStructure,elementSymbolList)
%%%%%%%%%%%%%%%%%%% need %%%%%%%%%%%%%%%%%%%%%%
% Set the elementSymbolList for PDB structure array
% If elementSymbolList is not given, elementSymbolList will be guessed.
%
% input:
%   PDBStructure: the structure from readPDB function
%   elementSymbolList: a cell array contain the elementSymbol
% return:
%   PDBStructure: the pdb structure that has modifed elementSymbol
%%%%%%%%%%%%%%%%%%% need %%%%%%%%%%%%%%%%%%%%%%

atomNum = length(PDBStructure);
if exist('elementSymbolList','var')
    for i = 1:atomNum
        PDBStructure(i).elementSymbol=elementSymbolList{i};
    end
else
   load atomName2element.mat
   isKey=ismember({PDBStructure.atmname},atomName2element.keys);
   for i = 1:atomNum
       atomName = PDBStructure(i).atmname;
       if isKey(i)
           PDBStructure(i).elementSymbol=atomName2element(atomName);
       else
           if isstrprop(atomName(1),'digit')
               PDBStructure(i).elementSymbol= atomName(2);
           else
               PDBStructure(i).elementSymbol= atomName(1);
           end
       end
   end
end