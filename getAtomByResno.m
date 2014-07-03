function newca=getAtomByResno(ca,resno,chainIDs)
%%%%%%%%%%% need %%%%%%%%%%%%
% input:
%   ca is the object gotten from cafrompdb.
%   resno is tne cell that contain the resno.
%	chainIDs is a array that contain the chainID.
%	Ex.
%		if ca is a two chain object,
%		format of resno is 		[chain1_resno1 chain1_resno2 chain1_resno3 chain1_resno4]
%								[chain2_resno1 chain2_resno2 chain2_resno3 chain2_resno4 chain2_resno5]
%		format of chainIDs  is [chain1_ID chain2_ID]
%	note:
%		if ca is a one chain object,
%		format of resno can be array, and chainIDs is not need.
% return:
%   ca is the object that contain the atom.
%%%%%%%%%%% need %%%%%%%%%%%%
if ~iscell(resno)
	resnoMatrix=[ca.resno];
	index=ismember(resnoMatrix,resno);
	newca=ca(index);
else
    newca=[];
    for i=1:length(chainIDs)
        chain=getChainFromCa(ca,chainIDs(i));
        resnoMatrix=[chain.resno];
        index=ismember(resnoMatrix,resno{i});
        newca=[newca,chain(index)];
    end
end