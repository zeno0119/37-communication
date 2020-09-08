function [out]= GenerateSin(f, len_t, fs)
    t = 0:1 / fs:len_t
    out = sin(t * (2 * %pi) * f)
endfunction

function [out] = dft(x, f_limit)
    omega = 1:f_limit;
    for o = omega
        n = 0:length(x) - 1;
        out(o) = abs(x * exp(-%i * 2 * %pi * o * n / length(n)).')
    end
endfunction

function [out] = GenerateSaw(f, len_t, fs)
    t = 0:1 /fs:len_t
    out = f*t-floor(f*t) - 0.5 * 2;
endfunction
