function [devide]=devide(img)%输入字符串，输出分割好的车牌图片数组   使用：img='card.jpg' ,[devide]=devide(img)

im=imread(img);%读取车牌
figure%画一个窗口
subplot(4,1,1),imshow(im);%4 1 1 意思是这个窗口有四行，一列  最后的1的意思是这是第一个
title('原图')
gray=rgb2gray(im);%灰度化
level=graythresh(gray);%大津法求阈值
bw=im2bw(gray,level);%转化为二值图像




set(gcf,'Name','车牌分割')%窗口标题
subplot(4,1,2),imshow(bw);%两行一列
title('二值化');


[m n]=size(bw);%求二值化后车牌的长和宽，m是高，n是宽
% 求垂直投影


%对车牌进行再处理，把边缘噪声背景变为黑色，便于下一步的分割以及识别。
for x=1:m%对图片从上往下进行扫描
    count=0;
    for z=1:n-1
        if bw(x,z)*bw(x,z+1)==0
            if bw(x,z)==1 || bw(x,z+1)==1
                count=count+1;
            end
        
        end
    end
    if count<14          %跳变次数小于十四次（跳变就是从0到1或者1到0）                就认为是噪声， 把他变为背景色：黑色
        bw(x,1:n)=0;
    end;
end
%下面进行左右两边的噪声消除


for z=1:n*0.04%车牌左边
    temp=sum(bw(1:m,z));
    if temp<0.5*m
        bw(1:m,z)=0;
    end
end

for z=int32(0.96*n):n%车牌右边
    temp=sum(bw(1:m,z));
    if temp<0.5*m
        bw(1:m,z)=0;
    end
end


    
    

for y=1:n
     S(y)=sum(bw(1:m,y));
end

y=1:n;
subplot(413),imshow(bw);
title('背景处理');

for y=1:n
     S(y)=sum(bw(1:m,y));
end
y=1:n;

subplot(414),plot(y,S(y));
title('垂直投影');

%下面进行切割
count=0;
for y=int32(n/8):int32(7*n/8)%找切割点
    if S(y)==0&&S(y+1)==0&&S(y+2)==0&&S(y+3)==0
        count=count+1
        l(count)=y+2;
        y=y+4;
    end
end
for i=1:length(l)+1%切割
    if i==1
        devide{i}=bw(1:m,1:l(i))
    elseif i==length(l)+1
        devide{i}=bw(1:m,l(i-1):n)
    else
        devide{i}=bw(1:m,l(i-1):l(i))
    end
end
figure
set(gcf,'Name','结果')%窗口标题
for i=1:length(l)%写到磁盘
    
    subplot(1,8,i)
    imshow(devide{i})
    imwrite(devide{i},strcat('pic_',num2str(i),'.jpg'));%写
end
end



        
    



