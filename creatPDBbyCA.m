function creatPDBbyCA( ca,name )
%CREATPDBBYCA Summary of this function goes here
%   Detailed explanation goes here
 ffff=fopen(name,'w');
   for i=1:length(ca)
    fprintf(ffff,'ATOM       %4s %3s %s%4i    %8.3f%8.3f%8.3f      %6.2f\n',ca(i).atmname,ca(i).resname,ca(i).subunit,ca(i).resno,ca(i).coord(1),ca(i).coord(2),ca(i).coord(3),ca(i).bval);
    end
fclose(ffff);
end

