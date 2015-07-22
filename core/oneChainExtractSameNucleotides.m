function [sameCa1,sameCa2,result]=oneChainExtractSameNucleotides(ca1,ca2)
try
    pAtoms1=getAtomByAtomName(ca1,'P');
    pAtoms2=getAtomByAtomName(ca2,'P');
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
    resno1=getResnoFromCA(samePAtom1);
    resno2=getResnoFromCA(samePAtom2);
    sameCa1=getAtomByResno(ca1,resno1{1});
    sameCa2=getAtomByResno(ca2,resno2{1});
catch e
    baseException = MException('core:oneChainExtractSameNucleotides',['can not align chain ' ca1(1).subunit ' of pdbStructure1 to chain ' ca2(1).subunit ' of pdbStructure2']);
    baseException = addCause(baseException,e);
    throw(baseException)
end

