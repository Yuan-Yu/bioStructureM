%%%%%%%%%%%%%%% for keywords%%%%%%%%%%%%%%
f = fopen('keyword_list.txt');
line=fgetl(f);
keyword2funcDic=containers.Map();
while ischar(line)
    line = deblank(line);
    tmp=regexp(line,':','split');
    keyword2funcDic(tmp{1})=str2func(['basicSelector_' tmp{2}]);
    line = fgetl(f);
end
fclose(f);
save('keyword2funcDic.mat','keyword2funcDic')
%%%%%%%%%%%%%% for operators %%%%%%%%%%%%%
ICP=containers.Map();
ISP=containers.Map();
operator2funcDic=containers.Map();
operator_regexpList ={};

text = fileread('operators.txt');
lines = regexp(text,'\n','split');
for linecell = lines
    line=linecell{1};
    line=strtrim(line);
    if line(1)~='#'
        words=regexp(line,':','split');
        ICP(words{1})=str2double(words{6});
        ISP(words{1})=str2double(words{5});
        operator2funcDic(words{1})={str2double(words{4}) str2func(['operatorSelector_' words{3}])};
        operator_regexpList = [operator_regexpList words{2}];
    end
end
save('ICP.mat','ICP')
save('ISP.mat','ISP')
save('operator2funcDic.mat','operator2funcDic')
save('operator_regexpList.mat','operator_regexpList')
