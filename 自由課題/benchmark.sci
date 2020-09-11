clear
clc

exec("./setup.sci")

str = "abcdefghijklmnopqrstuvwxyz es ist dem feind gelungen, die front in breiter formation zu durchbrechen. im suden hat der gegner zossen genommen und stosst auf stahnsdorf vor. der feind operiert am nordlichen stadtrand zwischen frohnau und pankow, und im osten, der feind hat an der linie lichtenberg, mahlsdorf, karlshorst gelangt. mit dem angriff steiners wird das alles in ordnung kommen. mein fuhrer ... steiner .."


str = convstr(str, 'u');

tic()
waveform = Encoder(str);
transmit_delay = toc()

//ノイズを付与
//noise = add_noise(waveform)
//エコーを付与
//noise = add_echo(waveform)

tic()
ret_str = Decoder(noise);
receive_delay = toc()

printf("---Result---\n")
printf("transmitted string: %s\n", convstr(str, 'l'))
printf("transmit delay (letter per second): %f\n", transmit_delay / length(str))
printf("received string:    %s\n", convstr(ret_str, 'l'))
printf("receive delay (letter per second):  %f\n", receive_delay / length(ret_str))
ret_str = strsplit(ret_str)
printf("error rate: %f\n", sum(abs(strcmp(strsplit(str), ret_str(1:length(str))))) / length(str))
