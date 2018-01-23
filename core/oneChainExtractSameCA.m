function [newCA1,newCA2,StrX,StrY]=oneChainExtractSameCA(ca1,ca2)
%######## need dict.mat,PA.m,getAtomByAtomName,getbackbone#############
% input:
%  Ca1
%  Ca2 is the object get from readPDB
% return:
%   newCA1
%   newCA2 is the object get from readPDB
%######## need dict.mat,PA.m,getAtomByAtomName,getbackbone#############
    load('dict.mat');
    alltmpID1 = [ca1.internalResno];
    alltmpID2 = [ca2.internalResno];
    tempca1=getAtomByAtomName(ca1,'CA');
    tempca2=getAtomByAtomName(ca2,'CA');
try
%% 
    indexOfres=1;
    numTempCa1 = length(tempca1);
    numTempCa2 = length(tempca2);
    if numTempCa1 == 0 || numTempCa2 == 0 
        newCA1 = [];
        newCA2 = [];
        StrX ='';
        StrY = '';
        return
    end
    resno1 = zeros(length(tempca1),1);
    for i=1:numTempCa1
        if dict.containsKey(tempca1(i).resname)
            resName1(indexOfres,1) = dict.get(tempca1(i).resname);
            resno1(indexOfres,1) = tempca1(i).internalResno;
            indexOfres=indexOfres+1;
        end
    end
    indexOfres=1;
    resno2 = zeros(length(tempca2),1);
    for i=1:numTempCa2
        if dict.containsKey(tempca2(i).resname)
            resName2(indexOfres,1)=dict.get(tempca2(i).resname);
            resno2(indexOfres,1) = tempca2(i).internalResno;
            indexOfres=indexOfres+1;
        end
    end
%% 
    [StrX, StrY, Index_Seq1_Seq2, Align_Num TraceBack] = PA (resName1, resName2);
    [row col]=find(Index_Seq1_Seq2);
    %get the fist non-zero column index
    newCA1=ca1(ismember(alltmpID1,resno1(Index_Seq1_Seq2(1,col(1):end))));
    newCA2=ca2(ismember(alltmpID2,resno2(Index_Seq1_Seq2(2,col(1):end))));
    %%%%%% new for test
    atomPerRes1 = getAtomNumPerRes(newCA1);
    atomPerRes2 = getAtomNumPerRes(newCA2);
    check = atomPerRes1 ~= atomPerRes2;
    if sum(check) ~=0
        newInternalResno1 = [newCA1.internalResno];
        uniqueInternalResno1 = unique(newInternalResno1);
        newInternalResno2 = [newCA2.internalResno];
        uniqueInternalResno2 = unique(newInternalResno2);
        diffAtomIndex1 = ismember(newInternalResno1,uniqueInternalResno1(check));
        diffAtomIndex2 = ismember(newInternalResno2,uniqueInternalResno2(check));
        % extract backbone
        diffatomName1 = {newCA1(diffAtomIndex1).atmname};
        diffatomName2 = {newCA2(diffAtomIndex2).atmname};
        diffBackboneIndex1 = ismember(diffatomName1,{'C' 'O' 'N' 'CA'});
        diffBackboneIndex2 = ismember(diffatomName2,{'C' 'O' 'N' 'CA'});
        % check is the remain atom same.
        if sum(diffBackboneIndex1) == sum(diffBackboneIndex2)
            % remove the different atom except backbone atome
            diffBackboneIndex1(:) = ~diffBackboneIndex1;
            diffAtomIndex1(diffAtomIndex1) = diffBackboneIndex1;
            newCA1(diffAtomIndex1) = [];
            % remove the different atom except backbone atome
            diffBackboneIndex2(:) = ~diffBackboneIndex2;
            diffAtomIndex2(diffAtomIndex2) = diffBackboneIndex2;
            newCA2(diffAtomIndex2) = [];
        else
            diffBackboneIndex1 = strcmp(diffatomName1,'CA');
            diffBackboneIndex2 = strcmp(diffatomName2,'CA');
            % remove the different atom except backbone atome
            diffBackboneIndex1(:) = ~diffBackboneIndex1;
            diffAtomIndex1(diffAtomIndex1) = diffBackboneIndex1;
            newCA1(diffAtomIndex1) = [];
            % remove the different atom except backbone atome
            diffBackboneIndex2(:) = ~diffBackboneIndex2;
            diffAtomIndex2(diffAtomIndex2) = diffBackboneIndex2;
            newCA2(diffAtomIndex2) = [];
        end
    end
catch e
    rethrow(e);
    baseException = MException('core:oneChainExtractSameCA',['can not align chain ' ca1(1).subunit ' of pdbStructure1 to chain ' ca2(1).subunit ' of pdbStructure2']);
    baseException = addCause(baseException,e);
    throw(baseException);
end
        