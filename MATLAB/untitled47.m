n = 27;
h = zeros(1, n);
h(1) = 1;
a = 0.95;
y = zeros(1, n);
y2 = zeros(1,length(x));
for i = 1:n
    if i == 1
        y(i) = h(i);
    else
        y(i) = h(i) + a * y(i - 1);
    end
end

for i = 1:length(x)
    if i == 1
        x(i);
    else
        y2(i) = x(i) + a * x(i - 1);
    end
end

convolution = conv(h,x,"same");

rec = y2.*y;

figure;
subplot(4,1,1)
stem(x);
subplot(4,1,2)
stem(convolution);
subplot(4,1,3)
stem(y2);
subplot(4,1,4)
stem(y);
figure;
stem(rec)
grid on;