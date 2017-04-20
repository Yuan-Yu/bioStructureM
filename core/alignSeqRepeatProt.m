function [alignStr,s_table,t_table]=alignSeqRepeatProt(seq1,seq2,gapPenalty,treshod,blosum)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% implement of repeat alignment
% input
%   seq1: a row array contains the amino-acid sequence 
%   seq2: a row array contains the amino-acid sequence 
%   gapPenalty: gap penalty (default: -8)
%   treshod: treshod for cutting a fragment (default: -20)
%   blosum: blosum matrix (default: blosum62)
% return:
%   alignStr
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ~exist('gapPenalty','var')
        gapPenalty=-8;
    end
    if ~exist('treshod','var')
        treshod=-20;
    end
    if ~exist('blosum','var')
        load blosum62.mat
    end 
    
    %len1 is the length of seq1.
    len1=length(seq1);
    %len2 is the length of seq2.
    len2=length(seq2);
    %create a table
    s_table=zeros(len2+1,len1+1);
    %create a pre-find the score
    load('aa2order.mat')
    orderSeq1=arrayfun(@(x) aa2order(x),seq1);
    orderSeq2=arrayfun(@(x) aa2order(x),seq2);
    preScorMatrix=zeros(len2,len1);
    for rowIndex=1:len2
        for colunmIdex=1:len1
            preScorMatrix(rowIndex,colunmIdex)=blosum(orderSeq1(colunmIdex),orderSeq2(rowIndex));
        end
    end
    %track
    t_table=zeros(len2+1,len1+1);
    %calculate the table
    for c=1:len1
        for r=1:len2
            dig=s_table(r,c)+preScorMatrix(r,c);
            up=s_table(r,c+1)+gapPenalty;
            left=s_table(r+1,c)+gapPenalty;
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
            tsIndexC=c+1;
            tsIndexR=r+1;
            t_table(tsIndexR,tsIndexC)=index;   
        end
        colunm=[s_table(1,tsIndexC);s_table(2:end,tsIndexC)+treshod];
        [preColunmMax,preColunmIndex]=max(colunm);
        s_table(1,tsIndexC+1)=preColunmMax;
        t_table(1,tsIndexC+1)=preColunmIndex;
    end
    %trackback
    alignStr=trackRep(seq1,seq2,t_table);
