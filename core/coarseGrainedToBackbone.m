function [backboneModel]=coarseGrainedToBackbone(template,CGModel)
%%%%%%% need getAtomByAtomName,getCoordfromca,rmsdfit,refreshCoordToCA %%%%%%%%
% input:
%   template is the ca object that contain all Atom of the CGModel
%   CGMode is the ca object that just contain Ca atom.
% return:
%   backboneModel is ca object just contain N Ca C O atom.
%%%%%%% need getAtomByAtomName,getCoordfromca,rmsdfit,refreshCoordToCA %%%%%%%%
backbone = getAtomByAtomName(template,'CA N C O');
coord=getCoordfromca(getAtomByAtomName(template,'CA'));
backboneCoord=getCoordfromca(backbone);
%%%%%% count number of atoms for each gap %%%%%%%%
numAtom =length(backbone);
isCA = strcmp({backbone.atmname},'CA');
numAtomPerGap = ones(1,numAtom)*-1;
count = 0;
 for i = 1:numAtom
     if isCA(i)
         numAtomPerGap(i) = count;
         count = 0;
     end
         count = count + 1;
 end
numAtomPerGap(i) = count;
numAtomPerGap(numAtomPerGap<0) = [];
%%%%%%end count number of atoms for each gap end %%%%%%%%
CGCoord=getCoordfromca(CGModel);
[numOfRes,n]=size(coord);
fixedBackboneCoord=zeros(numAtom,3);
tempRMSD=[Inf ,0];
tempRotation=cell(1,2);
tempTranslocation=cell(1,2);
CGcrd3=CGCoord(1:3,:);
crd3=coord(1:3,:);
[tempRotation{2},tempTranslocation{2},tempRMSD(2)]=rmsdfit(CGcrd3,crd3);
temp=backboneCoord(1:numAtomPerGap(1)+numAtomPerGap(2),:)*tempRotation{2}+repmat(tempTranslocation{2},numAtomPerGap(1)+numAtomPerGap(2),1);

fixedBackboneCoord(1:numAtomPerGap(1)+numAtomPerGap(2),:)=temp(:,:);


currentIndexOfFinalCoord=numAtomPerGap(1)+numAtomPerGap(2)+ 1;
for i=2:numOfRes-2
    tempRMSD(1)=tempRMSD(2);
    tempRotation{1}=tempRotation{2};
    tempTranslocation{1}=tempTranslocation{2};
    CGcrd3=CGCoord(i:i+2,:);
    crd3=coord(i:i+2,:);
    [tempRotation{2},tempTranslocation{2},tempRMSD(2)]=rmsdfit(CGcrd3,crd3);
    fixedBackboneCoord(currentIndexOfFinalCoord,:)=CGcrd3(1,:);
    numAtomCurrentGap = numAtomPerGap(i+1);
    [value, index]=min(tempRMSD);
    fixedBackboneCoord(currentIndexOfFinalCoord:currentIndexOfFinalCoord+numAtomCurrentGap-1,:)=backboneCoord(currentIndexOfFinalCoord:currentIndexOfFinalCoord+numAtomCurrentGap-1,:)*tempRotation{index}+repmat(tempTranslocation{index},numAtomCurrentGap,1);
    currentIndexOfFinalCoord=currentIndexOfFinalCoord+numAtomCurrentGap;
end
fixedBackboneCoord(currentIndexOfFinalCoord:currentIndexOfFinalCoord+numAtomPerGap(end)+numAtomPerGap(end-1)-1,:)=backboneCoord(currentIndexOfFinalCoord:currentIndexOfFinalCoord+numAtomPerGap(end)+numAtomPerGap(end-1)-1,:)*tempRotation{2}+repmat(tempTranslocation{2},+numAtomPerGap(end)+numAtomPerGap(end-1),1);
fixedBackboneCoord(isCA,:) = CGCoord(:,:);
backboneModel=refreshCoordToCA(backbone,fixedBackboneCoord);