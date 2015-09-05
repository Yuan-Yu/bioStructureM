function [structure]=readPDB(pdbName,checkMissing,pdbType,isAssignMass)
%%%%%%%%%%%%%%%% need cafrompdb,getAtomByAtomName,getBondLengths%%%%%%%%%%%%%%%%%%
% input:
%   pdbName: The name of the pdb file
%   checkMissing: The value of this is 0 or 1. Setting 0 meams that do not check missing residues.
%   pdbType: 'X-ray' or 'NMR'. (Default is X-ray).
%   isAssignMass :This option can be 0 or 1. Default 1 mean assinging mass.
% return:
%   structure is a structure array. 
%		The structure contain attribute below
%                                 resname
%                                 atmname
%                                 resno
%                                 coord
%                                 bval
%                                 subunit
%                                 record
%                                 atomno
%                                 occupancy
%                                 segment
%                                 elementSymbol
%                                 alternate
%                                 charge
%%%%%%%%%%%%%%%% need cafrompdb,getAtomByAtomName,getBondLengths%%%%%%%%%%%%%%%%%%
if ~exist('pdbType','var')
    pdbType='X-ray';
end
if ~exist('checkMissing','var')
    checkMissing=0;
end
if ~exist('isAssignMass','var')
    isAssignMass=1;
end
try
    structure=atomfrompdb(pdbName,pdbType);
    if ~iscell(structure) && isAssignMass
        structure = setElementSymbol(structure);
        structure = assignMass(structure);
    elseif isAssignMass
        for i =1:length(structure)
            structure{i}=setElementSymbol(structure{i});
            structure{i}=assignMass(structure{i});
        end
    end
catch e
    if length(strtrim(pdbName))==4
        structure=atomfromPDBID(pdbName,pdbType);
    else 
        rethrow(e);
    end
end

%% %%%%%% check missing residues %%%%%%%%% 
if checkMissing
    if ~iscell(structure)
        chains=separatePDBByChain(structure);
        flag=0;
        ermsg=[];
        for chainIndex=1:length(chains)
            currentChain=getAtomByAtomName(chains{chainIndex},'CA');
            bonds=getBondLengths(currentChain);
            if ~isempty(find(bonds>4.3,1))
                flag=1;
                miss=find(bonds>4.3);
                ermsg=strcat(ermsg,[currentChain(1).subunit '\n']);
                for i=miss'
                    ermsg=strcat(ermsg,['\tresno: ' currentChain(i).resno ' to ' currentChain(i+1).resno ' distance=' num2str(bonds(i)) '\n']);
                end
            end
        end
    else
        flag=0;
        ermsg=[];
        for modelIndex=1:length(structure)
            chains=separatePDBByChain(structure{modelIndex});
            for chainIndex=1:length(chains)
                currentChain=getAtomByAtomName(chains{chainIndex},'CA');
                bonds=getBondLengths(currentChain);
                if ~isempty(find(bonds>4.3,1))
                    flag=1;
                    miss=find(bonds>4.3);
                    ermsg=strcat(ermsg,[currentChain(1).subunit ':' 'MDL-' num2str(modelIndex) '\n']);
                    for i=miss'
                        ermsg=strcat(ermsg,['\tresno: ' currentChain(i).resno ' to ' currentChain(i+1).resno ' distance=' num2str(bonds(i)) '\n']);
                    end
                end
            end
        end
    end
    if flag
        error('Useful_func:missResiduesError',sprintf(['The ' pdbName ' have some missing residues:\n' ermsg]));
    end
end
    