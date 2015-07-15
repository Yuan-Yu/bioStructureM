function [logicIndexArray]=operateCommand(transformedCommands,pdbstructure,operator2funcDic)
%%%%%%%%%%% need operator2funcDic%%%%%%%%%%%
% need all the function listed in the operator2funcDic
% input:
%   transformedCommands:a cell array contain selections (logical array)
%       and operaters (string). The order of this array is postfix.
%   pdbstructure: the structure array gotten by readPDB.
%   operator2funcDic: generate by createDic.m
% return:
%   logicIndexArray: a logical array contain same length as
%       pdbstructure. The atoms seleted is 1,otherwise 0. 
%%%%%%%%%%% need operator2funcDic%%%%%%%%%%%

if ~exist('operator2funcDic','var')
    load operator2funcDic.mat
end

numOfCOmmand=length(transformedCommands);
stack = cell(1,numOfCOmmand);
top = 0;
for i =1:numOfCOmmand
    command=transformedCommands{i};
    if islogical(command)
       top = top+1;
       stack{top}=command;
    else
       % Get the operater first word because the operator2funcDic is using
       % the first word in operater as key.
       % The valuse that operator2funcDic returns is a cell. Its second
       % element is a complementary function of the operater and first is
       % number of the arguments that the function needed.
       funcInfo = operator2funcDic(regexp(command,'(.*?(?=\s))||^.*','match','once'));
       inputCell = cell(1,funcInfo{1});
       for indexOfinputCell =1:funcInfo{1}
           inputCell(indexOfinputCell)=stack(top);
           top = top -1;
       end
       top = top+1;
       func =funcInfo{2};
       stack{top}=func(command,pdbstructure,inputCell);
    end
end
if top ~=1
    throw(MException('atomSelector:SelectionError','Selection commmand error'));
end
logicIndexArray=stack{top};