% Inisialisasi panjang respons impuls
repeat = 10;

% Inisialisasi respons impuls dengan nol
impulse_response = zeros(1, repeat);

% Set koefisien pertama (misalnya, 0.2)
impulse_response(1) = 1;

% Inisialisasi sinyal keluaran dan array y_prev
y = zeros(1, length(impulse_response));
y_prev = zeros(1, repeat);

for n = 1:length(impulse_response)
    
end

