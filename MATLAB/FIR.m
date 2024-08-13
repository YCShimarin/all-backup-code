%FIR 
x = [1,3,2,4,3,5,4,6,5,7,6,8]; 

a1 = 0.2;
a2 = 0.2;
a3 = 0.2;

x_lpf(1) = a1*x(1);
x_lpf(2) = a1*x(2)+a2*x(1);

for ii = 3:length(x)
    x_lpf(ii) = a1*x(ii) + a2*x(ii-1) + a3*x(ii-2);
    
end

figure;
subplot(2,1,1)
stem(x)
subplot(2,1,2)
stem(x_lpf, Color='r');
xlabel('time');
ylabel('amplitude');
title('Filtered Signal');

