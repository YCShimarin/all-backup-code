% Definisikan sinyal k dan h[n]
k = [-5, 2, 2, 2];
h = [-5, 2, 2];

% Inisialisasi hasil konvolusi dengan nol
result = zeros(1, length(k) + length(h) - 1);

% Lakukan konvolusi
for n = 1:length(result)
    % Inisialisasi nilai konvolusi pada indeks n
    conv_sum = 0;
    
    % Hitung kontribusi dari k[n] dan h[n]
    for k_index = 1:length(k)
        % Pastikan indeks tidak keluar dari batas
        h_index = n - k_index + 1;
        if h_index >= 1 && h_index <= length(h)
            conv_sum = conv_sum + k(k_index) * h(h_index);
        end
    end
    
    % Simpan hasil konvolusi pada indeks n
    result(n) = conv_sum;
end

% Plot hasil konvolusi
stem(result);
xlabel('n');
ylabel('Konvolusi');
title('Hasil Konvolusi');
grid on;
