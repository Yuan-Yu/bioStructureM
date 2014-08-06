function createPDBbyCA( ca,name )
%CREATPDBBYCA Summary of this function goes here
%   Detailed explanation goes here
% 13 - 16        Atom            Atom name 
% atom name start at 14 normally.
    fid=fopen(name,'w');
   if ~iscell(ca)
        for i=1:length(ca)
        fprintf(fid,'%6s%5i  %-4s%3s %s%4i    %8.3f%8.3f%8.3f %5.2f%6.2f\n',ca(i).record,ca(i).atomno,ca(i).atmname,ca(i).resname,ca(i).subunit,ca(i).resno,ca(i).coord(1),ca(i).coord(2),ca(i).coord(3),ca(i).occupancy,ca(i).bval);
        end 
   else
       for i=1:length(ca)
           fprintf(fid,'MODEL       %2i\n',i);
           model=ca{i};
           for j=1:length(model)
               fprintf(fid,'%6s%5i  %-4s%3s %s%4i    %8.3f%8.3f%8.3f %5.2f %6.2f\n',model(j).record,model(j).atomno,model(j).atmname,model(j).resname,model(j).subunit,model(j).resno,model(j).coord(1),model(j).coord(2),model(j).coord(3),model(j).occupancy,model(j).bval);
           end
           fprintf(fid,'ENDMDL');
       end
       fprintf(fid,'\n');
   end
   fprintf(fid,'END');
fclose(fid);
end

