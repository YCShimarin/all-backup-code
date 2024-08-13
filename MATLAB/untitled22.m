% Definisikan sinyal masukan (contoh)
x = [1 2 3 4 5];

% Inisialisasi sinyal keluaran
y = zeros(size(x));

% Koefisien filter rekursif
alpha = 1;

% Algoritma filter rekursif
for i = 1:numel(x)
    if i == 1
        y(i) = x(i);
    else
        y(i) = alpha * x(i) - (1 - alpha) * y(i - 1);
    end
end

% Hasil filter rekursif
disp(y);
