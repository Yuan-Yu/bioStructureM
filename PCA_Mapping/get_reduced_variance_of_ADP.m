function [reduced_variance_of_ADP] = get_reduced_variance_of_ADP(reduced_ADP)
	[six_num_of_res,num_of_modes] = size(reduced_ADP);
	three_num_of_res = six_num_of_res/2;
	num_of_res = three_num_of_res/3;
	reduced_variance_of_ADP = zeros(three_num_of_res,num_of_modes);
	for i = 0:(num_of_res-1)
		reduced_variance_of_ADP(i*3+1,:) = reduced_ADP(i*6+1,:);
		reduced_variance_of_ADP(i*3+2,:) = reduced_ADP(i*6+2,:);
		reduced_variance_of_ADP(i*3+3,:) = reduced_ADP(i*6+3,:);
	end
end
