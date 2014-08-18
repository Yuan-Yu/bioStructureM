function [pdb]=AGNM(pdb,ANMModth,GNMModth,ANMCutOff,GNMCutOff)
%%%%%%%%% need GNM,ANM,ANM,ANMdR%%%%%%%%%%%%%
% input:
%   pdb is the structure gotten from cafrompdb.
%   ANMModth is a array 
%   GNMModth is a number
%   ANMCutOff(optional)
%   GNMCutOff(optional)
% return:
%   pdb is the structure contain new attribute "AGNM","ANM" and "GNM".
%ca(index of atom).AGNM matrix is like mode1_x   mode1_y     mode1_z
%                                      mode2_x   mode2_y     mode2_z
%                                      mode3_x   mode3_y     mode3_z
%                                         |          |           |
%                                    lastmode_x  lastmode_y   lastmode_z
%
%%%%%%%%% need GNM,ANM,ANM,ANMdR%%%%%%%%%%%%%

    %% %%%%%%%set default value %%%%%%%%% 
    if ~exist('ANMCutOff','var')
        ANMCutOff=15;
    end
    if ~exist('GNMCutOff','var')
        GNMCutOff=7.3;
    end
    %%
    resNum=length(pdb);
    ANMModeNum=length(ANMModth);
    pdb=GNM(pdb,GNMModth,GNMCutOff);
    pdb=ANM(pdb,ANMModth(end),ANMCutOff);
    ANMVector=ANMdR(pdb,ANMModth(1),ANMModth(end));
    ANMVector=normc(reshape(ANMVector,3,resNum*ANMModeNum));
    GNMScale=getGNM(pdb,GNMModth);
    AGNM=(ANMVector.*repmat(GNMScale',3,ANMModeNum))';
    for i=1:length(pdb)
        pdb(i).AGNM(1:ANMModeNum,:)=AGNM(i:resNum:end,:);
    end
end

