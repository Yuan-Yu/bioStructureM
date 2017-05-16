%% track_rep do the trackback mothed that be used in localalignment.
% input:                                                        
%   seq1 and seq2 are the seqence.                             
%   s_table is the score matrix of alignment.
%   t_table is the traceback matrix.
% return:
%   new is the result of alignment. The format is like
%       AAAABBBBCCCC
%       AAA-BABB--CC
%   cv  is the score of alignment.
%   identity is the identity of alignment.
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [new]=trackRep(seq1,seq2,t_table)
    tmpSeq1='';
    tmpSeq2='';
    [~,lenColunm_T]=size(t_table);
    rowIndex=t_table(1,lenColunm_T);
    colunmIndex=lenColunm_T-1;
    while 1
        if rowIndex==1
            tmpSeq1=[seq1(colunmIndex-1),tmpSeq1];
            tmpSeq2=['.',tmpSeq2];
            rowIndex=t_table(rowIndex,colunmIndex);
            colunmIndex=colunmIndex-1;
        elseif colunmIndex~=1
            v=t_table(rowIndex,colunmIndex);
            if v==1
                tmpSeq1=[seq1(colunmIndex-1) tmpSeq1];
                tmpSeq2=[seq2(rowIndex-1) tmpSeq2];
                colunmIndex=colunmIndex-1;
                rowIndex=rowIndex-1;
            elseif v==2
                tmpSeq1=['-' tmpSeq1];
                tmpSeq2=[seq2(rowIndex-1) tmpSeq2];
                rowIndex=rowIndex-1;
            elseif v==3
                tmpSeq1=[seq1(colunmIndex-1) tmpSeq1];
                tmpSeq2=['-' tmpSeq2];
                colunmIndex=colunmIndex-1;
            elseif v==4
                rowIndex=1;
            end
        else
            break;
        end
    end
    new(1,:)=tmpSeq1;
    new(2,:)=tmpSeq2;
