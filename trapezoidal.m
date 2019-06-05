function [t,y,it]=trapezoidal(a,b,y0,N,TOL,maxit)


%% Input 

% a           starting time
% b           final time
% y0          initial value
% N           # of time interval
% TOL         Stopping criterion #1
% maxit       Stopping criterion #2

%% Output

% t           time grid points
% y           numerical solution
% it          # of iteration


%%
h=(b-a)/N;
t=linspace(a,b,N+1);
y=zeros(1,N+1);              
y(1)=y0;

%% Trapezoidal
for j=1:N
	yo=y(j);
	yj=yo; %Starting Newton
	it=0;  %Newton's iteration counter
	flag=1; % Safety flag (1 okay, 0 not okay)
	while flag
		yc=yj;
		[f,J]=problem(t(j+1),yc);
                [f1]=problem2(t(j),yo);
		Jacobi=1-h/2*J;
        	g=yc-yo-h/2*f-h/2*f1;
		dy=Jacobi\g; %dy=y_{j+1}-y_j
        	yj = yc - dy;
		it=it+1;
	        if norm(dy,'inf')/norm(yj,'inf') < TOL || it == maxit
			flag=0;
	        end
	end
        y(j+1)=yj;
end


function [f,J]=problem(t,y)
%% Output
% f      rhs
% J      Jacobian of the rhs function f
f=-15*y;
if nargout >1
	J=-15;
end
function [f1]=problem2(t,y)
f1=-15*y;



