function [movie] = MakePDBMovie(PDBstructure,motion,step,scale)
%%%%%%%%%%% need
%
%
[~,colnum]=size(motion);
if colnum == 1
    motion = vector2coord(motion);
end
originCrd = getCoordfromca(PDBstructure);
steplength = scale/step;
stepfactor = [0:step step-1:-1:-step -(step-1):-1];
movie = cell(1,length(stepfactor));
movieIndex =1;
for i = stepfactor
    tmpCrd=originCrd+i*motion*steplength;
    movie{movieIndex} = refreshCoordToCA(PDBstructure,tmpCrd);  
    movieIndex = movieIndex +1;
end

