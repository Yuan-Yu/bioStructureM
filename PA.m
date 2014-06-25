function [StrX, StrY, Index_Seq1_Seq2, Y_index TraceBack] = PA ( Seq_X, Seq_Y)
%% Yang Lab| ARAVIND-100080710| Edited: 8th March, 2013.

%%
% Blosum62
% Gap opening penalty =-10
% Gap entension penalty =-1
Y_index=0;
%% Blosum62 data
order='CSTPAGNDEQHRKMILVFYW';
blosum=[9,-1,-1,-3,0,-3,-3,-3,-4,-3,-3,-3,-3,-1,-1,-1,-1,-2,-2,-2;-1,4,1,-1,1,0,1,0,0,0,-1,-1,0,-1,-2,-2,-2,-2,-2,-3;-1,1,4,1,-1,1,0,1,0,0,0,-1,0,-1,-2,-2,-2,-2,-2,-3;-3,-1,1,7,-1,-2,-1,-1,-1,-1,-2,-2,-1,-2,-3,-3,-2,-4,-3,-4;0,1,-1,-1,4,0,-1,-2,-1,-1,-2,-1,-1,-1,-1,-1,-2,-2,-2,-3;-3,0,1,-2,0,6,-2,-1,-2,-2,-2,-2,-2,-3,-4,-4,0,-3,-3,-2;-3,1,0,-2,-2,0,6,1,0,0,-1,0,0,-2,-3,-3,-3,-3,-2,-4;-3,0,1,-1,-2,-1,1,6,2,0,-1,-2,-1,-3,-3,-4,-3,-3,-3,-4;-4,0,0,-1,-1,-2,0,2,5,2,0,0,1,-2,-3,-3,-3,-3,-2,-3;-3,0,0,-1,-1,-2,0,0,2,5,0,1,1,0,-3,-2,-2,-3,-1,-2;-3,-1,0,-2,-2,-2,1,1,0,0,8,0,-1,-2,-3,-3,-2,-1,2,-2;-3,-1,-1,-2,-1,-2,0,-2,0,1,0,5,2,-1,-3,-2,-3,-3,-2,-3;-3,0,0,-1,-1,-2,0,-1,1,1,-1,2,5,-1,-3,-2,-3,-3,-2,-3;-1,-1,-1,-2,-1,-3,-2,-3,-2,0,-2,-1,-1,5,1,2,-2,0,-1,-1;-1,-2,-2,-3,-1,-4,-3,-3,-3,-3,-3,-3,-3,1,4,2,1,0,-1,-3;-1,-2,-2,-3,-1,-4,-3,-4,-3,-2,-3,-2,-2,2,2,4,3,0,-1,-2;-1,-2,-2,-2,0,-3,-3,-3,-2,-2,-3,-3,-2,1,3,1,4,-1,-1,-3;-2,-2,-2,-4,-2,-3,-3,-3,-3,-3,-1,-3,-3,0,0,0,-1,6,3,1;-2,-2,-2,-3,-2,-3,-2,-3,-2,-1,2,-2,-2,-1,-1,-1,-1,3,7,2;-2,-3,-3,-4,-3,-2,-4,-4,-3,-2,-2,-3,-3,-1,-3,-2,-3,1,2,11];
%%
LenX=length(Seq_X);
LenY=length(Seq_Y);
ScoreMatrix=zeros(LenX+1, LenY+1);
V=zeros(LenX+1, LenY+1);
H=V;
TraceBack=zeros(LenX, LenY);
for k=2:LenX+1
    ScoreMatrix(k,1)=-0.1*(k-1);
    V(k,1)=-0.1*(k-1);
    jpv(k,1)=k-1;
    jph(k,1)=1;
end
for k=2:LenY+1
    ScoreMatrix(1,k)=-0.1*(k-1);
    H(1,k)=-0.1*(k-1);
    j2i(k-1)=-1;
    jpv(1,k)=1;
    jph(1,k)=k-1;
end
% initialze fisrt row and first col, 
% if [1,:] and [:,1] both =0, do not need to set this two 'for'

for i=2:LenX+1
    for j=2:LenY+1
        aa=find(ismember(order,Seq_X(i-1)));
        bb=find(ismember(order,Seq_Y(j-1)));
        s=blosum(find(ismember(order,Seq_X(i-1))),find(ismember(order,Seq_Y(j-1))));
        V1=ScoreMatrix(i-1,j-1)+s;
        %% Gap opening penalty = -10, gap extension penalty = -1.
        gop=-10;
        ge=-1;
        %%
        v2=ScoreMatrix(i-1,j)+gop;%vertical
        vv=V(i-1,j)+ge;
        V(i,j)=max(vv,v2);   
        if(V(i,j)==(V(i-1,j)+ge))
            jpv(i,j)=jpv(i-1,j)+1;
        end
        V2=V(i,j);
        v3=ScoreMatrix(i,j-1)+gop;%horizontal
        H(i,j)=max(H(i,j-1)+ge,v3);
        if(H(i,j)==(H(i,j-1)+ge))
            jph(i,j)=jph(i,j-1)+1;
        end
        V3=H(i,j);
        
        V11=[V1 V2 V3];
        Vmax=max(V11);
        if(V1>V2 && V1>V3)
            dummy=1;
            ScoreMatrix(i,j)=V1;        
        elseif(V3<V2)
            ScoreMatrix(i,j)=V2; 
            dummy=2;
        else
            ScoreMatrix(i,j)=V3;
            dummy=3;
        end
        if dummy==1
            TraceBack(i-1,j-1)=1;
        elseif dummy==2
            TraceBack(i-1,j-1)=2; % up arrow
        elseif dummy==3
            TraceBack(i-1,j-1)=3; % left arrow
        end
    end
end
m=LenX+LenY;
n=LenX+LenY;
i=LenX;
j=LenY;
%YHC-1ss
Index_Seq1_Seq2=zeros(2,LenX+LenY);
%YHC-1ee
while (i>=1 && j>=1)
    if(TraceBack(i,j)==1)           
        StrX(m)=Seq_X(i);
        StrY(n)=Seq_Y(j);  
        Index_Seq1_Seq2(1,i)=i;
        Index_Seq1_Seq2(2,j)=j;
        m=m-1; n=n-1; i=i-1; j=j-1;
    elseif(TraceBack(i,j)==2) % up arrow
        StrX(m)=Seq_X(i);
        StrY(n)='-';
        m=m-1; n=n-1; i=i-1;% j=j-1;
    elseif(TraceBack(i,j)==3) % left arrow
        StrX(m)='-';
        StrY(n)=Seq_Y(j);
        m=m-1; n=n-1; j=j-1;% i=i-1;
    end
end
while i>0
    StrX(m)=Seq_X(i);
    StrY(n)='-';
    m=m-1; n=n-1; i=i-1;% j=j-1;
end
while j>0
    StrX(m)='-';
    StrY(n)=Seq_Y(j);
    m=m-1; n=n-1; j=j-1;% i=i-1;
end
while m>0
    StrX(m)=' ';
    m=m-1;
end
while n>0
    StrY(n)=' ';
    n=n-1;
end
StrX=strtrim(strcat(StrX,' '));
StrY=strtrim(strcat(StrY,' '));
StrY_int=abs(StrY);
Y_index=0;
for k=1:length(StrY)
    if StrY_int(k)~=45
        Y_index=Y_index+1;
    end
end
Y_index;
Seq2_index=0;
for kk=1:length(Index_Seq1_Seq2)
    if Index_Seq1_Seq2(2,kk)~=0
        Seq2_index=Seq2_index+1;
    end
end
Seq2_index;
Index_Seq1_Seq2(1,:)=sort(Index_Seq1_Seq2(1,:));
Index_Seq1_Seq2(2,:)=sort(Index_Seq1_Seq2(2,:));
%-------------------------------------------
end

