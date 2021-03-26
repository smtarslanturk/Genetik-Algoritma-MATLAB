function [net, ye, yv, MAPE, R2] = neuralnetwork(input, target, trainingRate, n1, n2, lrate)
%Fonksiyon yazmak için yukar?daki gibi yaz?m yap?l?r. Soldakiler cikti
%sagdakiler ise girdilerdir. Koseli parantezden sonra fonk. ad? yaz?l?r.
%Fonksiyon adi ile dosya ad? ayni olmal?d?r. 
%Her fonk. end  ile biter.

%input = nerural network girdisi.
%target = neural network ciktisi X. Gerceklesen degerler OK. 

% Girdiyi training ve validation diye ay?r. 
% Ciktilari training validation diye ayir. 
% NN olustur. 
% Training girdileri ve ç?kt?lar? kullanarak agi egit. 
%  ---> c?kt?: Egitilmis NN olacak. 

% Validation icin kullan?lan girdi c?kt?lar? aga ver. 
% Egitilmis agdan c?kan c?kt?lar ?le gercekler? kars?last?r. 

%Veri sayisini bul:
noofdata = size(input,1); %Veri sayisi blundu. 1: satir sayisi

%   %70 training, %30 validation.
ntd = round(noofdata*trainingRate); %ntd: number of training data. 
%round: Tam say? olmas? amac?yla yuvarlar. 
%TrainingRate 0-1 aras?nda olmal?d?r.

xt = input(1:ntd,:);  %Training girdisi.
xv = input(ntd+1:end,:); %Validation girdisi.

yt = target(1:ntd); %Trainig için gerçeklesen hedef.
yv = target(ntd+1:end); %Validation için gerceklesen hedef.
%yt, yv degerleri CNN c?kt?s? ile kars?last?racagiz. 
%Yukar?da sutün indexi belirtemdik zaten tek sutün. 

% Verilerin sutunlarda olmasi icin trannspozlarini aliyoruz. 
% Matlab verileri otomatik olarak sutunlarda alir.
xt = xt';
xv = xv';
yt = yt';
yv = yv';

% Girdi verilerini normalize et;
% xtn; training icin nirmalize veri
% xvn; validation icin normalize veri

xtn = mapminmax(xt); %-1 1 arasinda normalize eder. 
xvn = mapminmax(xv); 

%Sigmoid fonk. Ciktilari 0-1 arasi degisir. 
%Training output normalize et. 
% ytn: Normalize edilmi? target. 
% ytn = mapminmax(yt);
[ytn, ps] = mapminmax(yt);%ps= Normalizasyonun nasil yapildigi bilgisini tutar.

% BU KISMA KADAR VERILER AYARLANDI. AGI OLUSTURALIM. 
% Ag objesi olusturulur. Agdaki bilgileri tutar. 
% newff: new fead forward neural network. 
% newff(girdi, cikti, neron, transfer fonks., egitim algoritmasi)
% tf: default sigmoid gelir. 0-1
%n1: 1. gizli katmandaki neron sayisi.
%n2: 2. gizli katmandaki neron sayisi.
%lrate: learining rate. 
net = newff(xtn, ytn, [n1, n2],{},'trainlm');
net.trainParam.lr=lrate; %learning rate.
net.trainParam.epochs = 10000; %max iterasayon sayisi.
net.trainParam.goal = 1e-20; %10000 epoch doldurmaya gerek kalmadan dur. 
net.trainParam.show = NaN; %Sonuclari ne aralikla gor. NaN: Bitince.

% AGI EGIT: 
%net agini egitip uzerine yazacaz. 
%train(hangis agi egitecen, hangi veri girsin, hangi veri ciksin);
net=train(net, xtn, ytn);

%validation girdilerini gir, normalize val. ciktilarini elde et. 
%yen: normalize haldeki validation ciktisi.
yen = sim(net, xvn); %net agini sumule et girdi olarak xvn al cikti yen. 
 
% yvn: normalize validation ciktisi yok.
% yv: gercek validation target degerleri var.
% yen: normalize halde validation ciktilari. Bu denormalize edilecek.
% ye: normalize olmayan validation ciktisi olsun.
ye = mapminmax('reverse', yen, ps); %ye degerini denormalize ettik. ps bilgilerine gore. 

ye = ye';
yv = yv'; 

% Performans Kontrolunu Yapalim: 
% MPE: sum((ye-yv)/ye); Mean percentage error
% MAPE: mean(abs(ye-yv)/ye); Mean absolute percentage error. - ler toplamda birbirini yok etmez. 
MAPE = mean((abs(ye-yv))./yv); %Sonuc kacsa o kadar 
%MAPE hata var. Sifira yaklasmasi istenir.
% RMSE: root(mean((ye-yv)^2)); Root Mean Square Error. Kucuk hatalari daha net gorebiliyoruz.
% R2: Korelasyon olcutudur. SSerror: hatanin sapmasi., SStotal: gerceklesenin sapmasi.
% R2 = 1-SSerror/SStotal;  

SStotal = sum((yv-mean(yv)).^2);
SSerror = sum((ye-yv).^2);
R2 = 1-SSerror/SStotal; %[0,1] arasinda deger alir. 
%1 e yaklasmasi istenir. 






end

