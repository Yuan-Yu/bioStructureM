function [ ca,S ] =ANM(ca,mode,checkeigenvalue,cutOff,contactConstant,bondConstant,bond)
%%%%%%% need maforceANM.m,readkdatModesANM.m %%%%%%%%%%%
% input:	
%	ca is the object gotten from cafrompdb
%	mode = how many mode do you want
%   checkeigenvalue
% return:
%	ca object that contain the ANM attribute
%ca(index of atom).ANM matrix is like mode1_x   mode1_y     mode1_z
%                                     mode2_x   mode2_y     mode2_z
%                                     mode3_x   mode3_y     mode3_z
%                                        |          |           |
%                                   lastmode_x  lastmode_y   lastmode_z
%	ANMValue is the all eigvalue
%%%%%%% need maforceANM.m,readkdatModesANM.m %%%%%%%%%%%

%% %%%% set parameter %% %%%%
if ~exist('cutOff','var')
    cutOff=15;
end
if ~exist('contactConstant','var')
    contactConstant=1;
    bondConstant=1;
    bond=0;
end
if ~exist('checkeigenvalue','var')
    checkeigenvalue=1;
end
%% %%%% ANM %% %%%%
resnum=length(ca);
[hes]=getANMHes(ca,cutOff,contactConstant,bondConstant,bond);
if resnum>210
    if mode<4 % get more eigenvalue to check the result quality.
        [U,S]=eigs(hes,4+6,'sm');
    else
        [U,S]=eigs(hes,mode+6,'sm');
    end
    U=fliplr(U);
    S=diag(S);
    S=fliplr(S')';
else
    [U,S]=eig(hes);
	S=diag(S);
end

%% %%%% check result %% %%%%
if checkeigenvalue
    tmp=sum(S(1:10)>10^(-9));
    if tmp>4
        error('Useful_func:eigError','The number of zero eigenvalues is less than 6');
    elseif tmp<4
        error('Useful_func:eigError','There are more than six zero eigenvalues contained.')
    end
end
%% %%%% put result into structure %% %%%%
lastmode=6+mode;
    for i=1:resnum
        for j=7:lastmode
            ca(i).ANM(j-6,:)=reshape(U((i*3-2):i*3,j),1,3);
            ca(i).ANMValue(j-6)=S(j);
            
        end
    end
end