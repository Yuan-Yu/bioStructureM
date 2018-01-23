function [moved,eRMSD,R,T]=superimpose(moved,target)
%%%%%%%%  need rmsdfit.m,getCoordfromca %%%%%%%%%
%the  moved and terget are the object gotten from readPDB or a n by 3 array
%   where the n is number of atoms.The numbers of atoms of moved and terget must 
%   be same.Superimpose moved to terget 
% input:
%   moved: a structure array gotten from readPDB or n by 3 array
%   terget: a structure array gotten from readPDB or n by 3 array
%return 
%       moved is be superimposed (if input is structure, output is structure too.)
%		eRMSD is the root-mean-square deviation of the two ca.
%       R: rotation matrix
%       T: translation matrix
%%%%%%%%  need rmsdfit.m,getCoordfromca %%%%%%%%%
    if isstruct(moved) && isstruct(target)
        COORD1=getCoordfromca(moved);
        COORD2=getCoordfromca(target);
        [R,T,eRMSD,~,newCOORD1]=rmsdfit(COORD2,COORD1);
        moved = setCoord(moved,true(length(moved),1),newCOORD1);
    elseif ~isstruct(target) && ~isstruct(moved)
        [R,T,eRMSD,~,newCOORD1]=rmsdfit(target,moved);
        moved = newCOORD1;
    elseif isstruct(moved) && ~isstruct(target)
        COORD1=getCoordfromca(moved);
        [R,T,eRMSD,~,newCOORD1]=rmsdfit(target,COORD1);
        moved = setCoord(moved,true(length(moved),1),newCOORD1);
    elseif isstruct(target) && ~isstruct(moved)
        COORD2=getCoordfromca(target);
        [R,T,eRMSD,~,newCOORD1]=rmsdfit(COORD2,moved);
        moved = newCOORD1;
    end
