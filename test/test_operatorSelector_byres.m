function [isPass,time] = test_operatorSelector_byres
    pdbStructure = readPDB('FGF2_phaser_P212121-coot-12.pdb');
    tic;
    selected = as('byres (c. A within 10.5 of c. B)',pdbStructure);
    isPass = length(selected) == 213;
    time = toc;
end