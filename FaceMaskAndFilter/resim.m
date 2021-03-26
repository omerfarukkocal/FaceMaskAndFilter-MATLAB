function resimCikis = resim(resimGiris, resimEkle, Konum)
% 'resim' iki resim ceker ve bunlari seffaflik olmadan ust uste koyar
% resimGiris - Orijinal goruntu (RGB veya gri tonlamali)
% resimEkle - En ustteki goruntu (RGB veya gri tonlamali)
% konum - Ikinci goruntunun birinci goruntunun ustune ciktigi
% x ve y konumu - [x y], burada x ve y negatif olabilir (kirpilacak)
% resimCikis - Cikti goruntusu (orijinal goruntu resimGiris ile ayni boyutta)
% Goruntunun ustteki bolgesi orijinal goruntunun disindaysa
% fazla kisimlari kirpar
% Ornek
% resimGiris = imread ('x.png');
% resimEkle = imread ('y.jpg');
% resimCikis = imoverlay (resimGiris, resimEkle, [30-80]);
% imshow (resimCikis)

resimCikis = resimGiris;
resimCikis(max(Konum(:,1), 1) : min(Konum(:,1)+size(resimEkle, 1)-1, size(resimGiris,1)),...
    max(Konum(:,2), 1) : min(Konum(:,2)+size(resimEkle, 2)-1, size(resimGiris,2)),...
    :) = ...
    resimEkle(max(2-Konum(:,1), 1) : min(size(resimGiris,1)-Konum(:,1)+1, size(resimEkle,1)),...
    max(2-Konum(:,2), 1) : min(size(resimGiris,2)-Konum(:,2)+1, size(resimEkle,2)),...
    :);
% Ustteki goruntunun arkaplani seffafsa arka plani kaldirma
resimCikis(resimCikis == 255) = resimGiris(resimCikis == 255);
end