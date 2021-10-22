%Cette fonction permet de créer deux matrices 
%Une matrice ligne lig et une matrice colone "col"
%Chaque matrice va contenir respectivement indices ligne et colonnes%Ces indices vont aidé a faire le scan zig zag pour un sous bloc 8x8.
 

function [col,lig]=init_indices_zigzag(dim_bloc)
col = ones([1 (dim_bloc * dim_bloc)]);
lig = ones([1 (dim_bloc * dim_bloc)]);
lig(1) = 1;
k=2;
r=1;
 
for x=3:2:dim_bloc
    for j=1:x
        lig(k) = j;
        k = k + 1;
    end
    for j=x-1:-1:1
        lig(k) = j;
        k = k + 1;
    end
    for j=1:x-1
        col(r) = j;
        r = r + 1;
    end
    for j=x-2:-1:1
        col(r) = j;
        r = r + 1;
    end 
    if(x == 7 )
        x = x+1;
        for j=1:x
            lig(k) = j;
            k = k + 1;
            col(r) = j;
            r = r + 1;
        end
        for j=x-1:-1:1
            col(r) = j;
            r = r + 1;
        end
        for z=2:2:x
            for j=x:-1:z+1
                lig(k) = j;
                k = k + 1;
            end
            for j=z:x
                lig(k) = j;
                k = k + 1;
            end
            for j=z:x
                col(r) = j;
                r = r + 1;
            end
            if(z ~= dim_bloc)
                for j=x:-1:z+1
                    col(r) = j;
                    r = r + 1;
                end
            end
        end
    end
end
 

