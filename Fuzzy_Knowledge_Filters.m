function [W1,W2,W3,W4,B] = Fuzzy_Knowledge_Filters(Intensity)
 %W1,W2,W3,W4,B是输入dm的隶属度。
 %Intensity是掩模差值矩阵。
for x = 1:1:3
   for y = 1:1:3
       if((Intensity(x,y) <= 0.2) &&(Intensity(x,y) >= -0.2))
           Intensity(x,y) = exp(-20*Intensity(x,y).*Intensity(x,y));
       else Intensity(x,y) = 0;
       end
   end
end
 
W1 = min(Intensity(1,2),Intensity(2,3));
W2 = min(Intensity(2,3),Intensity(3,2));
W3 = min(Intensity(3,2),Intensity(2,1));
W4 = min(Intensity(2,1),Intensity(1,2));
B = min(min(1-W1,1-W2),min(1-W3,1-W4));
end
