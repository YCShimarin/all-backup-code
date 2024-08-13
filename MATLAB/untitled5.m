% Sinyal sin parameters 
f = 2; % Frekuensi sinyal sin (contoh)
fs = 25;
ts = 1/fs;
t = 0:ts:1; % Rentang waktu

% Generate sinyal sin
x = sin(2 * pi * f * t);


order = 1; % Ganti dengan orde yang sesuai
a = [0.2]; % Ganti dengan koefisien yang sesuai

% Inisialisasi sinyal keluaran dan array y_prev
y = zeros(1, length(x));
y_prev = zeros(1, order);

% Implementasi filter rekrusif
for n = 1:length(x)
    y(n) = x(n);
    for i = 1:order
        if n > i
            y(n) = y(n) - a(i) * y_prev(i);
        end
    end
    
    % Update state variables
    y_prev(2:end) = y_prev(1:end-1);
    y_prev(1) = y(n);
end

% Hasil sinyal keluaran y
figure;
stem(y);
