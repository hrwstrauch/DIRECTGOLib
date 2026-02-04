function y = Langerman_5x2(x)
% -------------------------------------------------------------------------
% Function: Langerman m=5, n=2
% File: Langerman_5x2.m
% Author (implementation): Linas Stripinis
%
% Scientific provenance:
% Primary reference:
%  - Bersini, H., Dorigo, M. and Langerman, S. (1996) 'Results of the first 
%    international contest on evolutionary optimization', IEEE International 
%    Conf. on Evolutionary Computation, Nagoya, Japan, pp.611–615.
%
% Secondary reference:																								
%  - Surjanovic, S., Bingham, D. (2013): Virtual library of simulation 
%    experiments: Test functions and datasets. 
%    URL: http://www.sfu.ca/~ssurjano/index.html	
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f* = -4.155809
%   x* = [2.793402; 1.597233]
%
% Default variable bounds:
%   0 <= x(i) <= 10,  i = 1,...,n
%
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 1, 1, 0, 0, 0, 0];
    y.libraries = [0, 1, 0, 1, 0, 0, 0, 0, 0, 0];
    return
end
if numel(x) ~= 2, error('Function is defined only for n = 2.'); end
if size(x, 2) > size(x, 1), x = x'; end

c = [1; 2; 5; 2; 3];
A = [3, 5; 5, 2; 2, 1; 1, 4; 7, 9];

D = sum((A - x.').^2, 2);    
y = sum(c.*exp(-D/pi).*cos(pi*D));
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -4.1558092918477865;
end

function xmin = get_xmin(~)
    xmin = [2.7934022071225773; 1.5972325032246983];
end