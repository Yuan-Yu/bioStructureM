function [isPass] = unitTestACSetCoord(testpath)
%%%%%%%%%%%%%%%%%
% test accelerator/setCoord
%%%%%%%%%%%%%%%%%
addpath([testpath '/core']);addpath([testpath '/atomselector']);addpath([testpath '/accelerator']);
pdb = readPDB('FGF2_phaser_P212121-coot-12.pdb');
numAtoms = length(pdb);
selectedAtoms = 1:numAtoms;
numsSelectedAtoms = length(selectedAtoms);
newCoord = [ones(numsSelectedAtoms,1) ones(numsSelectedAtoms,1)*2 ones(numsSelectedAtoms,1)*3];
newpdb = setCoord(pdb,selectedAtoms,newCoord);
if any(any(getCoord(newpdb(selectedAtoms)) ~= newCoord)) || any(any(getCoord(pdb(selectedAtoms)) == newCoord))
    error('unitTestACSetCoord failed.');
end
pdb = setCoord(pdb,selectedAtoms,newCoord);
if  any(any(getCoord(pdb(selectedAtoms)) ~= newCoord))
    error('unitTestACSetCoord failed.');
end

addpath([testpath '/core']);addpath([testpath '/atomselector']);
tic;
for i = 1:1000
    pdb = setCoord(pdb,selectedAtoms,newCoord);
end
woAC = toc;
addpath([testpath '/accelerator']);
tic;
for i = 1:1000
    pdb = setCoord(pdb,selectedAtoms,newCoord);
end
wAC = toc;
ACpercent = (woAC/wAC)*100;
disp(['accelerate  ' num2str(ACpercent) '%']);