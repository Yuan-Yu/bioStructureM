function [dmatrix]=pairwiseDistance(ca,numOfignore)
%%%%%%%% need Coordfromca  %%%%%%%%%%%%%
% input:
%   ca
% return:
%   Dmatrix is symmetric matrix.
%%%%%%%% need Coordfromca  %%%%%%%%%%%%%
    if ~exist('numOfignore', 'var') 
        numOfignore=0;
    else 
        numOfignore=numOfignore+1;
    end
    crd=getCoordfromca(ca);
    numOfRes=length(ca);
    dmatrix=Inf(numOfRes);
    for i =1:numOfRes
        for j=i+numOfignore:numOfRes
            dis=norm(crd(i,:)-crd(j,:));
            dmatrix(i,j)=dis;
            dmatrix(j,i)=dis;
        end
    end