function [newCA1,newCA2]=ExtractSameCA(ca1,ca2)
%######## need dict.mat and PA.m#############
%  Ca1,Ca2 is the object get from cafrompdb.m 
%return newCA1 and newCA2 is the object get from cafrompdb. But only contain the same Ca atom.
    load('dict.mat');
%% 
    for i=1:length(ca1)
        resName1(i,1)=dict.get(ca1(i).resname);
    end
    for i=1:length(ca2)
        resName2(i,1)=dict.get(ca2(i).resname);
    end
%% 
    [StrX, StrY, Index_Seq1_Seq2, Align_Num TraceBack] = PA (resName1, resName2);
    index_new=1;
    for i=1:length(Index_Seq1_Seq2)
        index1=Index_Seq1_Seq2(1,i);
        index2=Index_Seq1_Seq2(2,i);
        if index1 ~=0
            newCA1(index_new)=ca1(index1);
            newCA2(index_new)=ca2(index2);
             index_new= index_new+1;
        end
    end
        