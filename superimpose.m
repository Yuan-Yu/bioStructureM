function [ca1,eRMSD]=superimpose(ca1,ca2)
%%%%%%%%  need rmsdfit.m,getCoordfromca %%%%%%%%%
%the  ca1 and ca2 are the object gotten from cafrompdb 
%the numbers of residus of ca1 and ca2 must be same
% superimpose ca1 to ca2 
%return ca1 is be superimposed
%		eRMSD is the root-mean-square deviation of the two ca.
%%%%%%%%  need rmsdfit.m,getCoordfromca %%%%%%%%%
    COORD1=getCoordfromca(ca1);
    COORD2=getCoordfromca(ca2);
    [R,T,eRMSD,oRMSD,newCOORD1]=rmsdfit(COORD2,COORD1);
    for i=1:length(ca1)
        ca1(i).coord(:)=newCOORD1(i,:);
    end