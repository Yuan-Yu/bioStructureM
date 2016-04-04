# bioStructureM
a basic matlab package  for analysis protein structure
## Quick Start  
- [Import path](#import-path)
- [Read local pdb file](#one)
- [Get coordinate data](#get-coordinate-data)
- [Get other attributes of the pdb](#get-other-attributes-of-the-pdb)
- [Get center of geometry](#get-center-of-geometry)
- [Get center of mass](#get-center-of-mass)
- [Atom selection (as)](#atom-selection-as)
    - [Simple Selection](#simple-selection)  
        - [name](#as-name)
        - [resi resid residue](#as-resi)
        - [record](#as-record)
        - [insertion](#as-insertion)
        - [bval beta](#as-bval)
        - [resn restype](#as-resn)
        - [chain c](#as-chain)
        - [segment segid](#as-segment)
        - [atomnum atomicnumber](#as-atomnum)
        - [x y z](#as-xyz)  

- - - - -
## Quick Start
### Import path
Import **bioStructureM** path to Matlab  

    addpath('your_bioStructureM_root/core');  
    addpath('your_bioStructureM_root/atomselector');  

### Read local pdb file (ex. [1BFG](http://files.rcsb.org/header/1BFG.pdb)).<p name=one>
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
        <td>Record name can be either ATOM or HETATM</td>
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
For the ***characters*** format data  

    atomName = {pdbStruct.atomname}; % atom Name is a cell array.  

### Get center of geometry      

    gcenter = getGeometrycenter(pdbStruct);  

### Get center of mass
Before using `getCenterOfMass`, assigning mass to each atom is needed.  

    pdbStruct = assignMass(pdbStruct);
    mcenter = getCenterOfMass(pdbStruct);

### Atom selection (as) <p name=Atom-selection-as></p>
Use VMD-like syntax to select specific atoms.
Select by atom name.  

    CaStruct = as('name CA',pdbStruct);
Select by residues id  

    T73 = as('resi 73',pdbStruct);
Select protein  or water  

    protein  = as('protein',pdbStruct);
    water = as('water',pdbStruct);  
**The return of "as" is a structure array have same fields as original structure**
#### Simple Selection  
- **name atomname** {selected-atom-names}<a name=as-name></a>
Using space as delimiter to separate the different atom names.  

        as('name CA C O N',pdbStruct)
        as('atomname CA C O N',pdbStruct)
"name" and "atomname" support simple regular expression. For example "name H*", this
 command will select all the atoms which the names is H1,H2,HD1... etc.     

       as('name H*',pdbStruct)
Because of the support of regular expression, the command to select the "H\*" atoms
 should be "H\\\*".
- **resi resid residue**  {selected-resids}<a name=as-resi></a>  
select by residue ids  

        as('resi 73 80',pdbStruct)
        as('resid 73 80',pdbStruct)
select sequence residue ids: start:step:end or start:end  

        as('resi 19:90',pdbStruct)
        as('resi 19:2:90',pdbStruct)
        as('resi 19:31 40:60 144',pdbStruct) 

- **record** {ATOM|HETATM}<a name=as-record></a>

        as('record HETATM',pdbStruct)
- **insertion** {single-character}<a name=as-insertion></a>
select by insertion code (iCode) of residues  

        as('insertion A',pdbStruct)
        as('insertion A \s',pdbStruct)
"\\s" is used to select the atoms that the insertion code is empty.  
- **bval beta** {<|<=|>|>=|=}<a name=as-bval></a>
select by specific Temperature factors  

        as('bval >40',pdbStruct)
        as('bval =40',pdbStruct)  
Note: There should have extra space between "bval" and "condition". ex. "bal>40" is
 a wrong represontation.  

- **resn restype** {residue-names}<a name=as-resn></a>  

        as('resn ALA',pdbStruct)
        as('resn ALA TYR',pdbStruct)

- **chain c.** {one-character-chain-ID}<a name=as-chain></a>  

        as('c. A',pdbStruct)
        as('c. A B',pdbStruct)
        as('c. \s',pdbStruct)
"\\s" is used to select the atoms that the chain ID is empty.  
- **segment segid**<a name=as-segment></a>  

        as('segid PROA',pdbStruct)
        as('segment PROA WAT',pdbStruct)

- **atomnum atomicnumber**<a name=as-atomnum></a>  
similar as [resid](#as-resi)  

- **x y z**<a name=as-xyz></a>
similar as [bval](#as-bval)  
