function [data]=getCoordLikeData(pdbStructure,fieldName,modth)
%%%%%%%%%%%% need %%%%%%%%%%%%%%%%
% input:
%   pdbStructure: The structure array getton from readPDB.
%   fieldName: The fieldName of the pdbStructure that you want to extract.
%   modth: How many mode do you need
% return
%   data: each column of the data is one mode.So the format is like
%           mode1_x_atom1        mode2_x_atom1      mode3_x_atom1      mode4_x_atom1    ---
%           mode1_y_atom1        mode2_y_atom1      mode3_y_atom1      mode4_y_atom1    ---
%           mode1_z_atom1        mode2_z_atom1      mode3_z_atom1      mode4_z_atom1    ---
%           mode1_x_atom2        mode2_x_atom2      mode3_x_atom2      mode4_x_atom2    ---
%           mode1_y_atom2        mode2_y_atom2      mode3_y_atom2      mode4_y_atom2    ---
%           mode1_z_atom2        mode2_z_atom2      mode3_z_atom2      mode4_z_atom2    ---
%                   |                    |                |                  |
    data=[pdbStructure.(fieldName)]';
    data=data(:,modth);
end
