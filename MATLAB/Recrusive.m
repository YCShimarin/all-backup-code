% Input jumlah orde filter IIR
order = input('Masukkan jumlah orde filter IIR: ');

% Input koefisien rekursif
a = zeros(1, order); % Inisialisasi koefisien rekursif
for i = 1:order
    a(i) = input(['Masukkan koefisien rekursif a' num2str(i) ': ']);
end

% Input data masukan
disp("contoh: [1, 2, 3, 4, 5], Default : sin(4 PI t) -> fs : 25")
x = input('Masukkan data masukan : ');

% Gunakan nilai default jika input kosong
if isempty(x)
  % Sinyal sin parameters
    f = 2; % Frekuensi sinyal sin (contoh)
    fs = 25;
    ts = 1/fs;
    t = 0:ts:1; % Rentang waktu
    
    % Generate sinyal sin
    x = sin(2 * pi * f * t);
end


% Inisialisasi output dan state variables
y = zeros(size(x));
y_prev = zeros(1, order);

% Implementasi filter IIR
for n = 1:length(x)
    y(n) = x(n);
    for i = 1:order
        if n > i
            y(n) = y(n) + a(i) * y_prev(i);
        end
    end
    % Update state variables
    y_prev(2:end) = y_prev(1:end-1);
    y_prev(1) = y(n);
end

% Plot stem dari sinyal output
figure;
subplot(2,1,1);
stem(x);
title('Plot Stem Sinyal Output');
xlabel('Indeks Waktu (n)');
ylabel('Amplitudo');

subplot(2,1,2);
stem(y);
title('Plot Stem Sinyal Output');
xlabel('Indeks Waktu (n)');
ylabel('Amplitudo');

