clear
clc

fs = 48000;
f_base = 500;
len_t = 0.02;
bitscale = 5;
len_alp = 5;
// 1秒間パイロットを送って比較する
rate1 = [];
rate2 = [];

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

t = %t; f = %f;
res = [];
th = 178
    disp(th)
    errbit1st = 0;
    errbit2nd = 0;
    errbit = 0;3
for i=1:1
if modulo(i, 10) == 1
printf("attempt: %d\n", i);
end
str = "Es ist dem Feind gelungen, die Front in breiter Formation zu durchbrechen. Im Suden hat der Gegner Zossen genommen und stosst auf Stahnsdorf vor. Der Feind operiert am nordlichen Stadtrand zwischen Frohnau und Pankow, und im Osten, der Feind hat an der Linie Lichtenberg, Mahlsdorf, Karlshorst gelangt. Mit dem Angriff Steiners wird das alles in Ordnung kommen. Mein Fuhrer ... Steiner ..." 

bitary = BitEncoder(convstr(str, 'u'));
// bitary = rand(len_alp, 5) >= .5;
waveform = WaveTransmitter(bitary);

[noise, noise_] = add_noise(waveform)
// playsnd(noise, fs)
    z = poly(0, "z")
    p = z^180 / (1 - 0.9 * z^180) //コムフィルタ
//noise = noise - flts(rand(1, length(noise), "normal"), p)

wavwrite(waveform, 48000, "out.wav")

tic()
retval = WaveReceiver(noise ,th);

str2 = BitDecoder(retval);
toc()
disp("transmitted string", str)
disp("received string", convstr(str2, 'l'))
errbit = errbit + sum(((~bitary & retval) | (bitary & ~retval)));
errbit1st = errbit1st + sum(~bitary & retval); //F -> T
errbit2nd = errbit2nd + sum(bitary & ~retval); //T -> F
end

printf("error rate is %f\n", errbit / 5/ length(str))
printf("error1st rate is %f\n", errbit1st / 5/length(str))
printf("error2nd rate is %f\n", errbit2nd / 5/length(str))
rate1 = cat(1, rate1, errbit1st / 5/ length(str) / 100)
rate2 = cat(1, rate2, errbit2nd / 5/ length(str) / 100)

//end
disp("end")
