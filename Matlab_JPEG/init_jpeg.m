
%Déclaration des variables et initialisation des constantes
jpeg = ones(size(img_originale));% Matrice JPEG qui va contenir l'image compressée
jpeg_deco = ones(size(jpeg));% Matrice qui va contenir l'image décompressé
offset = ones(dim_bloc,dim_bloc)*128;%Matrice 8x8 pour "Level Shifting".
DCT = dctmtx(dim_bloc);% Matrice C pour le calcul de F
 
% récupération des dimensions de l'image.
 
[m,n] = size(img_originale);
dim_img = m*n;%Matrice ou table de quantification Q (Standard JPEG)
 
quantizer =...
[...
 
16 11 10 16 24 40 51 61;...
 
12 12 14 19 26 58 60 55;...
 
14 13 16 24 40 57 69 56;...
 
14 17 22 29 51 87 80 62;...
 
18 22 37 56 68 109 103 77;...
 
24 35 55 64 81 104 113 92;...
 
49 64 78 87 103 121 120 101;...
 
72 92 95 98 112 100 103 99 ...

];
 
%Vecteur du scan Zigzag
 
zigzag = ones([1 dim_img]);
 
%Fonction de récupération des indices du scan zigzag (voir init_indices_zigzag.m)
 [col lig] = init_indices_zigzag(dim_bloc);
%Vecteur du codage/décodage RLE et codage/décodage Huffman
rle = [];
rle_deco = [];
huff_deco = [];
 
% Constantes utiles
taux_compression = 0;
taille_img_compresser = 0;
dec_l = 0;
dec_c = 0;
redondance = 0;
col_rle_p = 1;
k = 1;
z =1;
d=0;