exec("../GenerateFunction.sci")

function [wave] = DeconvFilt(waveform)
    //最初の1秒のデータを切り出して逆畳み込みフィルタを形成して送る
    t = (0:0.8 * fs - 1)/fs
    pilot_wave = cat(2, sin(t * 2 * %pi * 5000), zeros(1, fs * sleep_time))
    deconv_filt = fft(waveform(1:fs)) ./ fft(pilot_wave)
    deconv_filt(find(abs(deconv_filt) >= 200)) = 1
    wave = []
    waveform = waveform(fs + 1: $)
    for i = 0:length(waveform) / fs - 1
        //各部分ごとにフィルタを適用して出力
        data = fft(waveform(i * fs + 1: (i + 1) * fs) ./ deconv_filt)
        wave = cat(2, wave, data)
    end
endfunction


function [bitary] = WaveReceiver(waveform, th)
    //逆畳み込みフィルタを作成して適用
    // waveform = DeconvFilt(waveform)
    //とりあえずlen_t秒ごとにデータを切り出して計算
    
    n = 1:bitscale;
    //plot(abs(fft(waveform)) ** 2)
    bitary = []
    for i = 0:length(waveform) / fs / len_t - 1
        target = waveform(i * fs * len_t + 1: (i + 1) * fs * len_t);
        target_f = 20 * log10(abs(fft(target)) ** 2);
        if i == 2
            plot(target_f)
        end
        freq_ary = (find(target_f >= 49) - 1) / len_t
        //disp("66dB以上の所", freq_ary)
        freq_ary = freq_ary(find(freq_ary <= f_base * n($)))
//        disp("lower than 2500Hz", freq_ary)
        freq_ary = freq_ary(find(freq_ary / f_base == int(freq_ary / f_base)))
//        disp("500の倍数", freq_ary)
        ary_idx = find(freq_ary ~= 0)
//        disp("0じゃない",freq_ary(ary_idx))
        ary = freq_ary(ary_idx)/f_base
//        disp(ary)
        arybit(1, 1:bitscale) = %f
        arybit(ary) = %t
        bitary = cat(1, bitary, arybit)
    end
endfunction

function [str] = BitDecoder(bitary)
    str = []
    for i = 1:length(bitary(:, 1))
        str = cat(1, str, tf_to_alp_table(vectorfind(alp_to_tf_table, bitary(i, :), 'r')))
    end
    str = strcat(str)
endfunction

function [bitary] = BitdeMultiPlexer(muxBit)
    bitary = []
    for i = 1:length(muxBit(:, 1))
        bitary = cat(1, bitary, muxBit(i, 1:$/2), muxBit(i, $/2+1:$))
    end
endfunction

