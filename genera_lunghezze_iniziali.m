function [r] = genera_lunghezze_iniziali

y = [0.35,0.35,0.34,0.34,0.33,0.33,0.32,0.32,0.31,0.31,0.30,0.30,0.29,0.29,0.28,0.28,0.27,0.27,0.26,0.26,0.25,0.25,0.24,0.24,0.24,0.23,0.23,0.23,0.22,0.22,0.22,0.21,0.21,0.21,0.20,0.20,0.20,0.20,0.19,0.19,0.18,0.18,0.18,0.18,0.18,0.17,0.17,0.17,0.17,0.17,0.17,0.17,0.17,0.16,0.16,0.16,0.16,0.16,0.16,0.16,0.16,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15,0.15];
for i = 1:14
    y = [y,0.14];
end

for i = 1:15
    y = [y,0.13];
end

for i = 1:25
    y = [y,0.12];
end

for i = 1:26
    y = [y,0.11];
end

for i = 1:30
    y = [y,0.10];
end

for i = 1:39
    y = [y,0.09];
end

for i = 1:40
    y = [y,0.08];
end
for i = 1:50
    y = [y,0.07];
end

for i = 1:60
    y = [y,0.06];
end

for i = 1:70
    y = [y,0.05];
end

for i = 1:75
    y = [y,0.04];
end

for i = 1:59
    y = [y,0.03];
end

for i = 1:35
    y = [y,0.02];
end

for i = 1:10
    y = [y,0.01];
end
y = y';

x = 0:.01:0.35;
% histogram(y);

%figure

y = fitdist(y,'beta');
% distribuzione = pdf(y,x);
% plot(x,distribuzione,'LineWidth',2)
% ylabel('Cr.Num/Area');
% xlabel('Cr.Lenght [mm]');

r = random(y);
%hist(r);
