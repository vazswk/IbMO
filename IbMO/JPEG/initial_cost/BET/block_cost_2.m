function  block_cost  = block_cost_2(entropy)
%BLOCK_COST 此处显示有关此函数的摘要
%% 获取每个DCT块的熵
entropy2 = im2col(entropy,[8 8],'distinct');
entropy_block = sum(abs(entropy2))/64;
% J = ones(64,1)*J2;
% J = col2im(J,[8 8], [512 512], 'distinct'); 

%% 将DCT块的熵转化为修改率
L = length(entropy_block);
temp = zeros(size(entropy_block));
table = generate_Table;
for num = 1:L
    [~,a_idx] = min(abs(table(2,:) - entropy_block(num)));
    temp(num) = table(1,a_idx);
end
tempCost = log(1./temp -2);

J = ones(64,1)*tempCost;
block_cost = col2im(J,[8 8], [512 512], 'distinct'); 
% 
% kernel = fspecial('gaussian',[3 3],1);
% tempCost = conv2(tempCost, kernel, 'same');

end

