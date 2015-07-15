function [transformedCommands]=commandParser(selectionString,pdbstructure,operator_regexpList,ISP,ICP)
%%%%%%%% need selection_router,strjoin,ISP,ICP,operator_regexpList%%%%%%%%
% input:
%   selectionString: the command string semirlar to VMD type.
%   pdbstructure: the structure array gotten by readPDB.
%   operator_regexpList: generate by createDic.m
%   ISP: generate by createDic.m
%   ICP: generate by createDic.m
% return:
%   transformedCommands: a cell array contain selections (logical array)
%       and operators (string). The order of this array is postfix.
%%%%%%%% need selection_router,strjoin,ISP,ICP,operator_regexpList%%%%%%%%

if ~exist('operator_regexpList','var')
    load operator_regexpList.mat
end
if ~exist('ISP','var')
    load ISP.mat
    load ICP.mat
end

%separate the operator and keyword
[operators,keywordSelections]=regexp(selectionString,strjoin(operator_regexpList,'||'),'match','split');
%apply keywordSelection
selections=keywordSelection_router(keywordSelections,pdbstructure);

%% Infix To Postfix
% Use stack method 
numberOfsubCommand = length(operators)+length(selections);
stack = cell(1,numberOfsubCommand);
topIndex=0;
outputIndex=1;
transformedCommands = cell(1,numberOfsubCommand); 
%%%%%%%
% ISP and ICP just use the first word of operator as key.
%  regexp(operator,'(.*?(?=\s))||^.*','match','once')
%%%%%%%%
for i = 1:numberOfsubCommand
    if rem(i,2)
        selection = selections{(i+1)/2};
        if isempty(selection)
            continue;
        end
        transformedCommands{outputIndex} = selection;
        outputIndex = outputIndex+1;
    else
        operator = operators{i/2};
        currentICP=ICP(regexp(operator,'(.*?(?=\s))||^.*','match','once'));
        if operator == ')'
            while stack{topIndex} ~='('
                transformedCommands(outputIndex)=stack(topIndex);
                topIndex=topIndex-1;
                outputIndex=outputIndex+1;
            end
            topIndex=topIndex-1;
            continue
        end

        if topIndex==0 || ISP(regexp(stack{topIndex},'(.*?(?=\s))||^.*','match','once'))<currentICP
            topIndex=topIndex+1;
            stack{topIndex}=operator;
            continue
        else
            while topIndex~=0 && ISP(regexp(stack{topIndex},'(.*?(?=\s))||^.*','match','once'))>currentICP
                transformedCommands(outputIndex)=stack(topIndex);
                topIndex=topIndex-1;
                outputIndex=outputIndex+1;
            end
            topIndex=topIndex+1;
            stack{topIndex}=operator;
        end
    end
end

while topIndex~=0
    transformedCommands(outputIndex)=stack(topIndex);
    topIndex=topIndex-1;
    outputIndex=outputIndex+1;
end

%%
transformedCommands =transformedCommands(1:outputIndex -1);
