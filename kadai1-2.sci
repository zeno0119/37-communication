clear
x = rand(1,1000);
tic()
for i = 1:size(x,2)
    if x(i) >= 0.5
        y(i) = 1;
    else
        y(i) = 0;
    end
end

y
toc()

tic()
y2 = 1 * (x >= 0.5);

y2
toc()
