% Chargement de la matrice image monochrome sur Matlab qui seras sous format
% entieruint8% et la convertir en double pour les calcul
clear
img_originale = double(imread('original.jpg'));
 
% Si Image a un espace de couleur RVB ou autre que monochrome,elle doit étre convertie img_originale = rgb2gray(img_originale);
dim_bloc = 8;%dimension 8x8 des % sous blocs
init_jpeg;% Déclaration et initialisation des variables nécéssaires (voir:init_jpeg.m)
 
%Décodage et décompression (Voir: codage_jpeg.m)
codage_jpeg
%Décodage et décompression (Voir: decodage_jpeg.m) 
decodage_jpeg

%Affichage de l'image originale,de sa DCT,et de l'image décompressé.
figure(1)
subplot(1,3,1)
imshow(uint8(img_originale))
title('Image Originale'); 
subplot(1,3,2)
imshow(jpeg)
title('DCT');
subplot(1,3,3)
imshow(uint8(img_decompresse))
title('Image décompressée');
figure(2)
subplot(2,2,1)
imshow(uint8(img_originale(112:120,120:128)))
title('Sous bloc de l''mage Originale');
subplot(2,2,2)
imshow(uint8(img_decompresse(112:120,120:128)))
title('Sous bloc de l''mage Compressée');
 
%Evalutation du Taux de compression
 
for i=1:8:m
    for j=1:8:n
        eval( sprintf(['taille_img_compresser = taille_img_compresser +' ...
            'numel(hcode_%d_%d);'],i ,j));
    end 
end
 
taille_originale = dim_img;
taille_img_compresser
taux_compression = taille_originale / taille_img_compresser;
 
%Evaluation de l'erreur quandratique moyenne EQM
 
somme=0;
for i=1:m
    for j=1:n
        somme=somme + ((img_originale(i,j) - img_decompresse(i,j))^2);
    end 
end
 
EQM=somme/(m*n);
 
%Calcul de la valeur créte du rapport signal sur bruit Peak to noise ratio PSNR
 
bit=8;
PSNR=10*log10(((2^bit-1)^2)/EQM);
 
%Calcul des bits par pixel Bpp.
bpp = taille_img_compresser / dim_img ;% Fichier image compressé / nombre de pixels;
 
