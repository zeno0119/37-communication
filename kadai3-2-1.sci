clear // 変数のクリア
close
[x, fs] = wavread("./week1/sound_hgst.wav"); // 音声ファイル「日立グローバル
disp(fs)
// ストレージテクノロジーズ」の読込
[y, fs] = wavread("./week1/sound_barusu.wav"); //（天空の城）ラピュタが崩壊する
disp(fs)
// とある呪文の読み込み
// x, y: 音声波形
// fs: サンプリング周波数
time_x = (0:length(x)-1)/fs; // 時間軸の設定
time_y = (0:length(y)-1)/fs; // 時間軸の設定
subplot(3,1,1); plot(time_x,x) // figureウィンドウを3行1列に分割し，
// その1番目にグラフを表示
xlabel('Time (s)')
ylabel('Amplitude')
subplot(3,1,2); plot(time_y,y) // figureウィンドウを3行1列に分割し，
// その2番目にグラフを表示
xlabel('Time (s)')
ylabel('Amplitude')
playsnd([x zeros(1,fs) y],fs) //音声ファイルxとyの再生
[corr_xy, lags] = xcorr(x,y); //xとyの相互相関関数の計算
index = lags(max(corr_xy))
disp(index)

subplot(3,1,3); plot(lags, corr_xy / max(corr_xy))
//figureウィンドウを3行1列に分割し，
//その3番目に
//xとyの相互相関関数を表示
