function [pdb]=fixPdbBug__(pdb)
%%%%%%%%% Don't use this function directly. %%%%%%%%%%%%
% input:
%   pdb
% return:
%   pdb
%%%%%%%%% Don't use this function directly. %%%%%%%%%%%%
atomName={pdb.atmname};
lgIndex=strcmp(atomName,'CA');
index=find(lgIndex);
lastresno=-200000;
lastAchar=0;
resnoAcharID=[];
for i=index
    currentResno=pdb(i).resno;
    currentAchar=double(pdb(i).achar);
    if currentResno~=lastresno
        lastresno=currentResno;
        lastAchar=currentAchar;
    elseif currentAchar<lastAchar
        resnoAcharID=[resnoAcharID;lastresno*200+lastAchar];
        lastAchar=currentAchar;
    end
end
resno=[pdb.resno];
achar=double([pdb.achar]);
deleteIndex=ismember((resno*200)+achar,resnoAcharID);
pdb(deleteIndex)=[];