function [ca]=getChainFromCa(ca,chainID)
%#
%The ca is the object gotton from caformpdb
%return index format is like 
%   chain1_atom1    chain1_atom2    chain1_atom3    chain1_atom4 -------
%   chain2_atom1    chain2_atom2    chain2_atom3    chain2_atom4 -------
%   chain3_atom1    chain3_atom2    chain3_atom3    chain3_atom4 -------
%         |               |              |                 |   
%         |               |              |                 |   
atomChainList=[ca.subunit];
ca=ca(atomChainList==chainID);