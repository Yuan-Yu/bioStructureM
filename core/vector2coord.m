function [coord]=vector2coord(vector)
coord=reshape(vector,3,length(vector)/3)';