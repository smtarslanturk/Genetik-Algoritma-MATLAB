function [iterasyon, cozumeniyi, objeniyi, objit, obj] = tavlamabenzetimiPic( as, us, d, delta, T, sk,Tend)
% Bu ornekte 1 den n e kadar olan sayıların karelerı toplamı mınımıze edılecektır.
% as = alt sınır. Belirtilecek dizinin alt sınırı.
% us = Üst sınır. Belirtileeck dizinin ust sınırıdır. 
% d = matrisin boyutu. Sutun sayısı olarada dusunulebılir. 
%tavlama benzetimi yerel arama yapan bir meta sezgisel algoritmalardan
%birisidir. 

cozum = unifrnd(as,us,[1, d]); %randum sürekli 1xd boyutunda matris olusturuldu.
obj = sum(cozum.^2); %amac fonksıyonunu olusturduk. Bu fonksıyonun degerı mınımıze edilecek.

% karsılastırma yaparak en kucuk degeri komsuluga bakarak elde etmeye calsıyoruz.
% delta degisim miktarı tanımlanmalıdır. (as-us)*%5 ise delta 5.
% surekli olan algoritmalarda komsuluk kullanabilmek icin komsuluk buyuklugu belirtilmelidir.
iterasyon=1;
objit = obj; %en iyi obj degerini burada tutacagiz. 
cozumeniyi = cozum; %1. iterasyonda kendisine esit. 
objeniyi= obj; %1. iterasyonda kendisine es-şit. 

while(T>Tend)
    %Komsuya git:
    degisimMiktari = unifrnd(-(us-as)*delta/2,(us-as)*delta/2,[1 d]);
    komsu = degisimMiktari + cozum;
    objKomsu = sum(komsu.^2);

    %Eğer Geldigim Yer Daha iyiyse onu cozum olarak kabul et.
    if(objKomsu<=obj)
        cozum = komsu;
        obj= objKomsu;
    %Geldigin yer kotu veya esit ise kabull olasılıgı hesapla.
    %pa = probability of acceptance
    else
        de = objKomsu-obj; %varılan nokta da degerın ne kadar kotulestıgı hesaplandı.  
        pa = exp(-de/T); %kabul olasılıgı hesabı yapıldı. e^(-de/T) islemi yapıldı.
        rs = unifrnd(0,1);
        if(pa>rs) %0-1 arasında olusturulan rastsal sayı  
            cozum=komsu;
            obj = objKomsu;
        end
    end

    %Tend: Bitis sicakliği parametresi iterasyon gibi dusunebiliriz. 
    %Bitis sıcaklıgı saglanana kadar algorıtmayı sogutur. 
    %sk: sogutma katsayısı. Yavas yavs sıcaklıgı dusurecegıız.
    %Var olan sıcaklık sk ile carpilacaktir. 

    T=T*sk;
    iterasyon=iterasyon+1;
    
    if(obj<min(objit))
        objit(iterasyon)=obj;
    else
        objit(iterasyon)=objit(iterasyon-1);
    end
    
    if(objit(iterasyon)<objeniyi)
        cozumeniyi=cozum;
        objeniyi=obj;
    end
end

plot(objit);

end

% Sonuclar:
% - Sogutma katsayısı 0-1 arasında arttırıldıgı zaman iterasyon sayısı artmakta ve 
% 0'a daha yakın sonuclar elde edilmekteedir. 
% Tavlama benzetiminde gercek hayatta katıların sıvıya gecırılıp bir anda
% sogutularak katılastırılması islemi baz alınmıstır.




