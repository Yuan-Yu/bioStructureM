function [ca] =atomfrompdb(pdbFileName,pdbType)
%%%%%%%%%%%%%%%%% need %%%%%%%%%%%%%%
% input:
%   pdbFileName: The name of the pdb file
%   pdbType:  0='X-ray' 1='NMR'. (Default is 0).
%   setAlternate: if atom is alternate which coordinate will be used.
%                (default is A)
% return:
%   if pdbType is X-ray,a structure will be return.
%		The structure contain attribute below
%                                 resname
%                                 atmname
%                                 resno
%                                 coord
%                                 bval
%                                 subunit
%                                 record
%                                 atomno
%                                 occupancy
%                                 segment
%                                 elementSymbol
%                                 alternate
%                                 charge
%                                 internalResno
%   if pdbType is NMR,a cellarry of structure will be return.
%%%%%%%%%%%%%%%%% need %%%%%%%%%%%%%%%
if ~exist('pdbType', 'var')
    pdbType=0;
end
numOfRes=0;

numOfMode=0;
mode={};

text = fileread(pdbFileName);
% get the line that contain start from "ATOM","HETATM",ENDMDL or END.
lineList=regexp(text,'((?<=\n)(ATOM|HETATM).*?\n)||(?<=\n)ENDMDL||(?<=\n)END||((^ATOM|^HETATM).*?\n)||((?<=\n)(ATOM|HETATM).*?$)','match');

lenOfLineList=length(lineList);
% initiate a structure array.
ca(lenOfLineList).resname =[];
currentInternalResno=0;
lastResno =-100000;
lastiCode = '!';
lastSegment='*!!!';
for lineIndex=1:lenOfLineList
    %line=deblank(lineList{lineIndex});
    line=lineList{lineIndex};
    lenOfline=length(line);
    if(lenOfline>=66)
        resno=strtrim(line(23:26));
        Altloc=line(17:17);
%         if  ~isempty(regexpi(Altloc,checkAlternate,'once'))
            numOfRes=numOfRes+1;
            ca(numOfRes).record    =   strtrim(line(1:6));
            ca(numOfRes).atomno    =   sscanf(line(7:12),'%i');
            ca(numOfRes).atmname   =   strtrim(line(12:16));                
            ca(numOfRes).resname   =   strtrim(line(18:21));
            ca(numOfRes).resno     =   resno;
            ca(numOfRes).iCode     =   line(27);
            ca(numOfRes).coord     =   sscanf(line(31:54),'%f %f %f');
            ca(numOfRes).bval      =   sscanf(line(61:66),'%f');
            ca(numOfRes).subunit   =   line(22);
            ca(numOfRes).occupancy =   sscanf(line(55:60),'%f');
            ca(numOfRes).alternate =   Altloc;
            if lenOfline>=80
                ca(numOfRes).charge    =   strtrim(line(79:80));
                ca(numOfRes).segment   =   strtrim(line(73:76));
                ca(numOfRes).elementSymbol=strtrim(line(77:78));
            elseif lenOfline>=78
                ca(numOfRes).segment   =   strtrim(line(73:76));
                ca(numOfRes).elementSymbol=strtrim(line(77:78));
                ca(numOfRes).charge    = '';
            elseif lenOfline>=76
                ca(numOfRes).segment   =   strtrim(line(73:76));
                ca(numOfRes).charge    =   '';
                ca(numOfRes).elementSymbol='';
            else
                ca(numOfRes).charge    =   '';
                ca(numOfRes).segment   =   '';
                ca(numOfRes).elementSymbol='';
            end
            
            %%% Build interal residue number.  new attribute testing
            if ~strcmp(resno,lastResno) || lastiCode ~= line(27) ||  ~strcmp(lastSegment,ca(numOfRes).segment)
                lastResno = resno;
                lastiCode = line(27);
                lastSegment = ca(numOfRes).segment;
                currentInternalResno = currentInternalResno + 1;
            end
            ca(numOfRes).internalResno = currentInternalResno;
            %%%
%         end   
        %%%%%% Stop when 'END' is encountered and stop when the first model in NMR file was read%%%%%%%%%%%%
    elseif(~isempty(regexp(line,'END$','once'))||(~isempty(regexp(line,'ENDMDL$','once'))&& ~pdbType))
            break;
        %%%%%% read all mode of NMR %%%%%%%%%%%%           
    elseif ~isempty(regexp(line,'ENDMDL$','once'))
        % test
        currentInternalResno=0;
        lastResno =-100000;
        lastiCode = '!';
        lastSegment='*!!!';
        %
        ca(numOfRes+1:end)=[];
        numOfRes=0;
        numOfMode=numOfMode+1;
        mode{numOfMode}=ca;
        ca=[];
    end
end

if pdbType&& ~isempty(mode)
    ca=mode;
elseif pdbType
    warning('It seems like this pdb is not NMR structure!');
    ca(numOfRes+1:end)=[];
else
    ca(numOfRes+1:end)=[];
end

