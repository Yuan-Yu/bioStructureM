function [v ,index ]=scoresRep(r,c,w, match_table,s_table)
    d=s_table(r,c);
    u=s_table(r,c+1);
    l=s_table(r+1,c);
    dig=d+match_table(r,c);
    up=u+w;
    left=l+w;
    v=max([dig,up,left,s_table(1,c+1)]);
    index=find([dig,up,left,s_table(1,c+1)]==v);