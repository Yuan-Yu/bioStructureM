function [dmatrix]=getPairwiseDistance(pdb1,pdb2,numOfignore)
%%%%%%%%% need getCoordfromca.m%%%%%%%%
% input:
%   pdb1 is the structure gotten from cafrompdb.
%   pdb2 is the structure gotten from cafrompdb.
%   numOfignore: set the ignore neighbouring atom.
% return:
%   dmatrix is the matrix contain the pairwise distance.
%       the format of dmatrix is like
%            pdb1_atom1   pdb1_atom2   pdb1_atom3------
% pdb2_atom1 distance11   distance21   distance31------
% pdb2_atom2 distance12   distance22   distance32------
% pdb2_atom3 distance13   distance23   distance33------
%       |       |             |            |   
%%%%%%%%% need getCoordfromca.m%%%%%%%%

    %%%% check the operational variable
    if ~exist('numOfignore', 'var') 
        numOfignore=0;
    end
    %%%% check the operational variable
    
    crd1=getCoordfromca(pdb1);
    crd2=getCoordfromca(pdb2);
    numOfRes1=length(pdb1);
    numOfRes2=length(pdb2);
    dmatrix=Inf(numOfRes2,numOfRes1);
    
    for i=1:numOfRes1
        dRi=crd2-repmat(crd1(i,:),numOfRes2,1);
        dmatrix(:,i)=sqrt(sum(dRi.^2,2));
    end
    
    %%%%%%%%% set the ignore %%%%%%%%%%%
    if numOfignore~=0
        if numOfRes1~=numOfRes2
            error('the amount of the residue between two pdb are not same.\nCan not do ignore neighbouring residues!')
        end
        tmp=Inf(numOfRes2,numOfRes1);
        tmp=triu(tril(tmp,numOfignore),-numOfignore);
        dmatrix=dmatrix+tmp;
    end
    %%%%%%%%% set the ignore %%%%%%%%%%%
end
   
    