function [PDB_Structure,EPIRMVal,Fluc_int,Fluc_ext,Fluc_all] = EPIRM(PDB_Structure,mode,checkeigenvalue,cutOff,S_eGNM)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EPIRM: An ENM model that remove the rigid-body rotational contribution in the native internal fluctuationsof eGNM
% by removing the rotational velocity of each mode from the total velocity of each mode.
% input:
%   PDB_Structure is the structure that gotten from cafrompdb.
%   mode is a number the meaning is how many mode do you want.
%   checkeigenvalue: to check eigenvalues or not. Default = 1.
%   cutOff: if the distance of two atom is less than cutOff,the two atom is contact to each other.
%
% return:
%   PDB_Structure is the structure that contain EPIRM attribute.(ex. PDB_Structure(indexOfAtom).EPIRM)
%   the format is like
%       PDB_Structure(indexOfAtom).EPIRM(modth)=the eigenvectors of the n EPIRM mode of the atom.
%   EPIRMVal: EPIRM eigenvalues after removing top six zeros modes.
%   Fluc_int: mean square fluctuation profile for only inter-node vibrational contributions.
%   Fluc_ext: mean square fluctuation profile for rigid-body rotational contributions.
%   Fluc_all: total mean square fluctuation profile. The fluctuation profile is all (Nx1).
%
% Editor: Hong-Rei
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    res_num = length(PDB_Structure);

	if ~exist('mode','var')
    	mode = res_num*3 - 3;
	end

	if mode + 3 > res_num*3
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
	S_EPIRM = S_eGNM;
	U_EPIRM = U_rot_removed;

%% %%%% put result into structure %% %%%%
    PDB_Structure = setCoordLikeData(PDB_Structure,U_EPIRM,'EPIRM');
    EPIRMVal = S_EPIRM;
end
