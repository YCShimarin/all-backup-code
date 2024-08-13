%Butterworth LPF 
signal = [1,3,2,4,3,5,4,6,5,7,6,8,7,9]

p1 = 0.7;
c1 = -0.75; 

yyy_rec = zeros(1,length(signal))
yyy_rec(1) = signal(1);

for ii = 2:length(signal)
    yyy_rec(ii) = signal(ii) + p1 * yyy_rec(ii-1);
    yyy_lpf(ii) = c1 * (yyy_rec(ii)) + signal(ii);
end

figure;
subplot(2,1,1)
stem(signal)
subplot(2,1,2)
stem(yyy_lpf);
xlabel('time');
ylabel('amplitude');
title('Filtered Signal');

