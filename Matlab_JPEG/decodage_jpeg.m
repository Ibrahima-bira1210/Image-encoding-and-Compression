% Décodage Huffman 
for i=1:dim_bloc:m
    for j=1:dim_bloc:n
        eval([ sprintf('huff_deco = [huff_deco huffmandeco(hcode_%d_%d,dico_%d_%d)];', i,j,i ,j)]);
    end 
end

%Décodage RLE 
i = 1;
k = 1;
while(k <= numel(huff_deco))
    if(huff_deco(k) == 257)
        rle_deco(i:(i-1+huff_deco(k+1))) = huff_deco(k+2);
        i = i + huff_deco(k+1);
        k = k +3;
    else
        rle_deco(i) = huff_deco(k);
        i = i +1;
        k = k +1;
    end
end
 k=1;
 
for i=1:dim_bloc:m
    dec_l = i-1;
    for j=1:dim_bloc:n
        dec_c = j-1;
        %Scan zigzag inverse
        for q =1:64
            img_decompresse(lig(q)+dec_l,col(q)+dec_c) = rle_deco(k);
            k = k + 1;
        end
        %quantification inverse + IDCT + Remises des niveaux (Inverse Level Shifting)
        img_decompresse(i:i+7,j:j+7) = img_decompresse(i:i+7,j:j+7) .* quantizer;
        img_decompresse(i:i+7,j:j+7) = DCT' * img_decompresse(i:i+7,j:j+7) * DCT;img_decompresse(i:i+7,j:j+7) = img_decompresse(i:i+7,j:j+7) + offset;
    end
end