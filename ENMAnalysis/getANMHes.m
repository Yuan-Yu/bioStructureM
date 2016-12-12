function [Hes]=getANMHes(pdb,cutOff,contactConstant,bondConstant,bond)
%%%%%%%%%%%%%% need %%%%%%%%%%%%%%%%%%%
% input:
%   pdb
%   cutOff
%   contactConstant
%   bondConstant
% return:
%   Hes
%
resNum=length(pdb);
Hes=zeros(resNum*3);
pairwiseDistance = getPairwiseDistance(pdb,pdb);
contactMatrix = pairwiseDistance < cutOff;
coord=getCoordfromca(pdb);
for indexOfRes=1:resNum-1
    currentResCrd=coord(indexOfRes,:);
    rowNum=resNum-indexOfRes;
    dR=pairwiseDistance(indexOfRes+1:end,indexOfRes);
    dxyz=coord(indexOfRes+1:end,:)-repmat(currentResCrd,rowNum,1);
    contact=contactMatrix(indexOfRes+1:end,indexOfRes);
    dxyz=dxyz.*repmat(contact,1,3);
    if rowNum>bond
        constant=ones(rowNum,6);
        constant(1:bond,1:6)=bondConstant;
        constant(bond+1:end,1:6)=contactConstant;
    else
        constant=ones(rowNum,6)*bondConstant;
    end
    %ddxyz=[dx*dx dx*dy dx*dz dy*dy dy*dz dz*dz];
    ddxyz=-[dxyz(:,1).^2,dxyz(:,1).*dxyz(:,2),dxyz(:,1).*dxyz(:,3),dxyz(:,2).^2,dxyz(:,2).*dxyz(:,3),dxyz(:,3).^2];
    ddxyz=(ddxyz.*constant)./repmat(dR.^2,1,6);
    Hes(3*indexOfRes+1:end,indexOfRes*3-2)=reshape(ddxyz(:,1:3)',rowNum*3,1);
    Hes(3*indexOfRes+1:end,indexOfRes*3-1)=reshape([ddxyz(:,2),ddxyz(:,4:5)]',rowNum*3,1);
    Hes(3*indexOfRes+1:end,indexOfRes*3)=reshape([ddxyz(:,3),ddxyz(:,5:6)]',rowNum*3,1);
end
    Hes=Hes+Hes';
for indexOfRes=1:resNum
    Hes((indexOfRes*3-2):indexOfRes*3,indexOfRes*3-2)=-sum(reshape(Hes(:,indexOfRes*3-2),3,resNum),2);
    Hes((indexOfRes*3-2):indexOfRes*3,indexOfRes*3-1)=-sum(reshape(Hes(:,indexOfRes*3-1),3,resNum),2);
    Hes((indexOfRes*3-2):indexOfRes*3,indexOfRes*3)=-sum(reshape(Hes(:,indexOfRes*3),3,resNum),2);
end
