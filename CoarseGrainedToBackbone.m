function [backboneModel]=coarseGrainedToBackbone(template,CGModel)
%%%%%%% need getAtomByAtomName,getCoordfromca,rmsdfit,refreshCoordToCA %%%%%%%%
% input:
%   template is the ca object that contain all Atom of the CGModel
%   CGMode is the ca object that just contain Ca atom.
% return:
%   backboneModel is ca object just contain N Ca C O atom.
%%%%%%% need getAtomByAtomName,getCoordfromca,rmsdfit,refreshCoordToCA %%%%%%%%
coord=getCoordfromca(getAtomByAtomName(template,'CA'));
NCOCoord=getCoordfromca(getAtomByAtomName(template,'N C O'));
CGCoord=getCoordfromca(CGModel);
[numOfRes,n]=size(coord);
backboneCoord=zeros(numOfRes*4,3);
tempRMSD=[Inf ,0];
tempRotation=cell(1,2);
tempTranslocation=cell(1,2);
CGcrd3=CGCoord(1:3,:);
crd3=coord(1:3,:);
[tempRotation{2},tempTranslocation{2},tempRMSD(2)]=rmsdfit(CGcrd3,crd3);
temp=NCOCoord(1:4,:)*tempRotation{2}+repmat(tempTranslocation{2},4,1);
backboneCoord(1,:)=temp(1,:);
backboneCoord(2:5,:)=[CGCoord(1,:);temp(2:end,:)];
currentIndexOfFinalCoord=6;
for i=2:numOfRes-2
    tempRMSD(1)=tempRMSD(2);
    tempRotation{1}=tempRotation{2};
    tempTranslocation{1}=tempTranslocation{2};
    CGcrd3=CGCoord(i:i+2,:);
    crd3=coord(i:i+2,:);
    [tempRotation{2},tempTranslocation{2},tempRMSD(2)]=rmsdfit(CGcrd3,crd3);
    backboneCoord(currentIndexOfFinalCoord,:)=CGcrd3(1,:);
    currentIndexOfFinalCoord=currentIndexOfFinalCoord+1;
    [value, index]=min(tempRMSD);
    backboneCoord(currentIndexOfFinalCoord:currentIndexOfFinalCoord+2,:)=NCOCoord(currentIndexOfFinalCoord-i:currentIndexOfFinalCoord-i+2,:)*tempRotation{index}+repmat(tempTranslocation{index},3,1);
    currentIndexOfFinalCoord=currentIndexOfFinalCoord+3;
end
backboneCoord(end-6,:)=CGCoord(end-1,:);
temp=NCOCoord(end-4:end,:)*tempRotation{2}+repmat(tempTranslocation{2},5,1);
backboneCoord(end-5:end-3,:)=temp(1:3,:);
backboneCoord(end-2:end,:)=[ CGCoord(end,:);temp(end-1:end,:)];
backboneModel=refreshCoordToCA(getAtomByAtomName(template,'CA C O N'),backboneCoord);