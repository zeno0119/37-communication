clear
exec('C:\Users\ishma\Documents\知的工学システム応用実験\GenerateFunction.sci')

f = 18000;
len = 5;
fs = 48000;

[t, out] = GenerateSin(f, len, fs)
wavwrite(out, fs, "week1/kadai2-1.wav")
playsnd(out)
