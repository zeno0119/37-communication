exec("../GenerateFunction.sci")

function [bitary] = BitEncoder(str)
    // A-Z%sをビット列に変換する部分
    num = 8
    vec = strsplit(str)
    bitary = []
    mod = modulo(length(str), num)
    for i = 1:length(str)
        bitary = cat(1, bitary, alp_to_tf_table(find(tf_to_alp_table == vec(i)), :))
    end
    bitary = cat(1, bitary, repmat([%f], num - mod, bitscale / 2))
endfunction

function [out] = WaveTransmitter(bitary)
    // bitaryを正弦波の重ね合わせに変換する部分
    // 送信部をチャンクに分割して送信    
    bitscale = length(bitary(1, :));
    out = []
    /*t = (0:active_time * fs - 1)/fs
    out = sin(t * 2 * %pi * 5000)
    out = cat(2, out, zeros(1, fs * sleep_time))*/
    n = 1:bitscale;
    for i = 1:length(bitary(:, 1))
        mask = repmat(bitary(i, :), [fs * len_t, 1])
        out = cat(2, out, sum(mask.' .* GenerateSinary(f_base * n, len_t, fs), 1) / bitscale)
    end
endfunction

function [muxBit] = BitMultiPlexer(bitary)
    muxBit = []
    for i = 1:2:length(bitary(:, 1))
        muxBit = cat(1, muxBit, cat(2,bitary(i, :), bitary(i + 1, :)))
    end
endfunction

function [wave] = Encoder(str)
    wave = WaveTransmitter(BitMultiPlexer(BitEncoder(str)))
endfunction
