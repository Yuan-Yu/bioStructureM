function [sameCa1,sameCa2,result]=oneChainExtractSameNucleotides(ca1,ca2)
    try
        resno1=[ca1.internalResno];
        resno2=[ca2.internalResno];
        pAtoms1=three2oneNucleic(getAtomByAtomName(ca1,'P'));
        pAtoms2=three2oneNucleic(getAtomByAtomName(ca2,'P'));
        seq1=[pAtoms1.resname];
        seq2 = [pAtoms2.resname];
        seq1 = regexprep(seq1,'\s+','');
        seq2 = regexprep(seq2,'\s+','');
        result=alignSeq(seq1,seq2);
        dr=double(result);
        dr(dr == double('-'))=0;

        for i =1:2
            seqIndex=1;
            for j =1:length(dr(i,:))
                if dr(i,j)>0
                    dr(i,j)=seqIndex;
                    seqIndex= seqIndex+1;
                end
            end
        end
        tmpIndex=find(dr(1,:).*dr(2,:)>0);
        indexOfCa1=dr(1,tmpIndex);
        indexOfCa2=dr(2,tmpIndex);

        samePAtom1=pAtoms1(indexOfCa1);
        samePAtom2=pAtoms2(indexOfCa2);
        sameCa1=ca1(ismember(resno1,[samePAtom1.internalResno]));
        sameCa2=ca2(ismember(resno2,[samePAtom2.internalResno]));
        if length(sameCa1)~=length(sameCa2)
            atmnameCa1 = {sameCa1.atmname};
            internalResnoCa1 = {sameCa1.internalResno};
            elementIdCa1 = cellfun(@(x,y)[x '#' num2str(y)],atmnameCa1,internalResnoCa1,'UniformOutput',0);
            atmnameCa2 = {sameCa2.atmname};
            internalResnoCa2 = {sameCa2.internalResno};
            elementIdCa2 = cellfun(@(x,y)[x '#' num2str(y)],atmnameCa2,internalResnoCa2,'UniformOutput',0);
            [~,selection1,selection2] = intersect(elementIdCa1,elementIdCa2);
            sameCa1 = sameCa1(selection1);
            sameCa2 = sameCa2(selection2);
            if length(sameCa1)~=length(sameCa2)
                baseException = MException('core:oneChainExtractSameCA','size defferent between chains');
                throw(baseException);
            end
        end
    catch e
        baseException = MException('core:oneChainExtractSameNucleotides',['can not align chain ' ca1(1).subunit ' of pdbStructure1 to chain ' ca2(1).subunit ' of pdbStructure2']);
        baseException = addCause(baseException,e);
        throw(baseException);
    end
end

