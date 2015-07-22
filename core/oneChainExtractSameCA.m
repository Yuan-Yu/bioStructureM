function [newCA1,newCA2,StrX,StrY]=oneChainExtractSameCA(ca1,ca2)
%######## need dict.mat,PA.m,getAtomByAtomName#############
%  Ca1,Ca2 is the object get from cafrompdb.m 
%return newCA1 and newCA2 is the object get from cafrompdb. But only contain the same Ca atom.
    load('dict.mat');
    alltmpID1 = [ca1.tmpResID];
    alltmpID2 = [ca1.tmpResID];
    tempca1=getAtomByAtomName(ca1,'CA');
    tempca2=getAtomByAtomName(ca2,'CA');
try
%% 
    indexOfres=1;
    resno1 = zeros(length(tempca1),1);
    for i=1:length(tempca1)
        if dict.containsKey(tempca1(i).resname)
            resName1(indexOfres,1) = dict.get(tempca1(i).resname);
            resno1(indexOfres,1) = tempca1(i).tmpResID;
            indexOfres=indexOfres+1;
        end
    end
    indexOfres=1;
    resno2 = zeros(length(tempca2),1);
    for i=1:length(tempca2)
        if dict.containsKey(tempca2(i).resname)
            resName2(indexOfres,1)=dict.get(tempca2(i).resname);
            resno2(indexOfres,1) = tempca1(i).tmpResID;
            indexOfres=indexOfres+1;
        end
    end
%% 
    [StrX, StrY, Index_Seq1_Seq2, Align_Num TraceBack] = PA (resName1, resName2);
    [row col]=find(Index_Seq1_Seq2);
    %get the fist non-zero column index
    newCA1=ca1(ismember(alltmpID1,resno1(Index_Seq1_Seq2(1,col(1):end))));
    newCA2=ca2(ismember(alltmpID2,resno2(Index_Seq1_Seq2(2,col(1):end))));
    if length(newCA1)~=length(newCA2)
        baseException = MException('core:oneChainExtractSameCA','duplicate resid');
        throw(baseException);
    end
catch e
    baseException = MException('core:oneChainExtractSameCA',['can not align chain ' ca1(1).subunit ' of pdbStructure1 to chain ' ca2(1).subunit ' of pdbStructure2']);
    baseException = addCause(baseException,e);
    throw(baseException);
end
        