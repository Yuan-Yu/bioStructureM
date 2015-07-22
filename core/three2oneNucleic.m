%% before use need load dict
function pdbStructureNucleotiOnly=three2oneNucleic(pdbStructureNucleotiOnly,nucleotideThree2One)
	if ~exist('dict','var')
		load('nucleotideThree2One.mat');
    end
    try
        for i=1:length(pdbStructureNucleotiOnly)
            pdbStructureNucleotiOnly(i).resname=nucleotideThree2One(pdbStructureNucleotiOnly(i).resname);
        end
    catch e
        baseException = MException('core:pdbStructureNucleotiOnly',['fail to conver "' pdbStructureNucleotiOnly(i).resname '"' ]);
        baseException = addCause(baseException,e);
        throw(baseException);
    end