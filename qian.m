function P1 = qian()
x1=load('X1.txt');
%x=load('matlab-X1.mat');
y1=load('Y1.txt');
Xf=x1;
Yf=y1;

rgb = imread('1.jpg');
% rgb=imread('3.jpg');
[ height, width, v2 ] = size(rgb);
%[X0,Y0,R] = Yuan(rgb); %返回圆形区域的圆心坐标及半径
%figure,imshow(rgb)
%hold on
%R=load('H.txt');
%T=load('T.txt');
h1=350;
w1=1100;
%h1=480;
%w1=260;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Image1 = zeros ( h1 , w1 ,v2 );
%Image = zeros ( height , width ,v );
Image1 = uint8 ( Image1 );%取整
%Image(v0, u0, 1:3)=rgb(y0,x0,1:3);
%figure,imshow(Image)
hw=175;
ww=550;
%figure,imshow(Image);
%hw=65;
%ww=40;
%取成像平面图像上任意一点p（x,y）,x,y皆为整数
for y = 1:h1
    for x = 1:w1-1
    yw = (h1-y)*hw/h1;
    xw = x*ww/w1;
    sh = yw/25;
    zb = xw/25;
    sh_i = floor(sh);
    zb_j = floor(zb);
    %把需要显示的图像划分成一个一个的方格，求四个顶点
    fg_1 = zb_j*8+1+sh_i;
    fg_2 = fg_1+1;
    fg_3 = fg_2+8;
    fg_4 = fg_1+8;
    u1_1= Xf(fg_1)-(Xf(fg_1)-Xf(fg_2))*(sh-sh_i);
    u1_2= Xf(fg_4)-(Xf(fg_4)-Xf(fg_3))*(sh-sh_i);
    u1  = u1_1 + (u1_2-u1_1)*(zb-zb_j);
    v1_1= Yf(fg_1)+(Yf(fg_2)-Yf(fg_1))*(sh-sh_i);
    v1_2= Yf(fg_4)+(Yf(fg_3)-Yf(fg_4))*(sh-sh_i);
    v1  = v1_1 + (v1_2-v1_1)*(zb-zb_j);
    i=floor(u1);   %x方向分量
    j=floor(v1);    %y方向分量
    a=u1-i; b=v1-j ; %求小数部分
    u= i ; 
    v= j; %(u,v)是在原图像中对应的坐标点
    if  v > height || v < 1 || u > width || u < 1 ||v>height-1||u>width-1%如果超出图像之外的信息舍去
           continue    
    end
    
    Image1( y, x,:)=(1-a)*(1-b)*rgb( v, u,:)+a*(1-b)*rgb( v+1, u,:)+b*(1-a)*rgb( v, u+1,:)+a*b*rgb( v+1, u+1,:);
  
    end
end

%%%%%%插值%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CorrectionImage = imresize ( Image , [ 480 720 ] , 'bilinear' );
%figure ,imshow(CorrectionImage);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure, imshow ( Image1) ;
P1=Image1;
end

