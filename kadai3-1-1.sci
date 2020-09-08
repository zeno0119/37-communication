clear
clc
fs = 24e3; //fs: サンプリング周波数(24 kHz)
t = (0:fs-1)/fs; //時間軸の設定（0秒から，1/fs秒ごとに，1秒まで）
sig = sin(2*%pi*20*t); //20 Hzの正弦波
freq_search = 1:100; //周波数の探索範囲
for k = freq_search
sigmtx(:,k) = sin(2*%pi*k*t); //変数kを1から100まで増加させながら，
//各列に周波数 k (Hz)の正弦波を格納
end
plot(freq_search,sig*sigmtx) //sigと，sigmtxの各列の内積を計算し，表示
xlabel('Frequency (Hz)')
ylabel('Inner product value')
