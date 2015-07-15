function ca=refreshCoordToCA(ca,crd)
%%%%%%%%%%%%% need %%%%%%%%%%%%%%%
% input:
%   ca is object gotten from cafrompdb
%   crd is the coord. Format like:
%                       atom1_x		atom1_y		atom1_z
%                       atom2_x		atom2_y		atom2_z
%						atom3_x		atom3_y		atom3_z
%   						|			|			|
% return:
%   the refreshed ca
%%%%%%%%%%%%% need %%%%%%%%%%%%%%%
crd=crd';
for i=1:length(ca)
    ca(i).coord=crd(:,i);
end