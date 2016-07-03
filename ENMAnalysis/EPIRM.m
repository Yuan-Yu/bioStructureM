function [PDB_Structure,EPIRMVal,S_EPIRM,FLUC_INT,FLUC_EXT,FLUC_ALL] = EPIRM(PDB_Structure,mode,checkeigenvalue,S_eGNM,cutOff)
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
        [PDB_Structure,S_eGNM]=eGNM(PDB_Structure,res_num*3-3,1,cutOff);
    end
    
% U is the EPIRM modes (rigid-rot removed); U1 is the rigid rotation vector in each mode
	[U_rot_removed,FLUC_INT,FLUC_EXT,FLUC_ALL] = get_remove_rigid_body_rotation_eGNM(PDB_Structure,S_eGNM); 

% taking the U from EPIRM to reassemble covariance that is later decomposed again to generate orthonormal U2
	S_eGNM = diag(S_eGNM);
	Hessian = U_rot_removed*S_eGNM*U_rot_removed';
	Hessian = (Hessian + Hessian')/2.0;
	[U_EPIRM,S_EPIRM] = eig(Hessian);

	S_EPIRM = diag(S_EPIRM);

%% %%%% check result %% %%%%
	if checkeigenvalue
    	tmp = sum(S_EPIRM(1:10)>10^(-9));
    	if tmp>4
        	error('Useful_func:eigError','The number of zero eigenvalues is less than 6');
    	elseif tmp<4
        	error('Useful_func:eigError','There are more than six zero eigenvalues contained.')
    	end
	end
%% %%%% put result into structure %% %%%%
	lastmode = mode + 6;
    PDB_Structure = setCoordLikeData(PDB_Structure,U_EPIRM(:,7:lastmode),'EPRIM');
    EPIRMVal = S_EPIRM(7:lastmode);
end
