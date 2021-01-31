clear ; close all; clc

x1 = [1;0;0];
x2 = [0;1;0];

A = [randi([-50 50], 100, 2); randi([-50 50], 100, 2)];

x_mtx = [x1, x2]';

X = A*x_mtx;

[m, n] = size(X);  % m # of examples, n # of features (variables)

noise = randn(size(X));
X = X + noise;
X(1:round(m/2), 3) = X(1:round(m/2), 3) + 4;

figure;
scatter3(X(:,1),X(:,2),X(:,3));
zlabel('Z');
xlabel('X');
ylabel('Y');
zlim([-30 30]);
hold on;


% Zero mean and normalization
mu = mean(X);
X_zeromean = X - mu;
sigma = std(X_zeromean);
X_norm = X;

% SVD
Cov_mtx = (1/m).*X_norm'*X_norm;  
[U,S,V] = svd(Cov_mtx); % Principal components 

%  Draw the eigenvectors centered at mean of data. These lines show the
%  directions of maximum variations in the dataset.

drawLine3D(mu', mu' +  0.1*S(1,1) .* U(:,1), '-b', 'LineWidth', 2);
drawLine3D(mu', mu' +  0.1*S(2,2) .* U(:,2), '-r', 'LineWidth', 2);
drawLine3D(mu', mu' +  0.1*S(3,3) .* U(:,3), '-g', 'LineWidth', 2);
legend('Data points', 'Principle Component 1', 'Principle Component 2', ...
     'Principle Component 3');
hold off;


figure;
scatter3(X(:,1),X(:,2),X(:,3));
zlabel('Z');
xlabel('X');
ylabel('Y');
zlim([-30 30]);

hold on;


% Project data
K = 2;
U_reduced = U(:,1:K);
Z = X_norm * U_reduced;

% Recover the approximation data back with error. Which means we are
% visualizing data on the plane which spanned by principal components
U_reduced = U(:,1:K);
X_rec = Z*U_reduced';


% X_rec = X_rec.*sigma;
% X_rec = X_rec + mu;

hold on;
scatter3(X_rec(:, 1), X_rec(:, 2), X_rec(:, 3));
for i = 1:size(X, 1)
    drawLine3D(X(i,:), X_rec(i,:), '--k', 'LineWidth', 1);
end

hold off


function drawLine(p1, p2, varargin)
%DRAWLINE Draws a line from point p1 to point p2
%   DRAWLINE(p1, p2) Draws a line from point p1 to point p2 and holds the
%   current figure

plot([p1(1) p2(1)], [p1(2) p2(2)], varargin{:});

end

function drawLine3D(p1, p2, varargin)
%DRAWLINE Draws a line from point p1 to point p2
%   DRAWLINE(p1, p2) Draws a line from point p1 to point p2 and holds the
%   current figure

plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)], varargin{:});

end



