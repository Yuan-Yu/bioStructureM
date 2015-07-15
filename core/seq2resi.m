function [resi]=seq2resi(seq,from)
    resi=[];
    for i = 1:length(seq)
        if seq(i)~='-'
            resi=[resi from];
            from=from+1;
        else 
            resi=[resi 0];
        end
    end
        