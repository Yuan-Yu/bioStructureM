function [Nums]=translateNunberTypeCommand(selectionCell,typeStr)
%%%%%%%%%% need %%%%%%%%%%%%
% To translate string like {'1:4' '7' '10'} to [1 2 3 4 7 10] or {'1' '2' '3' '4' '7' '10'}
% input:
%   selectionCell: a string like '1:4 7 10'
%   typeStr: if 1 , return String. if 0, return double array
% return:
%   Nums: if typeStr =1: a cell contain all the number.
%            typeStr =0: a double array.
%%%%%%%%%% need %%%%%%%%%%%%


tmp = cell(1,length(selectionCell));
numOfSelection =0;

if typeStr
    for i = 1:length(selectionCell)
        if isempty(regexp(selectionCell{i},':', 'once'))
            tmp(i)={selectionCell(i)};
            numOfSelection =numOfSelection+1;
        else
            %decompose the command have ':' sign.
            seqNums=arrayfun(@num2str,eval(selectionCell{i}),'UniformOutput',0);
            tmp(i)={seqNums};
            numOfSelection=numOfSelection +length(seqNums);
        end
    end
    %join all the number together.
    Nums = cell(1,numOfSelection);
    currentIndex = 1;
    for i = 1:length(selectionCell)
        lastIndex = currentIndex+length(tmp{i})-1;
        Nums(currentIndex:lastIndex)=tmp{i};
        currentIndex = lastIndex+1;
    end
else
    for i = 1:length(selectionCell)
        if isempty(regexp(selectionCell{i},':', 'once'))
            tmp(i)={str2double(selectionCell(i))};
            numOfSelection =numOfSelection+1;
        else
            %decompose the command have ':' sign.
            seqNums=eval(selectionCell{i});
            tmp(i)={seqNums};
            numOfSelection=numOfSelection +length(seqNums);
        end
    end
    %join all the number together.
    Nums = ones(1,numOfSelection);
    currentIndex = 1;
    for i = 1:length(selectionCell)
        lastIndex = currentIndex+length(tmp{i})-1;
        Nums(currentIndex:lastIndex)=tmp{i};
        currentIndex = lastIndex+1;
    end 
end
