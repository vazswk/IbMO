function cost = f_cal_cost_Hill(cover)
%%Get filter
HF1=[-1,2,-1;2,-4,2;-1,2,-1]; % HIgh
H2 = fspecial('average',[3 3]); % Low
%% Get cost
cover=double(cover);
sizeCover=size(cover);
padsize=max(size(HF1));
coverPadded = padarray(cover, [padsize padsize], 'symmetric');% add padding
R1 = conv2(coverPadded,HF1, 'same');%mirror-padded convolution
W1 = conv2(abs(R1),H2,'same');
if mod(size(HF1, 1), 2) == 0, W1= circshift(W1, [1, 0]); end;
if mod(size(HF1, 2), 2) == 0, W1 = circshift(W1, [0, 1]); end;
W1 = W1(((size(W1, 1)-sizeCover(1))/2)+1:end-((size(W1, 1)-sizeCover(1))/2), ((size(W1, 2)-sizeCover(2))/2)+1:end-((size(W1, 2)-sizeCover(2))/2));
cost =1./(W1+10^(-10));  %10^(-10) 设定rho的上限，防止溢出  :但是由于后面均匀滤波导致代价值出现成块的过大

HW =  fspecial('average',[15 15]);
cost = imfilter(cost, HW ,'symmetric','same');   
