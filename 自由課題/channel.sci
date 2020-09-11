function [noise] = add_noise(wave)
    noise_ = rand(1, length(wave), "normal")
    noise = wave + noise_
endfunction

function [echo] = add_echo(wave)
    t = (0:(0.2 * fs))/fs;
    p1 = log(20*t+1)*500+sin(t);
    p2 = exp(-100000*(sin(p1)^2)) * 0.2;
    echo = convol(p2.*exp(-t*4),wave);
endfunction
