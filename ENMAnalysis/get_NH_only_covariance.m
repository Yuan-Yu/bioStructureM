function [NH_only_covariance] = get_NH_only_covariance(covariance,PDB_Structure)
	[three_N,~] = size(covariance);
	NH_index = zeros(three_N,1);
	protein = atomselect('protein',PDB_Structure);
	atomNunPerResidue = getAtomNumPerRes(protein);
	protein_res_num = length(atomNunPerResidue);
	proline = atomselect('resname PRO',protein);
	proline_res_num_cell = unique({proline.resno});
	proline_res_num_array = zeros(1,length(proline_res_num_cell));

	for i = 1:length(proline_res_num_cell)
		proline_res_num_array(i) = str2num(proline_res_num_cell{i});
	end

	current_index = 1;
	for j = 1:(protein_res_num)
		
		if ~ismember(j,proline_res_num_array)
			NH_index(current_index:(current_index+5)) = 1;
		end

		current_index = current_index + atomNunPerResidue(j)*3;
	end

	NH_index = logical(NH_index);
	NH_only_covariance = covariance(NH_index,NH_index);
end
