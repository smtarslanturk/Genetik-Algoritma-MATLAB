% Network tool kullan?l?nac sadece 1 tane gizli katman oluyor veya 
% LR gibi paramtereleri veremedik. Bunda dolay? elle yapaca??z.

%Saf veriyi alalim:
safVeri = xlsread('iris.xlsx');

%Veriyi Karistir: 
r1= randperm(150);
veri=zeros(150,5);

for i=1:150
   r = r1(1,i);
   veri(i,:)= safVeri(r,:);
   i=i+1;
end

% I/O:
input = veri(:,1:4);
target = veri(:,5);

[net, ye, yv, MAPE, R2] = neuralnetwork(input, target, trainingRate, n1, n2, lrate)

