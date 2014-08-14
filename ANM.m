function [ ca,S ] = ANM( ca,mode )
%%%%%%% need maforceANM.m,readkdatModesANM.m %%%%%%%%%%%
% input:	
%	ca is the object gotten from cafrompdb
%	mode = how many mode do you want
% return:
%	ca object that contain the ANM attribute
%ca(index of atom).ANM matrix is like mode1_x   mode1_y     mode1_z
%                                     mode2_x   mode2_y     mode2_z
%                                     mode3_x   mode3_y     mode3_z
%                                        |          |           |
%                                   lastmode_x  lastmode_y   lastmode_z
%	S is the all eigvalue
%%%%%%% need maforceANM.m,readkdatModesANM.m %%%%%%%%%%%
resnum=length(ca);
[hes]=makeconANM(ca,resnum);
[U,S]=modesANM(hes,resnum);

%U(atomnum/3,mode)
S=diag(S);
lastmode=6+mode;
    for i=1:resnum
        for j=7:lastmode
            ca(i).ANM(j-6,:)=reshape(U((i*3-2):i*3,j),1,3);
            ca(i).ANMValue(j-6)=S(j);
            
        end
    end
end