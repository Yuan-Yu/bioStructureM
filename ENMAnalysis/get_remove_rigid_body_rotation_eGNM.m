function [U_rotation_removed,Fluc_int,Fluc_ext,Fluc_all] = get_remove_rigid_body_rotation_eGNM(PDB_Structure,S_eGNM)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%need PDB_Structure with eGNM attribute%%%%%%%%%%%%%%%%%%%%%%%%%
% input:
%   PDB_Structure is the structure that gotten from cafrompdb with eGNM attribute.
%
% Translational velocity V'i = Vi - Sigma(miVi)/Sigma(mi) should already been removed!!
% Get rigid-body rotational contribution in eGNM modes.
% Then Remove rotational velocity.
%   
% return:
%   PDB_Structure is the structure that contain eGNM attribute.(ex PDB_Structure(indexOfAtom).GNM or PDB_Structure(indexOfAtom).eGNMValue)
%   the format is like
%       PDB_Structure(indexOfAtom).eGNM(modth)=the eigenvector of the n eGNM mode of the atom.
%       PDB_Structure(indexOfAtom).eGNMValue(modth)=the eigvalue of the n eGNM mode.
%
% Editor: Hong-Rei
%%%%%%%%%%%%%%%%%%%%%%%%%%%%need PDB_Structure with eGNM attribute%%%%%%%%%%%%%%%%%%%%%%%%%
	U_eGNM = geteGNM(PDB_Structure);
	[N3,modes]=size(U_eGNM);
	N = N3/3;
	coor = getCoord(PDB_Structure);
	center_of_mass_coordinate = coor - ones(N,1)*mean(coor);
	mass = ones(N,1);
	U_rotation_removed = zeros(N3,modes);
	r = center_of_mass_coordinate;
	r_2 = repmat(mass,1,3).*(r.^2);
	Ixx = sum(sum(r_2(:,2:3)));
	Iyy = sum(sum(r_2(:,[1,3])));
	Izz = sum(sum(r_2(:,1:2)));
	Ixy = -sum(mass.*r(:,1).*r(:,2));
	Iyz = -sum(mass.*r(:,2).*r(:,3));
	Izx = -sum(mass.*r(:,1).*r(:,3));
	Iyx = Ixy;
	Izy = Iyz;
	Ixz = Izx;
	I = [Ixx Ixy Ixz; Iyx Iyy Iyz; Izx Izy Izz];
	I_inv = 1/det(I)*[Iyy*Izz-Iyz*Iyz Iyz*Izx-Izz*Ixy Ixy*Iyz-Izx*Iyy; Iyz*Izx-Izz*Ixy Izz*Ixx-Izx*Izx Izx*Ixy-Ixx*Iyz; Ixy*Iyz-Izx*Iyy Izx*Ixy-Ixx*Iyz Ixx*Iyy-Ixy*Ixy];

	Fluc_int = zeros(N,1);
	Fluc_ext = zeros(N,1);
	Fluc_all = zeros(N,1);

	for i = 1:modes

		v_total = reshape(U_eGNM(:,i),3,N)';
		L = sum(repmat(mass,1,3).*cross(r,v_total,2));
		omega = (I_inv*L')'; 
		omega = ones(N,1)*omega;

		v_rigid_body_rotation = cross(omega,r,2);
		v_vibration = v_total - v_rigid_body_rotation;

		Fluc_int = Fluc_int + sum(v_vibration.^2,2)/S_eGNM(i);
		Fluc_ext = Fluc_ext + sum(v_rigid_body_rotation.^2,2)/S_eGNM(i);
		Fluc_all = Fluc_all + sum(v_total.^2,2)/S_eGNM(i);
		U_rotation_removed(:,i) = reshape(v_vibration',N3,1);
	end
end
