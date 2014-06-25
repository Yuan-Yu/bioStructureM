function [COORD]=getCoordfromca(ca)
%#ca is the object gotten from cafrompdb
%return COORD. the format of COORD is like 	atom1_x		atom1_y		atom1_z
%											atom2_x		atom2_y		atom2_z
%											atom3_x		atom3_y		atom3_z
%												|			|			|
    numOfAtom=length(ca);
    COORD=ones(numOfAtom,3);
    for j=1:numOfAtom
           COORD(j,:)=[ca(j).coord(1) ca(j).coord(2) ca(j).coord(3)];
    end