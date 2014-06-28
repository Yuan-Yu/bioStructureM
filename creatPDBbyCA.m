function creatPDBbyCA( ca,name )
%CREATPDBBYCA Summary of this function goes here
%   Detailed explanation goes here
    fid=fopen(name,'w');
   if ~iscell(ca)
        for i=1:length(ca)
        fprintf(fid,'ATOM       %4s %3s %s%4i    %8.3f%8.3f%8.3f      %6.2f\n',ca(i).atmname,ca(i).resname,ca(i).subunit,ca(i).resno,ca(i).coord(1),ca(i).coord(2),ca(i).coord(3),ca(i).bval);
        end 
   else
       for i=1:length(ca)
           fprintf(fid,'MODEL       %2i\n',i);
           model=ca{i};
           for j=1:length(model)
               fprintf(fid,'%6s     %4s %3s %s%4i    %8.3f%8.3f%8.3f      %6.2f\n',model(j).record,model(j).atmname,model(j).resname,model(j).subunit,model(j).resno,model(j).coord(1),model(j).coord(2),model(j).coord(3),model(j).bval);
           end
           fprintf(fid,'ENDMDL');
       end
   end
fclose(fid);
end

