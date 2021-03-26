%Omer Faruk Kocal - 170418034
%Ceren Zeynep Ozkahraman - 170418008

% Cam degiskenini temizleme
clear cam
% Cam degiskenini tanimlama
cam = webcam();
% Cascade object dedektor olusturma (Gozlerden taniyarak)
dedektor = vision.CascadeObjectDetector('EyePairBig');
% Baslatmak icin bir frame yakalama
cerceve = snapshot(cam);
boyut = size(cerceve);
% Yuze yerlestirilecek sapkaObjesi ve sakalObjesi nesnelerini tanimlama
sapkaObjesi = imread('gorsel/ozilsapka.jpg');
sakalObjesi = imread('gorsel/biyik.jpg');
% Video oynatma nesnesini olusturma
videoOynatici = vision.VideoPlayer('Position', [200 200 [boyut(2), boyut(1)]+30]);
% Her framedeki yuz algilanacak ve yuzun uzerine nesneler yerlestirilecek
% Anlik kamera kaydi yakalama dongusu
calisma = true;
cerceveMiktari = 0;
% Durdurulana kadar veya verilen deger kadar frame yakalanacak
while calisma && cerceveMiktari < 1000
    % Her bir karede anlik goruntu alma
    cerceve = snapshot(cam);
    videoCikisi = cerceve;
    % Gozleri tespit etme ve sinir cercevesi alma
    sinir = step(dedektor, cerceve);
    if size(sinir, 1) == 1
        % Gozlerin boyutuna gore nesneleri yeniden boyutlandirma
        sapka = imresize(sapkaObjesi, sinir(:,3)*2/size(sapkaObjesi,1));
        sakal = imresize(sakalObjesi, sinir(:,3)*1.5/size(sakalObjesi,1));
        % sapkaObjesi ve sakalin yuzdeki konumunu ayarlama
        sapkaKonumu = [sinir(:,2) + sinir(:,4) - size(sapka,1) + 1,...
            sinir(:,1) - round(sinir(:,3)/2)];
        sakalKonumu = [sinir(:,2) + 8*sinir(:,4) - size(sakal,1) + 1,...
            sinir(:,1) - round(sinir(:,3)/5)];
        % Goruntuleri frame'e yerlestirmek icin fonksiyon kullanma
        videoCikisi = resim(cerceve, sapka, sapkaKonumu);
        videoCikisi = resim(videoCikisi, sakal, sakalKonumu);
    end
    % Video karesini goruntuleme
    step(videoOynatici, videoCikisi);
    % Frame sayisini arttirma
    cerceveMiktari = cerceveMiktari + 1;
    % Pencerenin kapatilip kapatilmadigini kontrol etme
    calisma = isOpen(videoOynatici);
end
% Degiskenleri guncelle
clear cam
release(videoOynatici);
release(dedektor);