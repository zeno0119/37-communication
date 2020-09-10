clear
clc

fs = 48000;
f_base = 500;
len_t = 0.05;
bitscale = 10;
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

t = %t; f = %f;
res = [];
for th = 45:0.2:60
    disp(th)
    errbit1st = 0;
    errbit2nd = 0;
    errbit = 0;3
for i=1:100
if modulo(i, 10) == 1
//printf("attempt: %d\n", i);
end
str = "oh, him? Yeah, I know him Its going to take a while... it happened years ago. Did you know there are three kinds of aces? those who seek strength. Those who live for pride. and those who can read the tide of battle. those are the three."

bitary = BitMultiPlexer(BitEncoder(convstr(str, 'u')));
// bitary = rand(len_alp, 5) >= .5;
waveform = WaveTransmitter(bitary);

noise = add_noise(waveform)

noise = noise / max(noise)

// playsnd(noise, fs)

wavwrite(waveform, 48000, "out.wav")

tic()
retval = WaveReceiver(noise, th);

str2 = BitDecoder(BitdeMultiPlexer(retval));
toc()
//disp("transmitted string", str)
//disp("received string", convstr(str2, 'l'))
errbit = errbit + sum(((~bitary & retval) | (bitary & ~retval)));
errbit1st = errbit1st + sum(~bitary & retval); //F -> T
errbit2nd = errbit2nd + sum(bitary & ~retval); //T -> F
end

printf("error rate is %f\n", errbit / bitscale/length(str) / 100)
printf("error1st rate is %f\n", errbit1st / bitscale/length(str) / 100)
printf("error2nd rate is %f\n", errbit2nd / bitscale/length(str) / 100)
end
disp("end")
