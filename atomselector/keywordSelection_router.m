function [selections]=keywordSelection_router(selectionsCommand,pdbstructure,keyword2funcDic)
%%%%%%%%%% need keyword2funcDic%%%%%%%%%%%
% input:
%   selectionsCommand: the selection command string semirlar to VMD type.
%   pdbstructure : the structure array gotten by readPDB.
%   comand2funcDic: for mapping the keyword to its corresponding the the function
% return:
%   selections: a cell array contain all of the logical array of keyword
%                   selection.The logical array contain same length as
%                   pdbstructure. The atoms seleted is 1,otherwise 0.            
%%%%%%%%%% need keyword2funcDic%%%%%%%%%%%
if ~exist('keyword2funcDic','var')
    load keyword2funcDic.mat
end

numSelection=length(selectionsCommand);
selections = cell(1,numSelection);
for indexOfSelection = 1:numSelection
    
    selelction = strtrim(selectionsCommand{indexOfSelection});
    % check whether the string is empty or just blank. 
    if isempty(selelction)
        continue;
    end
    subSelection=regexp(selelction,'\s+','split');
    numOfsubSelection=length(subSelection);
    
    % get the corresponding function of the keywork
    try
        func = keyword2funcDic(subSelection{1});
    catch keyworderror
        throw(MException('atomSelector:SelectionError',['can not identify keyword: "' subSelection{1} '"']));
    end
    
    %check whether the selection is a single keyword.
    if numOfsubSelection > 1
        selections{indexOfSelection}=func(pdbstructure,subSelection(2:end));
    else
        selections{indexOfSelection}=func(pdbstructure);
    end
    
end
