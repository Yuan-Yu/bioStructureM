function [new  ,score, s_table,t_table]=alignSeq(seq1,seq2,showClearAlign)
    if ~exist('showClearAlign','var')
        showClearAlign=0;
    end
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
            %[ v, index ]=scores(s_table(r,c),s_table(r,c+1),s_table(r+1,c),w,match_table(r,c));
            dig=s_table(r,c)+match_table(r,c);
            up=s_table(r,c+1)+w;
            left=s_table(r+1,c)+w;
            if dig>=up
                v=dig;
                index=1;
                if v<left
                    v=left;
                    index=3;
                end
            else 
                v=up;
                index=2;
                if v<left
                    v=left;
                    index=3;
                end
            end
            s_table(r+1,c+1)=v;
            t_table(r,c)=index;
        end      
    end
    score=s_table(end);
    %trackback
    [new,align]=track(seq1,seq2,t_table);
    length(align)
    length(new)
    if showClearAlign
        new =[new(1,:);align;new(2,:)];
    end