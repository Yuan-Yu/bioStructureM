# bioStructureM
a basic matlab package  for analysis protein structure
- - - - -
## Quick Start
Import **bioStructureM** path to Matlab  

    addpath('your_bioStructureM_root/core');  
    addpath('your_bioStructureM_root/atomselector');  

### Read local pdb file (ex. [1BFG](http://www.rcsb.org/pdb/explore/explore.do?structureId=1BFG)).
The pdbStruct is a [MATLAB structure array](http://www.mathworks.com/help/matlab/ref/struct.html) contain several fields :
<table>
    <tr>
        <th>Field Name</th>
        <th>Data Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>alternate</td>
        <td>char</td>
        <td>Alternate location indicator </td>
    </tr>
    <tr>
        <td>atomno</td>
        <td>double</td>
        <td>Atom serial number</td>
    </tr>
    <tr>
        <td>atmname</td>
        <td>char</td>
        <td>Atom name. The max length of atmname is 4 Characters.</td>
    </tr>
    <tr>
        <td>bval</td>
        <td>double</td>
        <td>Temperature factor (b-factor)</td>
    </tr>
    <tr>
        <td>charge</td>
        <td>char</td>
        <td>Charge on the atom</td>
    </tr>
    <tr>
        <td>coord</td>
        <td>3 x 1 double</td>
        <td>Coordinates in Angstroms. </td>
    </tr>
    <tr>
        <td>elementSymbol</td>
        <td>char</td>
        <td>Element symbol</td>
    </tr>
    <tr>
        <td>iCode</td>
        <td>char</td>
        <td>Code for insertion of residues</td>
    </tr>
    <tr>
        <td>occupancy</td>
        <td>double</td>
        <td>Occupancy</td>
    </tr>
    <tr>
        <td>record</td>
        <td>char</td>
        <td>Record name can be either **ATOM** or **HETATM**</td>
    </tr>
    <tr>
        <td>resname</td>
        <td>char</td>
        <td>Residue name</td>
    </tr>
    <tr>
        <td>resno</td>
        <td>char</td>
        <td>Residue sequence number</td>
    </tr>
    <tr>
        <td>segment</td>
        <td>char</td>
        <td>Segment identifier</td>
    </tr>
    <tr>
        <td>subunit</td>
        <td>char</td>
        <td>Chain identifier</td>
    </tr>
</table>


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
