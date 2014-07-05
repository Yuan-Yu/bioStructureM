function [ca]=filterOutResWithoutCA(ca)
%%%%% need getAtomByAtomName,getAtomByResno%%%%%%%%
% input:
%    ca
% return:
%    ca
%%%%% need getAtomByAtomName,getAtomByResno%%%%%%%%
[resno_cell,chainID]=getResnoFromCA(ca);
for i=1:length(chainID)
    temp=getAtomByAtomName(getAtomByResno(ca,resno_cell(i),chainID(i)),'CA');
    resno_cell{i}=[temp.resno];
end
ca=getAtomByResno(ca,resno_cell,chainID);