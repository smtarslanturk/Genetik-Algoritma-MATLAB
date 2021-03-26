% Parcacik suru oprimizasyonu ile kareler toplamını mınımıze edelım.

%1-) Baslangıc populasyonu olusturalım:
swarm = unifrnd(as,us,[ssize,d]);
swarm1 = swarm; %Baslangic Surusu.

%Hızları Olustur:
velocity = zeros(ssize,d); %Her eleman (gen) için.

%2-) Amac fonksiyonu hesaplayalım:
obj = zeros(ssize,1);  %Her parcacik (Kromozom) icin. 
for i=1:ssize
    obj(i,1) = sum(swarm(i,:).^2);
end
obj1 = obj; %Baslangic amac fonksiyonu.

%3-) En iyileri bul:
%Parçacıklar (satırlar) için:
pbestpos = swarm;  %Parcacik en iyi posizyonları.
pbestval = obj; %Parcacık en iyi degerileri. 

%Sürü (populasyon) için:
sbestval = min(obj);  %Sürü en iyi degeri. 
idx = find(obj == sbestval); %En iyi degerin indexini bulduk. 
sbestpos = swarm(idx,:);  %Sürünün en iyi pozisyonu (parçacığı).
sbestval1 = sbestval; % Surunun baslangic en iyi degeri.
sbestpos1 = sbestpos; %Surunun baslangic en iyi pozisyonu.

iteration = 1;
objit = sbestval;

while(iteration<50)
%4-) Hiz Güncellemesi.
r1 = unifrnd(0,1); %rastsal 1
r2 = unifrnd(0,1); %rastsal 2
for i=1:ssize
    velocity(i,:) = w*swarm(i,:)+c1*r1*(pbestpos(i,:)-swarm(i,:))+ c2*r2*(sbestpos-swarm(i,:));
    % eylemsizlik+sürü en iyisi+parcacık en iyisi.
    % w=eylemsizlik katsayısı. 
end

%Hiz Kontrolu:
vmax = (us-as)/2; %max. gidilebielcek hız. Yoksa suruyu asabılır.
for i=1:ssize
    for j=1:d
        if(velocity(i,j)>vmax)
            velocity(i,j)=vmax;
        elseif(velocity<-vmax)
            velocity=-vmax;
        end
    end
end

% 5-) Pozisyon Güncelle: 

swarm = swarm + velocity;

%Pozisyon sınırlaması:
for i=1:ssize
   for j=1: d
       if (swarm(i,j) > us)
           swarm(i,j)=us;
       elseif (swarm(i,j)<as)
           swarm(i,j)=as;
       end
   end
end

%Amac Fonksiyonunu Hesaplayalım:
for i=1 : ssize
   obj(i,1) = sum(swarm(i,:).^2); 
end

%Parçacık En İyisini Güncelle: 
for i=1:ssize
   if(pbestval(i,1)>obj(i,1))
       pbestval(i,1) = obj(i,1);  %Paracağın suana kadarki en iyi degerleri.
       pbestpos(i,:) = swarm(i,:); %Parcacigin suana kadarki en iyi pozisyonları.
   end
end

%Surunun En İyisini Guncelle:
if(min(obj)<sbestval)
    sbestval = min(obj);  %Surunun suana kadarki en iyi degeri.
    idx = find(sbestval==obj); %Surunun suana kadarki en iyi pozisyonunun indexi.
    sbestpos = swarm(idx,:); %Surunun suana kadarki en iyi pozisyonu. 
end
iteration = iteration +1;
objit(iteration) = sbestval;  %İterasyonlardaki en iyi degerleri gorunuyoruz.
end

objit = objit';
plot(sbestval1,'--or'); hold on;
plot(objit, 'Linewidth',2); grid on;
title('İTERASYONLARA GORE SURU EN İYİ DEGERLERİ');
xlabel('iterasyon');
ylabel('sbestval');
legend('Baslangic Sbestval','İterasyonlara Göre Sbestval');
% ginput(4); 

disp('Başlangıc Sürüsü:');
disp(swarm1);
disp('Başlangic Amaç Fonksiyonu ');
disp(obj1);
disp('Surunun Baslangic En İyi Pozisyonu ');
disp(sbestpos1);
disp('Surunun Baslangic En İyi Degeri ');
disp(sbestval1);

disp('Bitis Sürüsü:');
disp(pbestpos);
disp('Bitis Amaç Fonksiyonu ');
disp(pbestval);
disp('Surunun Bitis En İyi Pozisyonu ');
disp(sbestpos);
disp('Surunun Bitis En İyi Degeri ');
disp(sbestval);







