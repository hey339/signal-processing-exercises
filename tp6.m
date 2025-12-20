n=100;
f=0;
x=0:0.1:2*pi;
for i=0:1:n
    v=(4/pi)*sin((2*i+1)*x)/(2*i+1);
    f=f+v;
    plot(x,v);
    hold on;
end
plot(x,f);