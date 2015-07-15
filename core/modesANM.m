function [U,S]=modesANM(hes,resnum)
    I=hes(:,1);
    J=hes(:,2);
    K=hes(:,3);
    IJK=[I,J,K;J,I,K];
    S=sparse(IJK(:,1),IJK(:,2),IJK(:,3),3*resnum,3*resnum);
    A = spdiags(1/2*spdiags(S,0),0,S);
    [U,S]=eig(full(A));
end