function newca=getAtomByResno(ca,resno)
%%%%%%%%%%% need %%%%%%%%%%%%
% input:
%   ca is the object gotten from cafrompdb.
%   resno is tne array that contain the resno
% return:
%   ca is the object that contain the atom.
%%%%%%%%%%% need %%%%%%%%%%%%
resnoMatrix=[ca.resno];
index=ismember(resnoMatrix,resno);
newca=ca(index);