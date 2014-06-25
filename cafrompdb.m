function [ca,resnum] =cafrompdb(s)

%function [c,bval] =CAfrompdb(s)
%function pdb = pdbparse(s)
% CAFROMPDB(S), where S is a string, refering to the file to be opened.
i=0;
j=0;
DNA=1;
countlastchain=0;

lastresno=-1000;
resnum=0;
ca(1).resname =[];
ca(1).atmname =[];
ca(1).resno =[];
ca(1).coord =[];
ca(1).bval =[];
ca(1).subunit =[];
               fid=fopen(s);
               line = fgetl(fid);
% revised by Lee 062504 - original:      while isstr(line)  % isstr wont be supported in the later version
while ischar(line)
    if(length(line)>=66)
        if (isequal(sscanf(line(1:6),'%c'),'ATOM  ') | isequal(sscanf(line(1:6),'%c'),'HETATM'))
            if  ~(double(sscanf(line(17:17),'%c'))>65&&sscanf(line(23:26),'%i')==lastresno)
                j=j+1;
                ca(j).atmname =  sscanf(line(12:16),'%c');                
                ca(j).resname =  sscanf(line(18:20),'%c');
                ca(j).resno =  sscanf(line(23:26),'%i');
                ca(j).coord =  sscanf(line(31:54),'%f %f %f');
                ca(j).bval =  sscanf(line(61:66),'%f');
                ca(j).subunit =  sscanf(line(22),'%c');
                DNA=0;         
                lastresno=sscanf(line(23:26),'%i');
            end
            
%%%%%% Stop when 'END' is encountered and stop when the first model in NMR file was read %%%%%%%%%%%%
        elseif(isequal(sscanf(line(1:6),'%c'),'END   ')|isequal(sscanf(line(1:6),'%c'),'ENDMDL'))
                break;
        %%%%%% Stop when 'END' is encountered and stop when the first model in NMR file was read %%%%%%%%%%%%        
        end
    end
        line = fgetl(fid);
end
fclose(fid);
    

