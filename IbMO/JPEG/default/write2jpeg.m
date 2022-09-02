function write2jpeg(default_gray_jpeg_obj,dct_coefs,filename)
%%%%%%%%%% write to jpeg file %%%%%%%%%%%%
    [img_h img_w] = size(dct_coefs);
    default_gray_jpeg_obj.image_width = img_w;
    default_gray_jpeg_obj.image_height = img_h;
%     dc_adjust = zeros(img_h,img_w);
%     dc_adjust(1:8:end,1:8:end) = 128;
%     default_gray_jpeg_obj.coef_arrays{1} = dct_coefs-dc_adjust;
    default_gray_jpeg_obj.coef_arrays{1} = dct_coefs;
    jpeg_write(default_gray_jpeg_obj,filename);
end
    %%%%%%%%%% write to jpeg file %%%%%%%%%%%%
