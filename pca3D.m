x1 = [1; 1; 0];
x2 = [1; 0; 1];

x = [x1, x2]';

v = randi([0 50],1000,2);

y = v*x;
[r,c] = size(y);
noise = 25*rand(r,c);

y = y + noise;

x_ax = 1:100;
y_ax = 1:100;
z_ax = 1:100;


mean(y, 'all')

scatter3(y(:,1), y(:,2), y(:,3))




