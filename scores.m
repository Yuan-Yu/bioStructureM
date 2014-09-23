function [v ,index ]=scores(r,c,w, match_table,s_table)
    d=s_table(r,c);
    u=s_table(r,c+1);
    l=s_table(r+1,c);
%     cvalue=[d+match_table(r,c) , u+w , l+w];
%     [v ,index]=max(cvalue);
    dig=d+match_table(r,c);
    up=u+w;
    left=l+w;
    if dig>=up
        v=dig;
        index=1;
        if v<left
            v=left;
            index=3;
        end
    else 
        v=up;
        index=2;
        if v<left
            v=left;
            index=3;
        end
    end
        