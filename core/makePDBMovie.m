function [movie] = makePDBMovie(PDBstructure,motion,step,scale)
%%%%%%%%%%%%%%%%%%% need vector2coord,getCoord %%%%%%%%%%%%%%%%%%%%%%
% input:
%   PDBstructure: the PDB structure array 
%   motion : an array that represent the movement of the PDB structure (3N or N*3)
%           where the N is the atom number of PDB structure
%   step : the number of frame would be 4*step
%   scale: the maximum movement is scale*motion.
% return:
%   movie: a cell that eatch element is a frame (pdb structure)
%%%%%%%%%%%%%%%%%%% need vector2coord,getCoord %%%%%%%%%%%%%%%%%%%%%%
[~,colnum]=size(motion);
if colnum == 1
    motion = vector2coord(motion);
end
originCrd = getCoord(PDBstructure);
steplength = scale/step;
stepfactor = [0:step step-1:-1:-step -(step-1):-1];
movie = cell(1,length(stepfactor));
movieIndex =1;
for i = stepfactor
    tmpCrd=originCrd+i*motion*steplength;
    movie{movieIndex} = refreshCoordToCA(PDBstructure,tmpCrd);  
    movieIndex = movieIndex +1;
end

