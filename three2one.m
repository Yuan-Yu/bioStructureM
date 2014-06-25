%% before use need load dict
function ca=three2one(ca,dict)
    for i=1:length(ca)
        ca(i).resname=dict.get(ca(i).resname);
    end
    