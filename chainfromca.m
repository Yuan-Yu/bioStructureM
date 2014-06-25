function [ca]=chainfromcabyID(ca,chainID)
%#
%The ca is the object gotton from caformpdb
%return index format is like 
%   chain1_atom1    chain1_atom2    chain1_atom3    chain1_atom4 -------
%   chain2_atom1    chain2_atom2    chain2_atom3    chain2_atom4 -------
%   chain3_atom1    chain3_atom2    chain3_atom3    chain3_atom4 -------
%         |               |              |                 |   
%         |               |              |                 |   
resnum=length(ca);
index=[1:resnum];
chain=[ca.subunit];
chainkind=unique(chain);
temp=[];
temp=[temp diag(chain==chainID)];
temp=index*temp;
chain_index=reshape(temp,resnum,1)';
chain_index(chain_index==0)=[];
ca=ca(chain_index);