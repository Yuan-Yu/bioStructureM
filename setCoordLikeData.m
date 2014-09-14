function [pdbStructure]=setCoordLikeData(pdbStructure,data,fieldName)
%%%%%%%%%%%%% need %%%%%%%%%%%%%%%%
% input:
%   pdbStructure: The structure array getton from readPDB.
%   data : the data format should be like
%           mode1_x_atom1        mode2_x_atom1      mode3_x_atom1      mode4_x_atom1    ---
%           mode1_y_atom1        mode2_y_atom1      mode3_y_atom1      mode4_y_atom1    ---
%           mode1_z_atom1        mode2_z_atom1      mode3_z_atom1      mode4_z_atom1    ---
%           mode1_x_atom2        mode2_x_atom2      mode3_x_atom2      mode4_x_atom2    ---
%           mode1_y_atom2        mode2_y_atom2      mode3_y_atom2      mode4_y_atom2    ---
%           mode1_z_atom2        mode2_z_atom2      mode3_z_atom2      mode4_z_atom2    ---
%                   |                    |                |                  |
%   fieldName : The data will be put at this field of structure.
% return:
%   pdbStructure: The structure array that data has been signed.
% ex.
%   There are 2 atoms in pdbStructure.
%   Mydata is a 2 mode data in 3-dimension coordinate.
%   Mydata 
%           mode1_x_atom1        mode2_x_atom1 
%           mode1_y_atom1        mode2_y_atom1 
%           mode1_z_atom1        mode2_z_atom1  
%           mode1_x_atom2        mode2_x_atom2  
%           mode1_y_atom2        mode2_y_atom2  
%           mode1_z_atom2        mode2_z_atom2      
%   [pdbst]=setData(pdbst,3,Mydata,'mydata')
%   pdbst(1).mydata
%              [ mode1_x_atom1 mode1_y_atom1 mode1_z_atom1
%                mode2_x_atom1 mode2_y_atom1 mode2_z_atom1 ]
%   You can use fuction 'getCoordLikeData' to extract the data.
%%%%%%%%%%%%% need %%%%%%%%%%%%%%%%
[ndimension,numOfMode]=size(data);
numOfatom=length(pdbStructure);
dimension=ndimension/numOfatom;
data=reshape(data',numOfMode,dimension,numOfatom);
pdbStructure(1).(fieldName)=[];

for i=1:numOfatom
    pdbStructure(i).(fieldName)=data(:,:,i);
end