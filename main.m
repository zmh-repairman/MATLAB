figure();
subplot(1,2,1);
x=-0.2:1/255:0.2;
y=exp(-20*x.*x);
x = -1:1/255:1;
y = [zeros(1,204) y zeros(1,204)];
plot(x,y); 
axis([-1,1,0,1]),grid;
axis square;
xlabel('a).Input memberchip functions for fuzzy');
 
subplot(1,2,2);
x1 = [0,0.2,1];y1 = [0,0,1];
x2 = [0,0.8,1];y2 = [1,0,0];
plot(x1,y1,x2,y2); 
axis([0,1,0,1]),grid;
axis square;
legend('WH','BL');
xlabel('b).Output memberchip functions for fuzzy');


f = imread('3.tif');
f = mat2gray(f,[0 255]);%图像归一化
 
[M,N]=size(f);
f_Ex = zeros(M+2,N+2);%给图像加上像素为1的边框
 
for x = 1:1:M
    for y = 1:1:N
        f_Ex(x+1,y+1) = f(x,y);
    end
end
 
z = zeros (3,3);
g = zeros (M+2,N+2);
for x = 2:1:M+1
    for y = 2:1:N+1  %掩模差值dm计算
        z(1,1) = f_Ex(x-1,y-1) - f_Ex(x,y);
        z(1,2) = f_Ex(x-1,y) - f_Ex(x,y);
        z(1,3) = f_Ex(x-1,y+1) - f_Ex(x,y);
        
        z(2,1) = f_Ex(x,y-1) - f_Ex(x,y);
        z(2,2) = f_Ex(x,y) - f_Ex(x,y);
        z(2,3) = f_Ex(x,y+1) - f_Ex(x,y);
        
        z(3,1) = f_Ex(x+1,y-1) - f_Ex(x,y);
        z(3,2) = f_Ex(x+1,y) - f_Ex(x,y);
        z(3,3) = f_Ex(x+1,y+1) - f_Ex(x,y);
        
        [W1,W2,W3,W4,B] = Fuzzy_Knowledge_Filters(z);
        %通过输出隶属度函数计算像素点的灰度值
        V1 = 0.8 * W1 + 0.2;
        V2 = 0.8 * W2 + 0.2;
        V3 = 0.8 * W3 + 0.2;
        V4 = 0.8 * W4 + 0.2;
        V5 = 0.8 - (0.8 * B);
        %重心法去模糊
        g(x,y) = ((W1*V1) + (W2*V2) + (W3*V3) + (W4*V4) + (B*V5))/(W1+W2+W3+W4+B); 
        
    end
end
 
figure();
subplot(1,2,1);
imshow(f,[0 1]);
xlabel('a).Original Image');
 
subplot(1,2,2);
imshow(g,[0 1]);
xlabel('b).Result of fuzzy');
 
