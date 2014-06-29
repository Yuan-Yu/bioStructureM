function [newCA1,newCA2]=ExtractSameCA(ca1,ca2)
%######## need dict.mat and PA.m#############
%  Ca1,Ca2 is the object get from cafrompdb.m 
%return newCA1 and newCA2 is the object get from cafrompdb. But only contain the same Ca atom.
    load('dict.mat');
    tempca1=getAtomByAtomName(ca1,'CA');
    tempca2=getAtomByAtomName(ca2,'CA');
%% 
    for i=1:length(tempca1)
        resName1(i,1)=dict.get(tempca1(i).resname);
    end
    for i=1:length(tempca2)
        resName2(i,1)=dict.get(tempca2(i).resname);
    end
%% 
    [StrX, StrY, Index_Seq1_Seq2, Align_Num TraceBack] = PA (resName1, resName2);
    [row col]=find(Index_Seq1_Seq2);
    %get the fist non-zero column index
    sameca1=tempca1(Index_Seq1_Seq2(1,col(1):end));
    sameca2=tempca2(Index_Seq1_Seq2(1,col(1):end));
    newCA1=getAtomByResno(ca1,[sameca1.resno]);
    newCA2=getAtomByResno(ca2,[sameca2.resno]);
        