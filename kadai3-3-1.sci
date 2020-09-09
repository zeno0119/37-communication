
clear // 変数のクリア
close
[x, fs] = wavread("./week1/sample02.wav"); // 雑音混じりの信号をベクトルxとして読込
disp(fs)
X = abs(fft(x)).^2/(length(x)^2); // xのパワースペクトルXを計算
time_x = (0:length(x)-1)/fs; // 時間軸の設定
freq_X = (0:length(X)-1)*fs/length(X); // 周波数軸の設定

fc = 860;
fu = 900;

hz=iir(2,'bp','ellip',[fc/fs fu/fs],[.08 .03]);

disp(hz)

x_filt = flts(x, hz);
X_filt = abs(fft(x_filt)).^2/(length(x_filt)^2);

subplot(2,2,1); plot(time_x,x) // xの表示
xlabel('Time (s)')
ylabel('Amplitude')
subplot(2,2,2); plot2d('nl',freq_X,X) // Xの表示（片対数グラフ）
xlabel('Frequency (Hz)')
ylabel('Power')
subplot(2,2,3); plot(time_x,x_filt) // xの表示
xlabel('Time (s)')
ylabel('Amplitude')
subplot(2,2,4); plot2d('nl',freq_X,X_filt) // Xの表示（片対数グラフ）
xlabel('Frequency (Hz)')
ylabel('Power')


playsnd(x_filt, fs)
