%% mian.m
clc;clear all;
currdir = pwd;
input = [currdir '\Cover'];             % input dir for all QFs
output = [currdir '\Stego'];        
rate = 0.4;
dropout_ratio = 0.5;
block_size = 3;
Alpha = 5; 

flist = dir([input '\*.pgm']);
flen = length(flist);
fprintf('%s%d\n', 'the num of the files: ',flen);
for i=1 :length(flist) 
   fprintf('%d%s\n',i, ['      processing image: ' flist(i).name]);
   in_file_name = [input '\1013.pgm'];
   stego_name = [output '\' flist(i).name];
   cover = double(imread(in_file_name));  
%% initial cost
tic
   % MiPOD
   decide = MiPOD(cover,rate);
%   % HiLL
%    decide = f_cal_cost_Hill(cover);
   
%% non-additive update  
   [stego_ori, stego, pChangeP1_ori, pChangeM1_ori] = non_additve_emb_4_1(cover, decide, rate, block_size, Alpha);   % IbMO 
%    [stego_ori, stego, pChangeP1_ori, pChangeM1_ori] = non_additve_emb_4_2(cover,decide, rate, block_size, Alpha, dropout_ratio);  % IbMO-fast
   imwrite(stego,stego_name,'pgm');
toc
end   

