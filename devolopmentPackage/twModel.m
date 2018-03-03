function M = twModel()  

% x = sin(linspace(1,10,20));
% y = sin(linspace(2,11,20));
% z = cos(linspace(2,11,20));

q = sin(linspace(2,11,20)+.5);
r = sin(linspace(2,11,20)+1);
s = sin(linspace(2,11,20)+1.5);
t = sin(linspace(2,11,20)+2);

% noisX = x + .5 * rand(1, length(x));


M = [q; r; s; t];


% corr(x,y)
% corr(x,x)
% corr(x, noisX)
% 
% corrcoef(x,noisX)
% corrcoef(x,y)
% corrcoef(x,2*y)
% corrcoef(x,1+y)
% corrcoef(x,cos(y))

end