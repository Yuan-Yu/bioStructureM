function [ca] =cafrompdb(s,pdbType)
%%% Bug: atomno should go from 7 to 11 and not 12.
if ~exist('pdbType', 'var')
    pdbType='X-RAY';
end
j=0;
lastresno=-1000;
numOfMode=0;
mode={};
ca(1).resname =[];
ca(1).atmname =[];
ca(1).resno =[];
ca(1).coord =[];
ca(1).bval =[];
ca(1).subunit =[];
fid=fopen(s);
if fid==-1
    error([s ' file does not exist!!']);
end
line = fgetl(fid);

while ischar(line)
    lenOfline=length(line);
    record=regexp(line,'^ATOM|^HETATM','once','match');
    if(lenOfline>=66)
         if ~isempty(record)
            resno=strtrim(line(23:27));
            Altloc=line(17:17);
            if  (strcmp(resno,lastresno) && double(Altloc)==currentAltloc)  || ~strcmp(resno,lastresno)
				j=j+1;
                ca(j).record    =   record;
                ca(j).atomno    =   sscanf(line(7:12),'%i');
                ca(j).atmname   =   strtrim(line(12:16));                
                ca(j).resname   =   line(18:20);
                ca(j).resno     =   resno;        %bug test 2014/9/9
                ca(j).coord     =   sscanf(line(31:54),'%f %f %f');
                ca(j).bval      =   sscanf(line(61:66),'%f');
                ca(j).subunit   =   line(22);
                ca(j).occupancy =   sscanf(line(55:60),'%f');
                ca(j).alternate =   Altloc;
                if lenOfline>=80
                    ca(j).charge    =   sscanf(line(79:80),'%s');
                    ca(j).segment   =   sscanf(line(73:76),'%s');
                    ca(j).elementSymbol=sscanf(line(77:78),'%s');
                elseif lenOfline>=78
                    ca(j).segment   =   sscanf(line(73:76),'%s');
                    ca(j).elementSymbol=sscanf(line(77:78),'%s');
                    ca(j).charge    = '';
                else
                    ca(j).charge    =   '';
                    ca(j).segment   =   '';
                    ca(j).elementSymbol='';
                end
                lastresno=resno;
                currentAltloc=Altloc;
           
            end
         end    
        %%%%%% Stop when 'END' is encountered and stop when the first model in NMR file was read%%%%%%%%%%%%
    elseif(~isempty(regexp(line,'END$','once'))||(~isempty(regexp(line,'ENDMDL$','once'))&&~isequal(pdbType,'NMR')))
            break;
        %%%%%% read all mode of NMR %%%%%%%%%%%%           
    elseif ~isempty(regexp(line,'ENDMDL$','once'))
        j=0;
        lastresno=-1000;
        numOfMode=numOfMode+1;
        mode{numOfMode}=ca;
        ca=[];
    end
        line = fgetl(fid);
end

if isequal(pdbType,'NMR')&& ~isempty(mode)
    ca=mode;
elseif isequal(pdbType,'NMR')
    display('It seems like this pdb is not NMR structure!')
else
% 	ca=fixPdbBug__(ca); %bug test 2014/9/9
end
fclose(fid);
