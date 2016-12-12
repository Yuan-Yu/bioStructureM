function [PDB_Structure,AeGNMVal] = AeGNM(PDB_Structure,mode,checkeigenvalue,cutOff,contactConstant,bondConstant,bond)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AeGNM: An ENM model that combine ANM and eGNM potential together.
% input:
%   PDB_Structure is the structure that gotten from cafrompdb.
%   mode is a number the meaning is how many mode do you want.
%   checkeigenvalue: to check eigenvalues or not. Default = 1.
%	contactConstant: Default = 1.
%   bondConstant: Default = 1.
%   bond: Default = 0.
%   cutOff: if the distance of two atom is less than cutOff,the two atom is contact to each other.
%
% return:
%   PDB_Structure is the structure that contain AeGNM attribute.(ex. PDB_Structure(indexOfAtom).AeGNM)
%   the format is like
%       PDB_Structure(indexOfAtom).AeGNM(modth)=the eigenvectors of the n AeGNM mode of the atom.
%   AeGNMVal: AeGNM eigenvalues after removing top three zeros modes.
%
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

	if ~exist('contactConstant','var')
    	contactConstant = 1;
    	bondConstant = 1;
    	bond = 0;
    end

	contactMatrix = getGNMContactMatrix(PDB_Structure,cutOff);
	eGNM_Hessian = kron(contactMatrix,eye(3));
	ANM_Hessian = getANMHes(PDB_Structure,cutOff,contactConstant,bondConstant,bond);
	AeGNM_Hessian = ANM_Hessian + eGNM_Hessian;
	[U_AeGNM,AeGNMVal] = eig(AeGNM_Hessian);
	AeGNMVal = diag(AeGNMVal);


%% %%%% check result %% %%%%%%%%%%%%%%%%%
	if checkeigenvalue
    	tmp = sum(abs(AeGNMVal(1:10))>10^(-9));
    	if tmp>7
        	error('Useful_func:eigError','The number of zero eigenvalues is less than 3');
    	elseif tmp<7
        	error('Useful_func:eigError','There are more than three zero eigenvalues contained.')
    	end
	end
%% %%%% put result into structure %% %%%%
	lastmode = mode + 3;
    AeGNMVal = AeGNMVal(4:lastmode);
    PDB_Structure = setCoordLikeData(PDB_Structure,U_AeGNM(:,4:lastmode),'AeGNM');
end
