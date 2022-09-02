%% mian.m
clc;clear all;
currdir = pwd;
indir = [currdir '\Cover_75'];
outdir = [currdir '\stego'];
QF = 75;
dropout_ratio = 0.5;
Beta = 2;
Gamma = 7;
rate = 0.4;
sweeps = 1;
flist = dir([indir '\*.jpg']);
flen = length(flist);
fprintf('%s%d\n', 'the num of the files: ',flen);
for i = 1:flen
   tic 
       fprintf('%d%s\n',i, ['      processing image: ' flist(i).name]);
       in_file_name = [indir '\' flist(i).name];
       stego_name = [ outdir '\' flist(i).name];  
       img = jpeg_read(in_file_name); 
       quan_table = img.quant_tables{1};
       dct_coef = double(img.coef_arrays{1});
       dct_coef2 = dct_coef; 
       dct_coef2(1:8:end,1:8:end) = 0;
       nz_index = find(dct_coef2 ~=0);
       nz_number = length(nz_index);
%% initial cost
%        % J_UNIWARD
%        decide = f_cal_cost_J_UNIWARD(in_file_name);
%        % GUED
%        p = (1.3 - (1.3-1.2)/20*(95-QF))*rate + (0.55 - (0.55 - 0.44)/20*(95-QF));
%        q =(1.3 - (1.3-1.4)/20*(95-QF))*rate + (0.83 - (0.83 - 0.54)/20*(95-QF));
%        decide = f_cal_cost_GUED(in_file_name,p,q);   
       % BET
       decide = f_cal_cost_bet(in_file_name, quan_table, nz_number);
%% non-additive update      
%        [stego_ori, stego, pChangeP1_ori, pChangeM1_ori] = J_non_additive_cost_1(dct_coef, decide, rate, Beta, sweeps);  % IbJM       
%        [stego_ori, stego, pChangeP1_ori, pChangeM1_ori] = J_non_additive_cost_2(dct_coef, decide, quan_table, rate, Gamma, Beta, sweeps);  % IbJM-IbMO
       [stego_ori, stego, pChangeP1_ori, pChangeM1_ori] = J_non_additive_cost_3(dct_coef, decide, quan_table, rate, Gamma, Beta, sweeps,dropout_ratio); %  IbJM-IbMO-fast
       S_struct = img;
       S_struct.coef_arrays{1} = stego;
       jpeg_write (S_struct,stego_name); 

   toc
end


 
 