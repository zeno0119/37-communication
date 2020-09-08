clear
exec('C:\Users\ishma\Documents\知的工学システム応用実験\GenerateFunction.sci', -1)

c = GenerateSin(523.25, 1, 18000);
e = GenerateSin(659.26, 1, 18000);
d = GenerateSin(587.33, 1, 18000);
g = GenerateSin(392, 1, 18000);

g3 = GenerateSin(392, 3, 18000);

c3 = GenerateSin(523.25, 3, 18000);
chime = cat(2, c, e, d, g3 ,c, d,e, c3,e,c,d,g3 ,g,d,e,c3)

playsnd(chime, 18000)
