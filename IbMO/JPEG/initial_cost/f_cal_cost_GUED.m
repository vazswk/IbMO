function cost = f_cal_cost_GUED(in_file_name,p,q)
    avar_wavelet_Impact =  Cal_on_wavelet(in_file_name);
    avar_wavelet_Impact(1,1) = 0.5*(avar_wavelet_Impact(2,1) + avar_wavelet_Impact(1,2));  
    avar_wavelet_Impact = avar_wavelet_Impact.^p;                   
    avar_wavelet_Impact_matrix = repmat(avar_wavelet_Impact,[64 64]);                   
    q_matrix = avar_wavelet_Impact_matrix;    
    
    cost_block = block_energy(in_file_name,12);
    [block_w, block_h] = size(cost_block);
    sqr_complex_block = (cost_block).^q;
    J2 = sqr_complex_block (:);
    J = ones(64,1)*J2';
    J = col2im(J,[8 8], [block_w*8 block_h*8], 'distinct'); 
    cost = q_matrix .* J;
end
       
    
    
    
    