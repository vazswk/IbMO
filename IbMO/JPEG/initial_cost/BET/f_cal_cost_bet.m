function JPEG_cost = f_cal_cost_bet(in_file_name, q_tab, num_nzac)
spatial_cover = double(imread(in_file_name));
[img_w, img_h] = size(spatial_cover);

quant_matrix = repmat(q_tab,[img_w/8 img_h/8]);
entropy = calc_entropy(spatial_cover, 2*num_nzac);
bc = block_cost(entropy);
JPEG_cost = (bc) .* (quant_matrix);
end