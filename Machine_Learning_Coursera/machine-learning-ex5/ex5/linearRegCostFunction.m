function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%

%代价函数部分
%建立特殊参数向量
theta_lambda= [0;theta(2:end)];
%初始化参数向量
Theta = theta;
%与y的数量相同的参数
for i=2:m
    Theta = [Theta,theta];
end
%首先计算 h函数
h = sum(X .* Theta',2);
% 代价函数
J = (1/(2*m))*sum(( h - y).^2,1)  + (lambda/(2*m))*sum(theta_lambda .^ 2,1);

% 下降剃度部分
[m1,n1] = size(X);
 tmp = h - y;
for i=2:n1
    tmp = [tmp,h - y];
end
grad = (1/m)*sum(tmp .* X,1)+((lambda/m) * theta_lambda )';
grad = grad';

% =========================================================================
grad = grad(:);
end
