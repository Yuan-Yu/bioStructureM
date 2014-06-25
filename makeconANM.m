
function [ss]=makeconANM(pdb,num,s)

j=0;
k=0;
n=0;
ss=[s '.hes'];
fidh=fopen(ss,'wt');

for j=1:num;
%cont=zeros(num,num);
% First make the diagonal super elements zero (for supper element(j,j) that is 3*3)
%hessian(3*j-2,3*j-2)=0.0;
%hessian(3*j-1,3*j-1)=0.0;
%hessian(3*j,3*j)=0.0   ;
%hessian(3*j-2,3*j-1)=0.0;
%hessian(3*j-2,3*j)=0.0  ;
%hessian(3*j-1,3*j-2)=0.0;
%hessian(3*j-1,3*j)=0.0  ;
%hessian(3*j,3*j-2)=0.0  ;
%hessian(3*j,3*j-1)=0.0  ;
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

			%hessian(3*j-2,3*j-2)      = hessian(3*j-2,3*j-2)+dx*dx/r^2;
            %hessian(3*j-1,3*j-1)      = hessian(3*j-1,3*j-1)+dy*dy/r^2;
			%hessian(3*j,3*j)          = hessian(3*j,3*j)+dz*dz/r^2;
            supe(1,1)      = supe(1,1)+eh*dx*dx/r^2;
            supe(2,2)      = supe(2,2)+eh*dy*dy/r^2;
			supe(3,3)      = supe(3,3)+eh*dz*dz/r^2;

% off-diagonals of diagonal superelements (for j)
			
			%hessian(3*j-2,3*j-1)      = hessian(3*j-2,3*j-1)+dx*dy/r^2;
			%hessian(3*j-2,3*j)        = hessian(3*j-2,3*j)+dx*dz/r^2;
			%hessian(3*j-1,3*j-2)      = hessian(3*j-1,3*j-2)+dy*dx/r^2;
			%hessian(3*j-1,3*j)        = hessian(3*j-1,3*j)+dy*dz/r^2;
			%hessian(3*j,3*j-2)        = hessian(3*j,3*j-2)+dx*dz/r^2;
			%hessian(3*j,3*j-1)        = hessian(3*j,3*j-1)+dy*dz/r^2;
   			supe(1,2)      = supe(1,2)+eh*dx*dy/r^2;
			supe(1,3)      = supe(1,3)+eh*dx*dz/r^2;
			%supe(2,1)      = supe(2,1)+dy*dx/r^2;
			supe(2,3)      = supe(2,3)+eh*dy*dz/r^2;
			%supe(3,1)      = supe(3,1)+dx*dz/r^2;
			%supe(3,2)      = supe(3,2)+dy*dz/r^2;

% diagonals of off-diagonal superelements (for j&k)

%			hessian(3*j-2,3*k-2)      = -dx*dx/r^2;
%			hessian(3*j-1,3*k-1)      = -dy*dy/r^2;
%			hessian(3*j,3*k)          = -dz*dz/r^2;
            if(k>j)
            fprintf(fidh,'%8i%8i  % 20.15e\n',3*j-2,3*k-2,-dx*dx*eh/r^2);
            fprintf(fidh,'%8i%8i  % 20.15e\n',3*j-1,3*k-1,-dy*dy*eh/r^2);
            fprintf(fidh,'%8i%8i  % 20.15e\n',3*j,3*k,-dz*dz*eh/r^2);
            end
% off-diagonals of off-diagonal superelements (for j&k)

%			hessian(3*j-2,3*k-1)      = -dx*dy/r^2;
%			hessian(3*j-2,3*k)        = -dx*dz/r^2;
%			hessian(3*j-1,3*k-2)      = -dy*dx/r^2;
%			hessian(3*j-1,3*k)        = -dy*dz/r^2;
%			hessian(3*j,3*k-2)        = -dx*dz/r^2;
%			hessian(3*j,3*k-1)        = -dy*dz/r^2;
            if(k>j)
            fprintf(fidh,'%8i%8i  % 20.15e\n',3*j-2,3*k-1,-dx*dy*eh/r^2);
            fprintf(fidh,'%8i%8i  % 20.15e\n',3*j-2,3*k,-dx*dz*eh/r^2);
            fprintf(fidh,'%8i%8i  % 20.15e\n',3*j-1,3*k-2,-dy*dx*eh/r^2);
            fprintf(fidh,'%8i%8i  % 20.15e\n',3*j-1,3*k,-dy*dz*eh/r^2);
            fprintf(fidh,'%8i%8i  % 20.15e\n',3*j,3*k-2,-dx*dz*eh/r^2);
            fprintf(fidh,'%8i%8i  % 20.15e\n',3*j,3*k-1,-dy*dz*eh/r^2);
            end
%                     if (j==num)
    
%                     end    
        end
    end
% diagonals of diagonal super elements (for j)
            fprintf(fidh,'%8i%8i  % 20.15e\n',3*j-2,3*j-2,supe(1,1));
            fprintf(fidh,'%8i%8i  % 20.15e\n',3*j-1,3*j-1,supe(2,2));
            fprintf(fidh,'%8i%8i  % 20.15e\n',3*j,3*j,supe(3,3));
% off-diagonals of diagonal superelements (for j)            
            fprintf(fidh,'%8i%8i  % 20.15e\n',3*j-2,3*j-1,supe(1,2));
            fprintf(fidh,'%8i%8i  % 20.15e\n',3*j-2,3*j,supe(1,3));
            %fprintf(fidh,'%8i%8i  %20.15e\n',3*j-1,3*j-2,supe(2,1));
            fprintf(fidh,'%8i%8i  % 20.15e\n',3*j-1,3*j,supe(2,3));
            %fprintf(fidh,'%8i%8i  %20.15e\n',3*j,3*j-2,supe(3,1));
            %fprintf(fidh,'%8i%8i  %20.15e\n',3*j,3*j-1,supe(3,2));
end

fclose(fidh);

%for j=1:num

%%fh =  fopen('temp.sparsehessian', 'w') ;
%%for n=1:3*num
%%	for m=n:3*num
%%		if (hessian(n,m) ~= 0.0) 
%%			fprintf (fh, '%8d%8d%25.15e\n',n,m,hessian(n,m)) ;
%%        end
%%    end
%%end
%%fclose (fh) ;

%cont(j,j) = -sum(cont(j,:));
       %%%    cont(j,j) = length(find(cont(j,:)));
%end
