function [fromStructure,RMSD,R,T]=autoSuperimpose(fromStructure,toStructure,referenceAtomName)
%%%%%%%%%% need getAtomByAtomName,extractSameCA,getCoordfromca,refreshCoordToCA%%%%%%%%%%%
% input:
%   fromStructure and toStructure are object gotten from cafrompdb 
%	fromStructure will be superimposed.
%   toStructure is the referenced structure.
%   referenceAtomName (option)
% return:
%   fromStructure is superimposed structure.
%	RMSD
%	R is the rotation matrix
%	T is the transpose matrix
%%%%%%%%%% need getAtomByAtomName,extractSameCA,getCoordfromca,refreshCoordToCA%%%%%%%%%%%
	if exist('referenceAtomName','var')
		tempfromStructure=getAtomByAtomName(fromStructure,referenceAtomName);
		temptoStructure=getAtomByAtomName(toStructure,referenceAtomName);
	else
		tempfromStructure=fromStructure;
		temptoStructure=toStructure;
	end
    [tempfromStructure,temptoStructure]=extractSameCA(tempfromStructure,temptoStructure,1);
    [R,T,RMSD]=rmsdfit(getCoordfromca(temptoStructure),getCoordfromca(tempfromStructure));
    fromCoord=getCoordfromca(fromStructure);
    fromCoord=fromCoord*R + repmat(T,length(fromStructure),1);
    fromStructure=refreshCoordToCA(fromStructure,fromCoord);