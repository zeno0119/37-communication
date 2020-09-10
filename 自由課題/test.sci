clear
clc

len_t = 0.8

echo = 0.2;
fs = 48000;

t = (0:(0.2 * fs))/fs;
t2 = (0:(len_t * fs)) / fs;

pilot_signal = sin(2 * %pi * t2 * 5000)
pilot_signal = cat(2, pilot_signal, zeros(1, fs * 0.2))

playsnd(pilot_signal, 48000);


y = sin(2 * %pi * t2 * 10000)

p1 = log(20*t+1)*500+sin(t);
p2 = exp(-100000*(sin(p1)^2)) * 0.2;
noise = convol(p2.*exp(-t*4),pilot_signal);

disp(max(noise))
x = pilot_signal(1:48000) * max(noise)


noise = noise(1:48000) / max(noise)


subplot(2,2,1)
plot(noise)
subplot(2,2,2)
plot(x)

subplot(2,2,3)
plot(abs(fft(noise)))
subplot(2,2,4)
plot(abs(fft(x)))

figure;
subplot(2,1,1)
plot(abs(fft(repmat(p2.*exp(-t*4), [1, 5]))))
subplot(2,1,2)
plot(abs(fft(noise) ./ fft(x)))

filt = fft(noise) ./ fft(x)

rd_wave = rand(1, fs * 0.8)
rd_wave = rd_wave / max(rd_wave)
rd_noise = convol(p2.*exp(-t*4),rd_wave);
rd_wave = rd_wave * max(rd_noise)

figure;
subplot(2,1,1)
plot(abs(fft(rd_wave)))
subplot(2,1,2)
plot(abs(fft(rd_noise) ./ filt))
