% Nilai X

% Range Waktu

% X array
x = [1,5,2,7,2,5,6,7,9];
h = [1,2];

n = 0:length(x)-1; 
n2 = 0:length(h)-1;

% buat vektor zeros
xn = zeros(size(n));
hn = zeros(size(n2));
% Nomor 1 Kode
for i = 1:length(x)
    index = n(i) + 1; % ShiftZthe index to start from 0
    if index >= 1 && index <= length(x)
        xn(i) = x(index);
    end
end

% Nomor 2 Kode
for i = 1:length(n2)
    index = n(i) + 1; % Shift the index to start from 0
    if index >= 1 && index <= length(h)
        hn(i) = h(index);
    end
end

yn = conv(xn,hn);

% Display the result
disp(xn);
disp(hn);
disp(yn);

figure;
subplot(3, 1, 1)
stem(n, xn, 'LineWidth',2,'Color',[0 0 0])
title('xn(n)')
xlabel('n')
ylabel('xn(n)')

subplot(3, 1, 2)
stem(n2, hn,'LineWidth', 2,'Color','r');
title('hn(n)')
xlabel('n')
ylabel('hn(n)')

subplot(3, 1, 3)
stem(yn,'LineWidth', 2)
title('yn(n)')
xlabel('n')
ylabel('yn(n)')

