function [StrX, StrY, Index_Seq1_Seq2, Y_index, TraceBack] = PA ( Seq_X, Seq_Y)
%% Yang Lab| ARAVIND-100080710| Edited: 8th March, 2013.

%%
% Blosum62
% Gap opening penalty =-10
% Gap entension penalty =-1
Y_index=0;
%% Gap opening penalty = -10, gap extension penalty = -1.
        gop=-10;
        ge=-1;
        %%
%% Blosum62 data
% load aa2order and blosum62Matrix
load('aa2order.mat');
order_X=arrayfun(@(x) aa2order(x),Seq_X);
order_Y=arrayfun(@(x) aa2order(x),Seq_Y);
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
        s=blosum62Matrix(order_X(i-1),order_Y(j-1));
        V1=ScoreMatrix(i-1,j-1)+s;
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
Seq2_index=0;
for kk=1:length(Index_Seq1_Seq2)
    if Index_Seq1_Seq2(2,kk)~=0
        Seq2_index=Seq2_index+1;
    end
end
Index_Seq1_Seq2(1,:)=sort(Index_Seq1_Seq2(1,:));
Index_Seq1_Seq2(2,:)=sort(Index_Seq1_Seq2(2,:));
%-------------------------------------------
end

