function  cost  = block_cost_3(entropy)
%% 将DCT块的熵转化为修改率
L = numel(entropy);
temp = zeros(size(entropy));
table = generate_Table;
for num = 1:L
    [~,a_idx] = min(abs(table(2,:) - entropy(num)));
    temp(num) = table(1,a_idx);
end
cost = log(1./temp -2);

% 
% kernel = fspecial('gaussian',[3 3],1);
% tempCost = conv2(tempCost, kernel, 'same');

end

