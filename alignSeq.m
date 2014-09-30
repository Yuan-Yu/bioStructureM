function [new  ,score, s_table,t_table]=alignSeq(seq1,seq2)
    %seq1 and seq2 is Fasta sequence.
    s_match=2;
    s_miss=-1;
    %w is the gap penalty.
    w=-2;
    %len1 is the length of seq1.
    len1=length(seq1);
    %len2 is the length of seq2.
    len2=length(seq2);
    %create a table
    s_table=zeros(len2+1,len1+1);
    %change seq to ascii
    nseq1=double(seq1);
    nseq2=double(seq2);
    %create a match table
    tmp1=nseq2'*ones(1,len1);
    tmp2=ones(len2,1)*nseq1;
    match_table=tmp1==tmp2;
    match_table=(match_table*(s_match-s_miss)+s_miss);
    %track
    t_table=zeros(len2,len1); 
    %calculate the table
    for r=1:len2
        for c=1:len1
            [ v index ]=scores(r,c,w,match_table,s_table);
            s_table(r+1,c+1)=v;
            t_table(r,c)=index;
        end      
    end
    score=s_table(end);
    %trackback
    new=track(seq1,seq2,t_table);
