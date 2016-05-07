function [atomStructure] = createAtom(resname,atmname,coord,record,subunit,bval,atomno,resno)
%%%%%%%%%%%%%%% need %%%%%%%%%%%%%%%
% input:
%   resname      (chars)
%   atomname     (chars)
%   coord        (3*1 double)
%   record       (chars)
%   subunit      (chars)
%   bval         (double)
%   atomno       (double)
%   resno        (chars)
%   elementSmbol (chars)
%%%%%%%%%%%%%%% need %%%%%%%%%%%%%%%

if ~exist('resname','var')
    e = MException('core:noresname','resname is not defined');
    throw(e);
end
if ~exist('atmname','var')
    e = MException('core:noatmname','atmname is not defined');
    throw(e);
end
if ~exist('coord','var')
    coord = [0; 0 ;0];
end
if ~exist('record','var')
    record = 'ATOM';
end
if ~exist('subunit','var')
    subunit = 'A';
end
if ~exist('bval','var')
    bval = 0;
end
if ~exist('atomno','var')
    atomno = 1;
end
if ~exist('resno','var')
    resno = '1';
elseif class(resno) == 'double'
    resno = num2str(resno);
end



atomStructure.resname = resname;
atomStructure.record = record;
atomStructure.atomno = atomno;
atomStructure.atmname = atmname;
atomStructure.resno = resno;
atomStructure.iCode = '';
atomStructure.coord = coord;
atomStructure.bval = bval;
atomStructure.subunit = subunit;
atomStructure.occupancy = 0;
atomStructure.alternate = ' ';
atomStructure.charge = '';
atomStructure.segment = '';
atomStructure = setElementSymbol(atomStructure);
atomStructure = assignMass(atomStructure);


