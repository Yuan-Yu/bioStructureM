# bioStructureM
a basic matlab package with VMD-like selection snytax for analysis protein structure
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
        - [chain c.](#as-chain)
        - [segment segid](#as-segment)
        - [atomnum atomicnumber](#as-atomnum)
        - [x y z](#as-xyz)  
    - [Single keywords](#single-keywords)
    - [Selection operator](#selection-operator)
        - [and &](#as-and)
        - [or |](#as-or)
        - [not](#as-not)
        - [within {distance} of ](#as-within)
        - [byres](#as-byres)
        - [bychain](#as-bychain)
        - [()](#as-br)  
    - [Set attribute by selection](#set-attribute-by-selection)
    - [Save a new PDB file](#save-a-new-pdb-file)

- - - - -
## Quick Start
### Import path
Import **bioStructureM** path to [Matlab](http://www.mathworks.com/products/matlab/)  

    addpath('your_bioStructureM_root/core');  
    addpath('your_bioStructureM_root/atomselector');  

### Read local pdb file (ex. [1BFG](http://files.rcsb.org/view/1BFG.pdb)).<p name=one>
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

    atomName = {pdbStruct.atmname}; % atom Name is a cell array.  

### Get center of geometry      

    gcenter = getGeometrycenter(pdbStruct);  

### Get center of mass
Before using `getCenterOfMass`, assigning mass to each atom is needed.  

    pdbStruct = assignMass(pdbStruct);
    mcenter = getCenterOfMass(pdbStruct);  
<p name=atom-selection-as></p>  

### Atom selection (as)  
Use VMD-like syntax to select specific atoms.  
Select by atom name.  

    CaStruct = as('name CA',pdbStruct);
Select by residues id  

    T73 = as('resi 73',pdbStruct);
Select protein  or water  

    protein  = as('protein',pdbStruct);
    water = as('water',pdbStruct);  
**The return of "as" is a structure array that has same fields as original structure**
#### Simple Selection<a name=as-name></a>  
- **name atomname** {selected-atom-names}
Using space as delimiter to separate the different atom names.  

        as('name CA C O N',pdbStruct)
        as('atomname CA C O N',pdbStruct)
"name" and "atomname" support simple regular expression. For example "name H*", this
 command will select all the atoms which the names is H1,H2,HD1... etc.     

       as('name H*',pdbStruct)
Because of supporting regular expression, the command to select the "H\*" atoms
 should be "H\\\*".<a name=as-resi></a>
- **resi resid residue**  {selected-resids}  
select by residue ids  

        as('resi 73 80',pdbStruct)
        as('resid 73 80',pdbStruct)
select sequence residue ids: start:step:end or start:end  

        as('resi 19:90',pdbStruct)
        as('resi 19:2:90',pdbStruct)
        as('resi 19:31 40:60 144',pdbStruct)
<a name=as-record></a>
- **record** {ATOM|HETATM}

        as('record HETATM',pdbStruct)
<a name=as-insertion></a>
- **insertion** {single-character}  
select by insertion code (iCode) of residues  

        as('insertion A',pdbStruct)
        as('insertion A \s',pdbStruct)
"\\s" is used to select the atoms that the insertion code is empty.<a name=as-bval></a>  
- **bval beta** {<|<=|>|>=|=}{value}  
select by specific Temperature factors  

        as('bval >40',pdbStruct)
        as('bval =40',pdbStruct)  
Note: There should have extra space between "bval" and "condition". ex. "bal>40" is
 a wrong represontation.  
<a name=as-resn></a>
- **resn restype** {residue-names}  

        as('resn ALA',pdbStruct)
        as('resn ALA TYR',pdbStruct)
<a name=as-chain></a>
- **chain c.** {one-character-chain-ID}  

        as('c. A',pdbStruct)
        as('c. A B',pdbStruct)
        as('c. \s',pdbStruct)
"\\s" is used to select the atoms that the chain ID is empty.<a name=as-segment></a>  
- **segment segid** {segids}  

        as('segid PROA',pdbStruct)
        as('segment PROA WAT',pdbStruct)
<a name=as-atomnum></a>
- **atomnum atomicnumber** {atom-indexes}   
similar as [resid](#as-resi)  
<a name=as-xyz></a>
- **x y z** {<|<=|>|>=|=}{value}  
similar as [bval](#as-bval)  

#### Single keywords  
        as('protein',pdbStruct)
        as('all',pdbStruct)  

**keywords**:  
- all  
- protein  
- backbone
- water wat  
- nucleic
- het. HETATM  

#### Selection Operator  
        as('protein or water',pdbStruct)
        as('(protein and c. A) or water',pdbStruct)
<a name=as-and></a>
- and &  
Select the **intersection** of two selections  

        as('resi 73 and name CA CB',pdbStruct)
        as('resi 73 and name CA CB and bval >10',pdbStruct)
<a name=as-or></a>
- or |  
Select the **union** of two selections  

        as('protein or water',pdbStruct)

<a name=as-not></a>
- not   
Select all atoms not in selection

        as('not water',pdbStruct)
<a name=as-within></a>
- within {distance} of  

        as('water within 4 of protein',pdbStruct)  
Let's call water as sel1 and protein as sel2. The command would select any atoms
in **sel1** which are wihin 4 **Angstroms**  of any atom in **sel2**.  

<a name=as-br></a>
- ()  
Change the priority of selection command.  
This command would select the O atoms of water only.  

        as('protein and name CA or water and name O',pdbStruct)  
After add () to the command, it can select CA atoms in protein and O atoms in water  

        as('(protein and name CA) or (water and name O)',pdbStruct)  
<a name=as-byres></a>
- byres  
Extend selection to complete residues  

        as('byres (protein within 4 of resi 73)',pdbStruct)

<a name=as-bychain></a>
- bychain  
Extend selection to whole atoms in same chain.  

        as('bychain resi 73',pdbStruct)  

<a name=set-attribute-by-selection></a>
### Set attribute by selection  
This section shows how to set values to specific field and atoms.  

    asSetAttribute('protein',pdbStruct,'segment','PROA')
Change the segment field of protein to "PROA".

    asSetAttribute('all',pdbStruct,'bval',0)
    newCABval = ones(1,144)*100
    asSetAttribute('protein and CA',pdbStruct,'bval',newCABval)  
Set CA atoms bfactor to 100 and set all others to zero.  
**Note: The number of assigned values should be same as number of atoms or a sigle value.**  

<a name=save-a-new-pdb-file></a>
### Save a new PDB file
save pdbStructure as a .pdb file  

    createPDB(pdbStruct,'output_path.pdb')
