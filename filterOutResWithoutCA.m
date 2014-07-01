function [ca]=filterOutResWithoutCA(ca)
%%%%% need getAtomByAtomName,getAtomByResno%%%%%%%%
% input:
%    ca
% return:
%    ca
%%%%% need getAtomByAtomName,getAtomByResno%%%%%%%%
temp=getAtomByAtomName(ca,'CA');
resno=[temp.resno];
ca=getAtomByResno(ca,resno);