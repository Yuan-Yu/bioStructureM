function [PDB_Structure,eGNMVal] = eGNM(PDB_Structure,mode,checkeigenvalue,cutOff)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eGNM: An ENM model that expand the N by N isotropic GNM hessian into a 3N by 3N isotropic model
% by doing tensor product (GNM_Hessian x I(3,3)).
% input:
%   PDB_Structure is the structure that gotten from cafrompdb.
%   mode is a number the meaning is how many mode do you want.
%   checkeigenvalue: to check eigenvalues or not. Default = 1.
%   cutOff: if the distance of two atom is less than cutOff,the two atom is contact to each other.
%
% return:
%   PDB_Structure is the structure that contain eGNM attribute.(ex. PDB_Structure(indexOfAtom).eGNM)
%   the format is like
%       PDB_Structure(indexOfAtom).eGNM(modth)=the eigenvectors of the n eGNM mode of the atom.
%   eGNMVal: eGNM eigenvalues after removing top three zeros modes.
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

	contactMatrix = getGNMContactMatrix(PDB_Structure,cutOff);
	eGNM_contactMatrix = kron(contactMatrix,eye(3));
	[U_eGNM,eGNMVal] = eig(eGNM_contactMatrix);
	eGNMVal = diag(eGNMVal);


%% %%%% check result %% %%%%%%%%%%%%%%%%%
	if checkeigenvalue
    	tmp = sum(abs(eGNMVal(1:10))>10^(-9));
    	if tmp>7
        	error('Useful_func:eigError','The number of zero eigenvalues is less than 3');
    	elseif tmp<7
        	error('Useful_func:eigError','There are more than three zero eigenvalues contained.')
    	end
	end
%% %%%% put result into structure %% %%%%
	lastmode = mode + 3;
    eGNMVal = eGNMVal(4:lastmode);
    PDB_Structure = setCoordLikeData(PDB_Structure,U_eGNM(:,4:lastmode),'eGNM');
end
