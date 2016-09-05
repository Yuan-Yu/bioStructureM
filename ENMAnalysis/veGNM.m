function [PDB_Structure,veGNMVal,Fluc_int,Fluc_ext,Fluc_all] = veGNM(PDB_Structure,mode,checkeigenvalue,cutOff,S_eGNM)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EPIRM: An ENM model that remove the rigid-body rotational contribution in the native internal fluctuationsof eGNM
% by removing the rotational velocity of each mode from the total velocity of each mode.
% veGNM : Reform EPIRM eigenvectors to hessian, and redecompose it to make eigenvectors mutually orthogonal.
% input:
%   PDB_Structure is the structure that gotten from cafrompdb.
%   mode is a number the meaning is how many mode do you want.
%   checkeigenvalue: to check eigenvalues or not. Default = 1.
%   cutOff: if the distance of two atom is less than cutOff,the two atom is contact to each other.
%
% return:
%   PDB_Structure is the structure that contain EPIRM attribute.(ex. PDB_Structure(indexOfAtom).veGNM)
%   the format is like
%       PDB_Structure(indexOfAtom).veGNM(modth)=the eigenvectors of the n veGNM mode of the atom.
%   veGNMVal: veFGNM eigenvalues after removing top six zeros modes.
%   Fluc_int: mean square fluctuation profile for only inter-node vibrational contributions.
%   Fluc_ext: mean square fluctuation profile for rigid-body rotational contributions.
%   Fluc_all: total mean square fluctuation profile. The fluctuation profile is all (Nx1).
%
% Editor: Hong-Rei
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    res_num = length(PDB_Structure);

	if ~exist('mode','var')
    	mode = res_num*3 - 6;
	end

	if mode + 6 > res_num*3
    	error('Useful_func:argumentWrong','mode exceeds res_num*3');
	end


	if ~exist('cutOff','var')
    	cutOff = 15;
    end

    if ~exist('checkeigenvalue','var')
    	checkeigenvalue = 1;
    end
    
    if ~exist('S_eGNM','var') || ~isfield(PDB_Structure,'eGNM') || length(S_eGNM) ~= res_num*3-3 || size(PDB_Structure(1).eGNM,1) ~= res_num*3-3
        [PDB_Structure,S_eGNM] = eGNM(PDB_Structure,res_num*3-3,1,cutOff);
    end
    
% U is the EPIRM modes (rigid-rot removed); U1 is the rigid rotation vector in each mode
	[U_rot_removed,Fluc_int,Fluc_ext,Fluc_all] = get_remove_rigid_body_rotation_eGNM(PDB_Structure,S_eGNM);

% taking the U from EPIRM to reassemble covariance that is later decomposed again to generate orthonormal U2
	S_eGNM = diag(S_eGNM);
	Hessian = U_rot_removed*S_eGNM*U_rot_removed';
	Hessian = (Hessian + Hessian')/2.0;
	[U_veGNM,S_veGNM] = eig(Hessian);

	S_veGNM = diag(S_veGNM);

%% %%%% check result %% %%%%
	if checkeigenvalue
    	tmp = sum(S_veGNM(1:10)>10^(-9));
    	if tmp>4
        	error('Useful_func:eigError','The number of zero eigenvalues is less than 6');
    	elseif tmp<4
        	error('Useful_func:eigError','There are more than six zero eigenvalues contained.')
    	end
	end
%% %%%% put result into structure %% %%%%
    lastmode = mode + 6;
    PDB_Structure = setCoordLikeData(PDB_Structure,U_veGNM(:,7:lastmode),'veGNM');
    S_veGNM = S_veGNM(7:lastmode);
    veGNMVal = S_veGNM;
end
