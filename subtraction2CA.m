function [ dR ] = subtraction2CA( ca1,ca2 )
%##### need superimpose.m,ExtractSameCA.m######
%Fist extractsameCA between ca1 and ca2.
% After superimpose ca1 to ca2, ca1-ca2.
%return dR is the delta R(N*3) is like COORD format. 
   [ca1,ca2]=ExtractSameCA(ca1,ca2);
   [ca1]=superimpose(ca1,ca2);
   coord1=Coordfromca(ca1);
   coord2=Coordfromca(ca2);
   dR=coord1-coord2;
end

