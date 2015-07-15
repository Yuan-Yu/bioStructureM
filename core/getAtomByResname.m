function [ca]=getAtomByResname(ca,resname)
resname=regexp(resname,'\s+','split');
temp=ismember({ca.resname},resname);
ca=ca(temp);