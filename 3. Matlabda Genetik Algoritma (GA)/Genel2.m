%İyileşmeler oldugu zaman en iyisini alacak fonk. Yazalım. 

% Başlangıç Populasyonunu Yaratalım.
population = unifrnd(as,us,[psize d]); %Random uniform sürekli.

iteration = 1; 
eniyideger = 1000000; 

% Amaç Fonksiyonunu Hesaplatalım.
% obj = sum(population.^2); Bu sadece bir satırın işlemini yapar. 
%Bizim populasyonumuz psizexd boyutunda.

obj=zeros(psize,1); %Amaç fonk. sadece sonucları tutacagi icin sutun matrısı.

for i=1: psize
    obj(i) = sum(population(i,:).^2);
end

ilkobj=obj;
eniyibir = min(obj);

while(iteration<500)

% population=arapop;
for i=1: psize
    obj(i) = sum(population(i,:).^2);
end


if(min(obj)<eniyideger)
    eniyideger = min(obj);
    idx = find(obj==eniyideger);  %hangi satır en iyi degeri veriyor. 
    eniyicozum = population(idx,:); %En iyi cozum. 
end

obj=1./obj; %min. icin ters cevrildi.
sumobj = sum(obj); %amac fonk. toplamları.
probs = obj/sumobj; %olasılık.

%Kümülatif (Birikimli) Olasılıkları Hesaplayalım.
cprobs = probs;
for i=2:psize
    cprobs(i)=cprobs(i)+cprobs(i-1);
end

rs= unifrnd(0,1,[psize 1]); %Birikimli olasılık ile karsıalstırılacak.
arapop = population;

for i=1:psize
    idx = find(rs(i)<cprobs,1); %Birikimli oalsılığın rsde kuvuk oldugu ilk degeri bul.
    arapop(i,:) =population(idx,:);
end

pairs = randperm(psize);

for i=1:psize/2
    parent1idx = pairs(2*i-1);
    parent2idx = pairs(2*i);
    parent1 = arapop(parent1idx,:);
    parent2 = arapop(parent2idx,:);
    
    rs =unifrnd(0,1);
% olusturulan rastsal sayı ıle caprazlanma olasılıgı karsılastırılır. 
%     dummy = parent1;
    if(rs<pcross)
        cpoint = unidrnd(d-1); %çaprazlama noktası secimi.
        dummy = parent1(1,cpoint+1:end);
        parent1(cpoint+1:end) = parent2(cpoint+1:end);
        parent2(cpoint+1:end) = dummy;
        arapop(parent1idx,:) = parent1;
        arapop(parent2idx,:) = parent2; 
    end
end 

%Mutasyon Fonksiyonu
%Mutasyon gen basına yapılmaktadır. 

rsMutasyon = unifrnd(0,1,[psize d]);

for i=1:psize
    for j=1:d
        if rsMutasyon(i,j)<pmutation
            rsMutasyon2 = unifrnd(0,1);
            arapop(i,j) = arapop(i,j)+rsMutasyon2*delta*(us-as);
        end
    end
end

iteration = iteration+1; 
end

% objSon=zeros(psize,1);
% for i=1: psize
%     objSon(i) = sum(arapop(i,:).^2);
% end

eniyison = min(obj);


disp('Başlangıc Populasyonu:');
disp(population);
disp('1. Amaç Fonksiyonu ');
disp(ilkobj);
disp('Populasyonun Son Hali:');
disp(arapop);
disp('Son Amaç Fonksiyonu: ');
disp(obj);
disp('En iyi deger: ');
disp(eniyison); 






