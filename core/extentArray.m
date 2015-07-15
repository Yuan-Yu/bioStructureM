function [newary]=extentArray(ary,numOfdiag)
%%%%%%%%%%%% need %%%%%%%%%%%%%%%
% input:
%   ary: An Array
%   numOfdiag: the size of each block.
% return
%   newary: an array contains many diagal block. And diagal elements of each block is an etrry in
%       original array.
%  ex. 
%   newary=extentAarry(ary,3)
%   ary=[1 2
%        3 4]
%   newary=[1 0 0 2 0 0
%           0 1 0 0 2 0
%           0 0 1 0 0 2
%           3 0 0 4 0 0
%           0 3 0 0 4 0
%           0 0 3 0 0 4]
%%%%%%%%%%%% need %%%%%%%%%%%%%%%
[rowNum,colNum]=size(ary);
newary=zeros(rowNum*numOfdiag,colNum*numOfdiag);
for colindex=1:colNum
    for rowindex=1:rowNum
        colindexOfNewary=colindex*numOfdiag;
        rowindexOfNewary=rowindex*numOfdiag;
        value=ary(rowindex,colindex);
        for x=0:numOfdiag-1
            newary(rowindexOfNewary-x,colindexOfNewary-x)=value;
        end
    end
end 

end
