clear
[x_1k, fs] = wavread("./week1/sample01.wav");

t = (0:length(x_1k) - 1) / fs;

partition = 2;

x_1k_part = x_1k(1:length(x_1k) / partition);

t_part = (0:length(x_1k_part) - 1)/fs;

plot(t, x_1k)

xgrid();
legend("x_1k", 1);

title("音声波形")
xlabel("時間(s)")
ylabel("振幅")

figure;
plot(t_part, x_1k_part)
xgrid();

legend("x_1k_part", 1);

title("音声波形")
xlabel("時間(s)")
ylabel("振幅")
