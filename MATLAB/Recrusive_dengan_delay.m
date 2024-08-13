% Define the coefficients for the LTI system
a = [1, 1];
b0 = 1;
b1 = 1;

% Define the input signal
input_data = [1, 2, 3, 4, 5, 6, 7, 8]; % Extended by one element for proper delay
data = [input_data, zeros(1, 1)]
% Initialize arrays for delay and output
delay_data = zeros(size(data));
output_signal_recv = zeros(size(data));

% Implement the delay system
for n = 1:length(data)
    if n > 1
        delay_data(n) = data(n - 1);
    else
        delay_data(n) = 0; % Zero padding for samples before the delay
    end
end

% Recursive Part
for n = 1:length(data)
    output_signal_recv(n) = data(n);
    for k = 2:length(a)
        if n - k + 1 >= 1
            output_signal_recv(n) = output_signal_recv(n) - a(k) * delay_data(n - k + 1);
        end
    end
end

% Non-Recursive Part

% Implement the delay system for the non-recursive part
delay_output = zeros(size(output_signal_recv));
main_signal = zeros(size(output_signal_recv))+ output_signal_recv;

for n = 1:length(output_signal_recv)
    main_signal = main_signal*b0
    if n > 1
        delay_output(n) = output_signal_recv(n - 1)*b1;
    else
        delay_output(n) = 0;
    end
end
delay_output(end)=output_signal_recv(end);

output_data = main_signal + delay_output;

% Display the input and output data
disp('Input Data:');
disp(data);
disp('Output Data:');
disp(output_data);

% Plot the input and output data
figure;
subplot(2, 1, 1);
stem(data, 'b', 'DisplayName', 'Input Data');
title('Input Data');
subplot(2, 1, 2);
stem(main_signal, 'r', 'DisplayName', 'Output Data');
title('Output Data');
