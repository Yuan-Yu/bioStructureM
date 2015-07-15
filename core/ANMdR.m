function [ dR ] = ANMdR(ca,fromModeth,toModeth)
%# ca is the object gotten from cafrompdb.
%The ANM attribute must be contain in ca.
%modeth 
%return dR that is the motion of modeth.(dR format is like      
%   mode1_x1        mode2_x1      mode3_x1      mode4_x1    ---
%   mode1_y1        mode2_y1      mode3_y1      mode4_y1    ---
%   mode1_z1        mode2_z1      mode3_z1      mode4_z1    ---
%   mode1_x2        mode2_x2      mode3_x2      mode4_x2    ---
%   mode1_y2        mode2_y2      mode3_y2      mode4_y2    ---
%   mode1_z2        mode2_z2      mode3_z2      mode4_z2    ---
%       |               |           |               |
    dR=[ca.ANM]';
    dR=dR(:,fromModeth:toModeth);
end

