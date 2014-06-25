function [coordMatrix]=rebuildStructure(boundLength,dihedralAngle,bendingAngle)
%%%%%%%%%% need %%%%%%%%%%%%%
% input:
% return:
%%%%%%%%%% need %%%%%%%%%%%%%
dihedralAngle=[pi;dihedralAngle];
t_cell=arrayfun(@(b,d) [cos(b) sin(b) 0;-sin(b)*cos(d) cos(b)*cos(d) -sin(d); -sin(b)*sin(d) cos(b)*sin(d) cos(d)],bendingAngle,dihedralAngle,'UniformOutput',0);
boundLength=[boundLength zeros(length(boundLength),2)]';
ct=eye(3);
r=boundLength(:,1);
coordMatrix=zeros(3,length(boundLength)+1);
coordMatrix(:,1)=[0;0;0];
coordMatrix(:,2)=r;
for i=1:length(t_cell)
    ct=ct*t_cell{i};
    r=r+ct*boundLength(:,i+1);
    coordMatrix(:,i+2)=r;
end
coordMatrix=coordMatrix';