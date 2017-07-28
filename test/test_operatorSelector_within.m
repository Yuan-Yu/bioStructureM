function [isPass,time] = test_operatorSelector_within
    pdbStructure = readPDB('FGF2_phaser_P212121-coot-12.pdb');
    tic;
    selected = as('c. A within 10.5 of c. B',pdbStructure);
    isPass = length(selected) == 158;
    time = toc;
end