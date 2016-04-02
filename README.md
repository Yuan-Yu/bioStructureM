# bioStructureM
a basic matlab package  for analysis protein structure
- - - - -
## Quick Start
Import **bioStructureM** path to Matlab  

    addpath('your_bioStructureM_root/core');  
    addpath('your_bioStructureM_root/atomselector');  

### Read local pdb file (ex. [1BFG](http://www.rcsb.org/pdb/explore/explore.do?structureId=1BFG)).
The pdbStruct is a [MATLAB structure array](http://www.mathworks.com/help/matlab/ref/struct.html) contain several fields :
- resnam:
- resname:
- atomno:
- atmname:
- resno:
- iCode:
- coord:
- bval:
- subunit:
- occupancy:
- alternate:
- charge:
- segment:
- elementSymbol:
- internalResno:  

    pdbStruct = readPDB('1BFG.pdb');

### Get coordinate data  
The return of `getCoord` is a n by 3 array. Where the "n" is number of atoms of the pdbStruct.

    crd = getCoord(pdbStruct);

### Get other attributes of the pdb
For the ***double*** format data

    bfactor = [pdbStruct.bval];  % bfactor is an double array.
For the ***string*** format data  

    atomName = {pdbStruct.atomname}; % atom Name is a cell array.  

### Get center of geometry      

    gcenter = getGeometrycenter(pdbStruct);  

### Get center of mass
Before using `getCenterOfMass`, assigning mass to each atom is needed.  

    pdbStruct = assignMass(pdbStruct);
    mcenter = getCenterOfMass(pdbStruct);

### Atom selection
