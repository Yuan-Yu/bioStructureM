function [ca,resnum,COORD] =cafrompdbanm(s)

%function [c,bval] =CAfrompdb(s)
%function pdb = pdbparse(s)
% CAFROMPDB(S), where S is a string, refering to the file to be opened.
i=0;
j=0;
DNA=1;
countlastchain=0;
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
        if (isequal(sscanf(line(12:16),'%c'),'  CA ')|((isequal(sscanf(line(12:16),'%c'),'  C2 ')|isequal(sscanf(line(12:16),'%c'),'  C4*')|isequal(sscanf(line(12:16),'%c'),'  C4''')|isequal(sscanf(line(12:16),'%c'),'  P  '))&(isequal(sscanf(line(18:20),'%c'),'  A')|isequal(sscanf(line(18:20),'%c'),'  G')|isequal(sscanf(line(18:20),'%c'),'  T')|isequal(sscanf(line(18:20),'%c'),'  C')|isequal(sscanf(line(18:20),'%c'),'  U')|isequal(sscanf(line(18:20),'%c'),' DA')|isequal(sscanf(line(18:20),'%c'),' DT')|isequal(sscanf(line(18:20),'%c'),' DC')|isequal(sscanf(line(18:20),'%c'),' DG')))) &  (isequal(sscanf(line(1:6),'%c'),'ATOM  ') | isequal(sscanf(line(1:6),'%c'),'HETATM')) & (isequal(sscanf(line(17:17),'%c'),'A')|isequal(sscanf(line(17:17),'%c'),' '))
                j=j+1;
                ca(j).atmname =  sscanf(line(12:16),'%c');                
                ca(j).resname =  sscanf(line(18:20),'%c');
                ca(j).resno =  sscanf(line(23:26),'%i');
                ca(j).coord =  sscanf(line(31:54),'%f %f %f');
                ca(j).bval =  sscanf(line(61:66),'%f');
                ca(j).subunit =  sscanf(line(22),'%c');
                DNA=0;              
            
%%%%%% Stop when 'END' is encountered and stop when the first model in NMR file was read %%%%%%%%%%%%
        elseif(isequal(sscanf(line(1:6),'%c'),'END   ')|isequal(sscanf(line(1:6),'%c'),'ENDMDL'))
                break;
        %%%%%% Stop when 'END' is encountered and stop when the first model in NMR file was read %%%%%%%%%%%%        
        end
    end
        line = fgetl(fid);
end
    resnum=j;
fclose(fid);

sca=[s(1:4) '.nodes'];
fida=fopen(sca,'a');
for j=1:resnum
fprintf(fida,'%s %s%6i %s  %8.3f     %8.3f     %8.3f     %6.2f\n',ca(j).resname,ca(j).subunit,ca(j).resno,ca(j).atmname,ca(j).coord(1),ca(j).coord(2),ca(j).coord(3),ca(j).bval);
COORD(j,:)=[ca(j).coord(1) ca(j).coord(2) ca(j).coord(3)];
end
fclose(fida);
%%%%%% Get rid of polypeptide inhibitor %%%%%%%%%%
%01/30/2006     if(resnum>0)
%01/30/2006        subunitlast = ca(resnum).subunit;
%01/30/2006        for j=1:resnum
%01/30/2006          if(isequal(ca(j).subunit,subunitlast)&~isequal(ca(1).subunit,ca(resnum).subunit))
%01/30/2006         countlastchain=countlastchain+1;
%01/30/2006          end
%01/30/2006        end
        
%01/30/2006        if(countlastchain>=15)
%01/30/2006            resnum=resnum;
%01/30/2006        else
%01/30/2006            resnum=resnum-countlastchain;    
%01/30/2006        end
%01/30/2006    end
%%%%%% Get rid of polypeptide inhibitor %%%%%%%%%%

j=0;


    %if(resnum>3)
           %fid1 = fopen(['/home/leewei/gamma/pdb/',s(4:7),'.ca'],'wt');
        %for j=1:resnum
            %fprintf(fid1,'%s%6d%12.3f%8.3f%8.3f%8.3f\n',ca(j).resname,ca(j).resno,ca(j).coord,ca(j).bval);
            %end
        %fprintf(fid1,'%5d',resnum);
        %fclose(fid1);
        %end
    

