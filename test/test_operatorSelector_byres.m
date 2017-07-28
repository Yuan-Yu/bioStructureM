function [isPass] = test_operatorSelector_byres(pdbStructure)
    selected = as('byres (water within 4.5 of protein)',pdbStructure);
    isPass = length(selected) == 2664;
end