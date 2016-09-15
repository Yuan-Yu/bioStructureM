%% project_frames_to_ANM_modes: Project MD trajectoryto each ANM modes
%
%  Arguments:
%         eigvec: Matrix of (No of atoms x 3) by (No of ANM_modes)
%         frames: Frames of coordinate of atoms aligned to the mean structure used in PCA.
%                 (No of atoms * 3) by (No of frames) matrix
%  Returns:
%         projections: Matrix of (No of ANM_modes) by (No of frames)
%
%  Edited by Hong-Rui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [proj_file_list] = project_frames_to_ANM_modes(Q_file_list, eigvec, total_no_frames)
    eigvec = eigvec';

    no_Q_files = numel(Q_file_list);
    constant = sqrt(total_no_frames - 1);
    proj_file_list = cell(no_Q_files,1);

    for Q_file_no = 1:no_Q_files
        Q_file = matfile(Q_file_list{Q_file_no});
        Q_file_variable_name = who(Q_file);

        current_projection = eigvec * Q_file.(Q_file_variable_name{1}) * constant;
        save(['proj_' num2str(Q_file_no) '.mat'], 'current_projection', '-v7.3');
        proj_file_list{Q_file_no} = ['proj_' num2str(Q_file_no) '.mat'];
    end
end
