function [v index ]=scores(r,c,w, match_table,s_table)
    d=s_table(r,c);
    u=s_table(r,c+1);
    l=s_table(r+1,c);
    cvalue=[d+match_table(r,c) , u+w , l+w];
    [v index]=max(cvalue);
end