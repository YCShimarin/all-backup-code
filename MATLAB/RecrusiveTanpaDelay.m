% Koefisien recursive LTI system (Bisa di modifikasi)
b = 1.0; % Gain Input
a = [1.0, -0.5]; % Gain Rekrusif

% Input sinyal, bisa di modifikasi
input_signal = [1, 2, 3, 4, 5];

% Vektor zeros sepanjang length data input sinyal
output_signal_recv = zeros(size(input_signal));

% Rekrusif fungsi sesuai dengan diagram blok
for n = 1:length(input_signal)
    output_signal_recv(n) = b * input_signal(n);
    for k = 2:length(a)
        if n - k + 1 >= 1
            output_signal_recv(n) = output_signal_recv(n) - a(k) * output_signal_recv(n - k + 1);
        end
    end
end

% koefisien non-recrusive (Bisa di modifikasi)
d = 2.0;
c = 1.0;
Input_non_recrusive = zeros(size(input_signal));
feed_forward_sig = zeros(size(input_signal));

%non recrusive part

for n = 1:length(output_signal_recv)
    Input_non_recrusive(n) = d * output_signal_recv(n);
    feed_forward_sig(n) = c*output_signal_recv(n);
end

Output_signal = Input_non_recrusive+feed_forward_sig;


% Print input and output
disp('Input Signal:');
disp(input_signal);
disp('Output Signal Recrusive part:');
disp(output_signal_recv);
disp('Input Signal Non-Recrusive part after gain:');
disp(Input_non_recrusive);
disp('Output Signal part:');
disp(Output_signal);
