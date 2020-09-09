clear //変数のクリア
close
img1 = imread("./week1/sakana_1.bmp"); // sakana_1の読み込み
img2 = imread("./week1/sakana_2.bmp"); // sakana_2の読み込み
subplot(2,2,1); imshow(img1);
subplot(2,2,2); imshow(img2);
// これ以降を埋める

for y=1:length(img2(:, 1)) - length(img1(:, 1))
    for x=1:length(img2(y, :)) - length(img1(1, :))
        out(y, x) = sum(~(img2(y:y + 102, x:x + 100) | img1(:, :) & (~img2(y:y + 102, x:x + 100) | ~img1(:, :))));

    end
    if modulo(y, 10) == 1
        disp(y)
    end
end

[ma, index] = max(out)

disp(ma, index)
subplot(2,2,3); imshow(img2(index(1): index(1) + 100, index(2): index(2) + 102))
