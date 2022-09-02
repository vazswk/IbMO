function rho = f_cal_cost_J_UNIWARD(in_file_name)
C_SPATIAL = double(imread(in_file_name));
C_STRUCT = jpeg_read(in_file_name);
C_COEFFS = C_STRUCT.coef_arrays{1};
C_QUANT = C_STRUCT.quant_tables{1};
sgm = 2^(-6);
%% Get 2D wavelet filters - Daubechies 8
% 1D high pass decomposition filter
hpdf = [-0.0544158422, 0.3128715909, -0.6756307363, 0.5853546837, 0.0158291053, -0.2840155430, -0.0004724846, 0.1287474266, 0.0173693010, -0.0440882539, ...
        -0.0139810279, 0.0087460940, 0.0048703530, -0.0003917404, -0.0006754494, -0.0001174768];
% 1D low pass decomposition filter
lpdf = (-1).^(0:numel(hpdf)-1).*fliplr(hpdf);

F{1} = lpdf'*hpdf;
F{2} = hpdf'*lpdf;
F{3} = hpdf'*hpdf;
%% Pre-compute impact in spatial domain when a jpeg coefficient is changed by 1
spatialImpact = cell(8, 8);
for bcoord_i=1:8
    for bcoord_j=1:8
        testCoeffs = zeros(8, 8);
        testCoeffs(bcoord_i, bcoord_j) = 1;
        spatialImpact{bcoord_i, bcoord_j} = idct2(testCoeffs)*C_QUANT(bcoord_i, bcoord_j);  %修改每一个DCT系数之后，计算其对应的8*8空域受到的影响
    end
end

%% Pre compute impact on wavelet coefficients when a jpeg coefficient is changed by 1
waveletImpact = cell(numel(F), 8, 8); %每个元素对应23*23的矩阵
for Findex = 1:numel(F)
    for bcoord_i=1:8
        for bcoord_j=1:8
            waveletImpact{Findex, bcoord_i, bcoord_j} = imfilter(spatialImpact{bcoord_i, bcoord_j}, F{Findex}, 'full');
        end
    end
end
toc
%% Create reference cover wavelet coefficients (LH, HL, HH)
% Embedding should minimize their relative change. Computation uses mirror-padding
padSize = max([size(F{1})'; size(F{2})']);
C_SPATIAL_PADDED = padarray(C_SPATIAL, [padSize padSize], 'symmetric'); % pad image
RC = cell(size(F));  %计算空域上的残差：512*680 ——> 544*712
for i=1:numel(F)
    RC{i} = imfilter(C_SPATIAL_PADDED, F{i});
end
[k, l] = size(C_COEFFS);
rho = zeros(k, l);
tempXi = cell(3, 1);
%% Computation of costs
for row = 1:k
    for col = 1:l
        modRow = mod(row-1, 8)+1; % 1:8
        modCol = mod(col-1, 8)+1; % 1:8       
        %subRows，subCols 在每个8*8块内的结果都是保持一致
        subRows = row-modRow+(padSize-7+1):row-modRow+(8+8+padSize); % 10-32
        subCols = col-modCol+(padSize-7+1):col-modCol+(8+8+padSize); % 10-32
        for fIndex = 1:3
            % compute residual
            RC_sub = RC{fIndex}(subRows, subCols);   % 544 *544  
            % get differences between cover and stego
            wavCoverStegoDiff = waveletImpact{fIndex, modRow, modCol};
            % compute suitability
            tempXi{fIndex} = abs(wavCoverStegoDiff) ./ (abs(RC_sub)+sgm);           
        end
        rhoTemp = tempXi{1} + tempXi{2} + tempXi{3};
        rho(row, col) = sum(rhoTemp(:));
    end
end
end




