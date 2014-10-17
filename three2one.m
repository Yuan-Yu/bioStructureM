%% before use need load dict
function ca=three2one(ca,dict)
	if ~exist('dict','var')
		load('dict.mat');
	end
    for i=1:length(ca)
        ca(i).resname=dict.get(ca(i).resname);
    end
    