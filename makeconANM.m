
function [hes]=makeconANM(pdb,num)

j=0;
k=0;
n=0;
hes=zeros(1000000,3);
indexOfHes=1;
for j=1:num;
supe(1,1)=0.0;
supe(2,2)=0.0;
supe(3,3)=0.0   ;

supe(1,2)=0.0;
supe(1,3)=0.0  ;

supe(2,1)=0.0;
supe(2,3)=0.0  ;

supe(3,1)=0.0  ;
supe(3,2)=0.0  ;

    for k=1:num;
        r=norm(pdb(j).coord-pdb(k).coord);
% *************************** Change the CUTOFFs here ********************* 
        if(j==k) continue; end % Make the case only for i~=j
        if(r<15)
% *************************** Change the CUTOFFs here *********************                 
%            cont(i,j) = -1;
%            cont(j,i) = cont(i,j);
dx= pdb(j).coord(1)-pdb(k).coord(1);
dy= pdb(j).coord(2)-pdb(k).coord(2);
dz= pdb(j).coord(3)-pdb(k).coord(3);

              	   if(r<4)
                       eh=1;
                   else
                       eh=1;
                   end
% diagonals of diagonal super elements (for j)

            supe(1,1)      = supe(1,1)+eh*dx*dx/r^2;
            supe(2,2)      = supe(2,2)+eh*dy*dy/r^2;
			supe(3,3)      = supe(3,3)+eh*dz*dz/r^2;

% off-diagonals of diagonal superelements (for j)
			
   			supe(1,2)      = supe(1,2)+eh*dx*dy/r^2;
			supe(1,3)      = supe(1,3)+eh*dx*dz/r^2;
			%supe(2,1)      = supe(2,1)+dy*dx/r^2;
			supe(2,3)      = supe(2,3)+eh*dy*dz/r^2;



            if(k>j)
            hes(indexOfHes,:)=[3*j-2,3*k-2,-dx*dx*eh/r^2];
            hes(indexOfHes+1,:)=[3*j-1,3*k-1,-dy*dy*eh/r^2];
            hes(indexOfHes+2,:)=[3*j,3*k,-dz*dz*eh/r^2];
            indexOfHes=indexOfHes+3;
            end


            if(k>j)
            hes(indexOfHes,:)=[3*j-2,3*k-1,-dx*dy*eh/r^2];
            hes(indexOfHes+1,:)=[3*j-2,3*k,-dx*dz*eh/r^2];
            hes(indexOfHes+2,:)=[3*j-1,3*k-2,-dy*dx*eh/r^2];
            hes(indexOfHes+3,:)=[3*j-1,3*k,-dy*dz*eh/r^2];
            hes(indexOfHes+4,:)=[3*j,3*k-2,-dx*dz*eh/r^2];
            hes(indexOfHes+5,:)=[3*j,3*k-1,-dy*dz*eh/r^2];
            indexOfHes=indexOfHes+6;
            end
        end
    end
            hes(indexOfHes,:)=[3*j-2,3*j-2,supe(1,1)];
            hes(indexOfHes+1,:)=[3*j-1,3*j-1,supe(2,2)];
            hes(indexOfHes+2,:)=[3*j,3*j,supe(3,3)];
            hes(indexOfHes+3,:)=[3*j-2,3*j-1,supe(1,2)];
            hes(indexOfHes+4,:)=[3*j-2,3*j,supe(1,3)];
            hes(indexOfHes+5,:)=[3*j-1,3*j,supe(2,3)];
            indexOfHes=indexOfHes+6;
end
hes=hes(1:indexOfHes-1,:);
