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
    if(length(line)>=66)
         if ~isempty(regexp(line,'^ATOM|^HETATM','once'))
            if  (sscanf(line(23:26),'%i')==lastresno && double(sscanf(line(17:17),'%c'))==currentAltloc)  || sscanf(line(23:26),'%i')~=lastresno 
				j=j+1;
                ca(j).record    =   sscanf(line(1:6),'%c');
                ca(j).atomno    =   sscanf(line(7:12),'%i');
                ca(j).atmname   =   strtrim(line(12:16));                
                ca(j).resname   =   sscanf(line(18:20),'%c');
                ca(j).resno     =   sscanf(strtrim(line(23:27)),'%c');        %bug test 2014/9/9
                ca(j).coord     =   sscanf(line(31:54),'%f %f %f');
                ca(j).bval      =   sscanf(line(61:66),'%f');
                ca(j).subunit   =   sscanf(line(22),'%c');
                ca(j).occupancy =   sscanf(line(55:60),'%f');
                ca(j).segment   =   sscanf(line(73:76),'%s');
                ca(j).elementSymbol=sscanf(line(77:78),'%s');
                ca(j).alternate =   sscanf(line(17:17),'%c');
                if length(line)>=80
                    ca(j).charge    =   sscanf(line(79:80),'%s');
                else
                    ca(j).charge    = '';
                end
                lastresno=sscanf(line(23:26),'%i');
                currentAltloc=double(sscanf(line(17:17),'%c'));
           
            end
            
        %%%%%% Stop when 'END' is encountered and stop when the first model in NMR file was read%%%%%%%%%%%%
        elseif(isequal(sscanf(line(1:6),'%c'),'END   ')||(isequal(sscanf(line(1:6),'%c'),'ENDMDL')&&~isequal(pdbType,'NMR')))
                break;
        %%%%%% read all mode of NMR %%%%%%%%%%%%           
        elseif(isequal(sscanf(line(1:6),'%c'),'ENDMDL'))
            j=0;
            lastresno=-1000;
            numOfMode=numOfMode+1;
%            mode{numOfMode}=fixPdbBug__(ca);   %bug test 2014/9/9
        end
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
    

