function [out]= GenerateSin(f, len_t, fs)
    t = 0:1 / fs:len_t
    out = sin(t * (2 * %pi) * f)
endfunction

function [out] = dft(x, fs)
    omega = 1:fs;
    for o = omega
        n = 0:length(x) - 1;
        out(o) = x * exp(-%i * 2 * %pi * o * n / length(n)).'
    end
endfunction

function [out] = GenerateSaw(f, len_t, fs)
    t = 0:1 /fs:len_t
    out = f*t-floor(f*t) - 0.5 * 2;
endfunction
