%Boucle général qui va parcourir l'image en sous bloc 8x8
for i=1:dim_bloc:m
    dec_l = i-1;%Décalage vertical des sous blocs
    for j=1:dim_bloc:n
        dec_c = j-1;%Décalage vertical des sous blocs
        jpeg(i:i+7,j:j+7) = img_originale(i:i+7,j:j+7) - offset; % Effectuer le "LevelShifting".
        jpeg(i:i+7,j:j+7) = DCT * jpeg(i:i+7,j:j+7) * DCT';% Appliquer DCT(cf.[7]).
        jpeg(i:i+7,j:j+7) = jpeg(i:i+7,j:j+7) ./ quantizer;% Division par la tableQ.
        jpeg(i:i+7,j:j+7) = round(jpeg(i:i+7,j:j+7));% Arrondir à l'entierle plus prés.
        for q =1:64
            zigzag(k) = jpeg(lig(q)+dec_l,col(q)+dec_c);% Effectuer un scanZigZag.
            k = k + 1;
        end
        d = k - 64;
        q = 1;
        while(q <= 64)% Boucle While qui effectue un codage RLC sur chaquesous bloc
            if (d < dim_img) && (zigzag(d) ~= zigzag(d+1))
                rle(z) = zigzag(d);
                d = d + 1;
                q = q + 1;
                z = z + 1;
            elseif (d < dim_img) && (zigzag(d) == zigzag(d+1)) &&(zigzag(d+1) ~= zigzag(d+2))
                rle(z) = zigzag(d);
                rle(z+1) = zigzag(d+1);
                d = d + 2;
                q = q + 2;
                z = z + 2;
            elseif (d < dim_img) && (zigzag(d) == zigzag(d+1)) &&(zigzag(d+1) == zigzag(d+2))&& (zigzag(d+2) ~= zigzag(d+3))
                rle(z) = zigzag(d);
                rle(z+1) = zigzag(d+1);
                rle(z+2) = zigzag(d+2);
                d = d + 3;
                q = q + 3;
                z = z + 3;
            elseif (d < dim_img) && (zigzag(d) == zigzag(d+1)) &&(zigzag(d+1) == zigzag(d+2))&& (zigzag(d+2) == zigzag(d+3))
                redondance = 4;
                rle(z) = 257;
                rle(z+1) = redondance;
                rle(z+2) = zigzag(d);d = d + 3;q = q + 4;
                while (q <= 64) && (d < dim_img) && (zigzag(d) == zigzag(d+1))
                    redondance = redondance + 1;
                    q = q + 1;
                    d = d + 1;
                end
                rle(z+1) = redondance;
                d = d + 1;
                z = z + 3;
            end 
            if(q == 64)
                q = q+1;
            end 
        end
        % Début du codage Entropique de Huffman.
        col_rle = z-1;%Extraction des symboles uniques présent dans le vecteur
        %RLC.
        symboles = unique(rle(col_rle_p:col_rle));nbr_symboles = numel(symboles);
        taille_block = numel(rle(col_rle_p:col_rle));
        %Calcul des probabilités de chaque symboles.
        table_p = ones(1,nbr_symboles);
        for q = 1:nbr_symboles
            itter = 0;
            for r = col_rle_p:col_rle
                if(rle(r) == symboles(q))
                    itter = itter + 1;
                end
            end
            table_p(q) = itter / taille_block;
        end
        %Dressage de l'arbre de huffman et codage de chaque
        %symbole de chaque sous bloc.
        eval( sprintf('dico_%d_%d = huffmandict(symboles,table_p);', i ,j));
        eval( sprintf('hcode_%d_%d = huffmanenco(rle(col_rle_p:col_rle),dico_%d_%d);', i ,j,i,j));
        col_rle_p = col_rle+1;
    end
end
 
