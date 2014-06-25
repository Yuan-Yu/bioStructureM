function [vector]=coord2vector(crd)
    [numOfRes,dimension]=size(crd);
    vector=reshape(crd',numOfRes*dimension,1);