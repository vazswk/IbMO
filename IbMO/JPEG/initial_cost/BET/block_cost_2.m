function  block_cost  = block_cost_2(entropy)
%BLOCK_COST �˴���ʾ�йش˺�����ժҪ
%% ��ȡÿ��DCT�����
entropy2 = im2col(entropy,[8 8],'distinct');
entropy_block = sum(abs(entropy2))/64;
% J = ones(64,1)*J2;
% J = col2im(J,[8 8], [512 512], 'distinct'); 

%% ��DCT�����ת��Ϊ�޸���
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

