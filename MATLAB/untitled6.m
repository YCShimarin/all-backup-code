% Define the coefficients for the LTI system
a = [1, 2];

% Define the input signal
input_data = [1,5,2,7,2,5,6,7,9]; % Extended by one element for proper delay
data = [input_data, zeros(1, 1)];

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
            output_signal_recv(n) = output_signal_recv(n) - a(k) * delay_data(n)
        end
    end
end

% Display the input and output data
disp('Input Data:');
disp(data);
disp('Output Data:');
disp(output_signal_recv);

% Plot the input and output data
figure;
subplot(2, 1, 1);
stem(data, 'b', 'DisplayName', 'Input Data');
title('Input Data');
subplot(2, 1, 2);
stem(output_signal_recv, 'r', 'DisplayName', 'Output Data');
title('Output Data');
