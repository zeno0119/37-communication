clear
tic()
x = 0;
for i = 1:100
x = x + i;
end
x
time = toc();
time
tic();
y = sum(1:100);
y
time = toc();
time
