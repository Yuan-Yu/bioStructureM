function [structure]=readPDB(pdbName,checkMissing,pdbType,isAssignMass,alternates)
%%%%%%%%%%%%%%%% need cafrompdb,getAtomByAtomName,getBondLengths%%%%%%%%%%%%%%%%%%
% input:
%   pdbName: The name of the pdb file
%   checkMissing: The value of this is 0 or 1. Setting 0 meams that do not check missing residues.
%   pdbType:  0='X-ray' 1='NMR'. (Default is 0).
%   isAssignMass :This option can be 0 or 1. Default 1 mean assinging mass.
%   alternates: a cell contains allowed alternate strings
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
    pdbType=0;
end
if ~exist('checkMissing','var')
    checkMissing=0;
end
if ~exist('isAssignMass','var')
    isAssignMass=0;
end
if ~exist('alternates','var')
    alternates = {' ','A'};
end
try
    structure=atomfrompdb(pdbName,pdbType);
    if ~iscell(structure)
        structure = setElementSymbol(structure);
        structure = getAtomByAlternate(structure,alternates);
        if isAssignMass
            structure = assignMass(structure);
        end
    else
        for i =1:length(structure)
            structure{i} = getAtomByAlternate(structure{i},alternates); %%% select alternate coord
            structure{i} = setElementSymbol(structure{i});
        end
        if isAssignMass
            for i =1:length(structure)
                structure{i} = assignMass(structure{i});
            end
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
