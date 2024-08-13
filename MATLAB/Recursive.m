%Recursive Orde 2 
signal = [1,3,2,4,3,5,4,6,5,7,6,8,7,9];

lowpass_cutoff_frequency = 2; 
b0 = 0.08;
p1 = 0.8;
p2 = 0.2; 

yyy_rec = zeros(1,length(signal))
yyy_rec(1) = signal(1);
yyy_rec(2) = b0*signal(2)+ p1* yyy_rec(1);

for ii = 3:length(signal)
    yyy_rec(ii) = b0*signal(ii) + p1 * yyy_rec(ii-1) + p2*yyy_rec(ii-2);
end

figure;
subplot(2,1,1)
stem(signal)
subplot(2,1,2)
stem(yyy_rec);
xlabel('time');
ylabel('amplitude');
title('Filtered Signal');

