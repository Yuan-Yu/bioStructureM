function [ca] =cafrompdb(s,pdbType)
%%% Bug: atomno should go from 7 to 11 and not 12.
if ~exist('pdbType', 'var')
    pdbType='X-RAY';
end
j=0;
lastresno=-1000;
numOfMode=0;
flag=0;
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
                    if ~strcmp(sscanf(line(73:76),'%s'),strtrim(line(73:76))) || ~strcmp(sscanf(line(77:78),'%s'),strtrim(line(77:78)))
                        error('fuck!!!')
                        flag=1;
                    end
                else
                    ca(j).charge    =   '';
                    ca(j).segment   =   '';
                    ca(j).elementSymbol='';
                end
                        %% just for test 2014/9/14

                  if ~strcmp(sscanf(strtrim(line(1:6)),'%c'),record)
                      display([sscanf(line(1:6),'%c') ' 1 ' record]);
                       display(length(sscanf(line(1:6),'%c')));
                       display(length(record));
                      flag=1;
                  end
                  if ~strcmp(sscanf(line(18:20),'%c'),line(18:20))
                      display([sscanf(line(18:20),'%c') ' 2 ' line(18:20)]);
                      flag=1;
                  end
                  if ~strcmp(sscanf(strtrim(line(23:27)),'%c'),resno) 
                      display([sscanf(strtrim(line(23:27)),'%c') ' 3 ' resno]);
                      flag=1;
                  end
                  if ~strcmp(sscanf(line(22),'%c'),line(22))
                      display([sscanf(line(22),'%c') ' 4 ' line(22)]);
                      flag=1;
                  end
                  if ~strcmp(sscanf(line(17:17),'%c'),Altloc) 
                      display([sscanf(line(17:17),'%c') ' 5 ' Altloc]);
                      flag=1;
                  end
                  if flag
                      error('fuck');
                  end
                        %% 
                lastresno=resno;
                currentAltloc=Altloc;
           
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
    

