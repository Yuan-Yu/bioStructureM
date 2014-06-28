function [ca1]=superimpose(ca1,ca2)
%#####  need rmsdfit.m ######################
%the  ca1 and ca2 are the object gotten from cafrompdb 
%the numbers of residus of ca1 and ca2 must be same
% superimpose ca1 to ca2 
%return ca1 is be superimposed
%%
    COORD1=getCoordfromca(ca1);
    COORD2=getCoordfromca(ca2);
    [R,T,eRMSD,oRMSD,newCOORD1]=rmsdfit(COORD2,COORD1);
    for i=1:length(ca1)
        ca1(i).coord(:)=newCOORD1(i,:);
    end