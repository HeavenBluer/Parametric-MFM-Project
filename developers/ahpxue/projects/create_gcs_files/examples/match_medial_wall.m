function match_medial_wall(input_annot, output_annot, cortex_annot, mesh_name)
% match_medial_wall(input_annot, output_annot, cortex_annot, mesh_name)
% 
% This function adjest the medial wall of your parcellation to be the same
% with the medial wall defined by ?h.cortex.label. ?h.cortex.label should
% be converted to an annot file using mris_label2annot.
% This function assumes the label of the medial wall is 65793, i.e. R = 1,
% G = 1, B = 1.
% Note that matlab 2014a do not have function contains. Please use 2018b.
% 
% Input:
%     - input_annot:
%       Your parcellation annot file
%     - output_annot:
%       Adjuested parcellation annot file output
%     - cortex_annot:
%       annot file generated by mris_label2annot
%     - mesh_name:
%       e.g. 'fsaverage'
%
% Example:
% match_medial_wall(input_annot, output_annot, cortex_annot, 'fsaverage')

% Determine the hemishpere
if(contains(input_annot,'lh.'))
    hemi = 'lh';
elseif(contains(input_annot,'rh.'))
    hemi = 'rh';
else
    error('Unknown hemisphere');
end

% Read input files and find medial wall of both files
[vertices_p, label_p, colortable_p] = read_annotation(input_annot);
[~, label_w] = read_annotation(cortex_annot);
avg_mesh = CBIG_ReadNCAvgMesh(hemi, mesh_name, 'inflated', 'cortex');
mw_p = find(label_p == 65793);
mw_w = find(label_w == 65793);
if isempty(mw_p)
    error('Medial wall not found in parcellation annot file.')
end
if isempty(mw_w)
    error('Medial wall not found in cortex annot file.')
end
cortex_p = find(label_p ~= 65793);
all_index = setdiff(mw_p, mw_w);
neib = avg_mesh.vertexNbors;

% Adjust the medial wall of the input annot file
disp('Start adjusting input annot file...');
tic
index = all_index;
label = label_p;
cortex = cortex_p;
while 1
    index_new = [];
    for i = 1:length(index)
        nb = neib(:, index(i));
        mw_nb = setdiff(nb, cortex);
        if length(mw_nb) < length(nb)
            index_new = [index_new; index(i)];
        end
    end
    if isempty(index_new)
        break;
    else
        index = index_new;
    end
    
    label_new = label;
    for i = 1:length(index)
        nb = neib(:, index(i));
        label_n = label(nb);
        label_n = setdiff(label_n, 65793);
        [freq, unique_labels]=hist(label_n, unique(label_n));
        [~, freq_idx] = sort(freq, 'descend');
        most_freq_label = unique_labels(freq_idx(1));
        label_new(index(i)) = most_freq_label;
    end
    label = label_new;
    cortex = find(label ~= 65793);
    index = setdiff(find(label == 65793), mw_w);
end

label(mw_w) = 65793;
toc

disp(['Writing output to ' output_annot ' ...']);
write_annotation(output_annot, vertices_p, label, colortable_p);

end