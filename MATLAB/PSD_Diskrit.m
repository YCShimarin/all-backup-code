%2010952054 - Jimmy Nelson
%2110952028 - Mutiara Ali
%2110952001 - Muhammad Reval
%2110953005 - Muhammad Zaky Kurnia


% Nilai X
x1 = 5;
x2 = 2;
x3 = 2;
x4 = 2;

% Range Waktu
n = -5:10

% X array
x = [x1, x2, x3, x4];

% buat vektor zeros
[xs, y1, y2, y3, y4, y5] = deal(zeros(size(n)));

% Nomor 1 Kode
for i = 1:length(n)
    index = n(i) + 1; % Shift the index to start from 0
    if index >= 1 && index <= length(x)
        xs(i) = x(index);
    end
end

% Nomor 2 Kode
for i = 1:length(n)
    index = n(i) + 1 - x(1); % Shift the index to start from 0
    if index >= 1 && index <= length(x)
        y1(i) = x(index);
    end
end

% Nomor 3 Kode
for i = 1:length(n)
    index = x(2) + 1 - n(i); % Shift the index to start from 0
    if index >= 1 && index <= length(x)
        y2(i) = x(index);
    end
end

% Nomor 4 Kode
for i = 1:length(n)
    index = n(i) + 1 + x(3); % Shift the index to start from 0
    if index >= 1 && index <= length(x)
        y3(i) = x(index);
    end
end

% Nomor 5 Kode
for i = 1:length(n)
    a = x(2);
    index = a * n(i) + 1; % Shift the index to start from 0
    if index >= 1 && index <= length(x)
        y4(i) = x(index);
    end
end

% Nomor 6 Kode
y5 = y1 + y2;

% Nomor  Kode
y6 = y3 .* y5;

% Display the result
disp(xs);
disp(y1);
disp(y2);
disp(y3);
disp(y4);
disp(y5);
disp(y6);

% Plot hasil
figure;
stem(n, xs)
title('xs(n)')
xlabel('n')
ylabel('xs(n)')

figure;
subplot(3, 2, 1)
stem(n, y1)
title('y1(n)')
xlabel('n')
ylabel('y1(n)')

subplot(3, 2, 2)
stem(n, y2)
title('y2(n)')
xlabel('n')
ylabel('y2(n)')

subplot(3, 2, 3)
stem(n, y3)
title('y3(n)')
xlabel('n')
ylabel('y3(n)')

subplot(3, 2, 4)
stem(n, y4)
title('y4(n)')
xlabel('n')
ylabel('y4(n)')

subplot(3, 2, 5)
stem(n, y5)
title('y5(n)')
xlabel('n')
ylabel('y5(n)')

subplot(3, 2, 6)
stem(n, y6)
title('y6(n)')
xlabel('n')
ylabel('y6(n)')







