function [positiveCa,negativeCa]=getDeformedStructure(originalStructure,vectorOfMotion,scaleOfMotion,isFixBond)
%%%%% need getCoordfromca,vector2coord,refreshCoordToCA,getBendingAngles,getDihedralAngles,getBondLengths,superimpose.%%%%%%%
% input:
%   originalStructure:
%   vectorOfMotion: 
%   scaleOfMotion: RMSD in angstrom
% 	isFixBond: whether to fix CA bond length by original structure.  (default=0)
% return:
%   deformedStructure
%%%%% need getCoordfromca,vector2coord,refreshCoordToCA,getBendingAngles,getDihedralAngles,getBondLengths,superimpose %%%%%%%
if ~exist('isFixBond','var')
	isFixBond = 0;
end
originalCoord=getCoordfromca(originalStructure);
motion=vector2coord(vectorOfMotion);
numOfRes=length(vectorOfMotion)/3;
originalScale=(sum((sum(motion.^2,2)))/numOfRes).^0.5;
motion=motion*(scaleOfMotion/originalScale);
negativeDeform=originalCoord-motion;
positiveDefrom=originalCoord+motion;
negativeCa=refreshCoordToCA(originalStructure,negativeDeform);
positiveCa=refreshCoordToCA(originalStructure,positiveDefrom);
if isFixBond
	negativeBending=getBendingAngles(negativeCa);
	negativeDihedra=getDihedralAngles(negativeCa);
	positiveBending=getBendingAngles(positiveCa);
	positiveDihedra=getDihedralAngles(positiveCa);
	bondLength=getBondLengths(originalStructure);
	positiveCa=superimpose(refreshCoordToCA(originalStructure,rebuildStructure(bondLength,positiveDihedra,positiveBending)),positiveCa);
	negativeCa=superimpose(refreshCoordToCA(originalStructure,rebuildStructure(bondLength,negativeDihedra,negativeBending)),negativeCa);
end