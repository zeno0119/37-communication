clear
clc

fs = 48000;
f_base = 500;
f_add = 80;
len_t = 0.8;
bitscale = 5;
len_alp = 10;
// 1秒間パイロットを送って比較する


alp_to_tf_table = [%f, %f, %f, %f, %t
%f, %f, %f, %t, %f
%f, %f, %f, %t, %t
%f, %f, %t, %f, %f
%f, %f, %t, %f, %t
%f, %f, %t, %t, %f
%f, %f, %t, %t, %t
%f, %t, %f, %f, %f
%f, %t, %f, %f, %t
%f, %t, %f, %t, %f
%f, %t, %f, %t, %t
%f, %t, %t, %f, %f
%f, %t, %t, %f, %t
%f, %t, %t, %t, %f
%f, %t, %t, %t, %t
%t, %f, %f, %f, %f
%t, %f, %f, %f, %t
%t, %f, %f, %t, %f
%t, %f, %f, %t, %t
%t, %f, %t, %f, %f
%t, %f, %t, %f, %t
%t, %f, %t, %t, %f
%t, %f, %t, %t, %t
%t, %t, %f, %f, %f
%t, %t, %f, %f, %t
%t, %t, %f, %t, %f
%t, %t, %f, %t, %t
%t, %t, %t, %f, %f
%t, %t, %t, %f, %t
%t, %t, %t, %t, %f
%t, %t, %t, %t, %t
]

tf_to_alp_table = strsplit("ABCDEFGHIJKLMNOPQRSTUVWXYZ .,!?")

exec("./encode.sci")
exec("./decoder.sci")
exec("./channel.sci")

wave = Encoder("ABCDE")

deconv_wave = DeconvFilt(abs(wave))

bits = WaveReceiver(wave)

disp(BitDecoder(bits))
