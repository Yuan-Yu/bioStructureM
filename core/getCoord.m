function [COORD]=getCoord(pdbStruture)
%%%%%%%%%%%%%%% need %%%%%%%%%%%%%%
%#ca is the object gotten from cafrompdb
%return COORD. the format of COORD is like 	atom1_x		atom1_y		atom1_z
%											atom2_x		atom2_y		atom2_z
%											atom3_x		atom3_y		atom3_z
%%%%%%%%%%%%%%% need %%%%%%%%%%%%%%											|			|			|
    numOfAtom=length(pdbStruture);
    COORD=reshape([pdbStruture.coord]',numOfAtom,3);
end
    