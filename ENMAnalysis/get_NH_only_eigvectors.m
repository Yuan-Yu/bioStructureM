function [NH_only_eigvectors] = get_NH_only_eigvectors(eigvectors,PDB_Structure)
	[three_N,num_of_modes] = size(eigvectors);
	NH_index = zeros(three_N,1);
	protein = atomselect('protein',PDB_Structure);
	NH = atomselect('not resname PRO and (name N or name H or name H1)',protein);
	NH_num = length(NH);

	for i = 0:(NH_num-1)
		current_NH = NH(i+1).atomno;
		current_index = (current_NH-1)*3+1;
		NH_index(current_index:(current_index+2)) = 1;
	end
	
	NH_index = logical(NH_index);
	NH_only_eigvectors = eigvectors(NH_index,:);
end
