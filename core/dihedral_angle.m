%% need getAtomByAtomName
% inuput:
%   ca is the object got from cafrompdb.
%       ca must contain backbone.
% return:
%   angle is dihedral angle.
%       format:  
%                             phi         psi     omega
%           residue1           0      164.8969  178.2066  
%           residue2        -61.5618  -33.9475  179.4451
%           residue3        -64.6300  -39.7344  178.8958
%           residue4        -67.4093  -38.5747  179.2408
%           residue5        -63.8623  -44.1449 -179.6010
%           residue6        -65.9614      0         0
%       The first residue can not be calculate phi angle.
%       The last  residue can not be calculate psi and omega angle.
%%
%   dihedral_angle:
%           N1
%             \  
%              \
%               \
%                Ca1---C1
%                        \
%                         \
%                          \
%                           N2
%           svector_1=Ca1-N1          svector_2=C1-Ca1          svector_3=N2-C1
%           The plane_1 contain N1, Ca1 and C1
%           The plane_2 contain Ca1, C1 and N2
%           nvector_1 is the normals of the plane1.(svector_2 ¢® svector_1)
%           nvector_2 is the normals of the plane2.(svector_3 ¢® svector_2)
%           dihedral angle = arcos( (nvector_2¡Envector_1) / |nvector_2| |nvector_1|)
%%
function [angle]=dihedral_angle(ca)
    %take the backbone atom.
    ca=getAtomByAtomName(ca,'CA N C');
    %get Coordinate of backbone atom  
    coord=Coordfromca(ca);
    %calculate all svector
    vector=coord(2:end,:)-coord(1:end-1,:);
    %calculate all nvector
    nvector=cross(vector(2:end,:),vector(1:end-1,:));
    % nvector_magnitude=|nvector|
    nvector_magnitude=sqrt(diag(nvector*nvector'));
    %magnitude_product= |nvector i| |nvector i-1|
    magnitude_product=nvector_magnitude(1:end-1,:).*nvector_magnitude(2:end,:);
    %calculate all dot product and get arcos
    cos=dot(nvector(2:end,:),nvector(1:end-1,:),2)./magnitude_product;
    angle=sign(-dot(vector(1:end-2,:),nvector(2:end,:),2)).*(180*acos(cos)/pi);
    angle=[0;angle;0;0];
    angle=reshape(angle,3,length(angle)/3)';
end