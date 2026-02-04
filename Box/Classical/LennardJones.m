function y = LennardJones(x)
% -------------------------------------------------------------------------
% Function: Lennard–Jones cluster optimization problem
% File: LennardJones.m
% Author (implementation): Linas Stripinis
%
% Scientific provenance:
% Primary reference:
%  - Northby, J. A. (1987). Structure and binding of Lennard-Jones clusters: 
%    13 ≤ N ≤ 147. Journal of Chemical Physics, 87(10), 6166–6177.
%    DOI: 10.1063/1.453610
%
% Secondary reference:
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f* = -0.25
%   x* is non-unique due to symmetry (rigid motions, permutations).
%
% Default variable bounds:
%   -100 <= x(i) <= 100,  i = 1,...,n
%
% Problem Properties:
%   n  = 3k, k >= 2;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 6;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 0, 1, 0, 0, 1, 0];
    y.libraries = [0, 0, 0, 1, 0, 0, 0, 0, 0, 0];
    return
end
if mod(numel(x),3) ~= 0 || numel(x) < 6, error('Function is defined only for mod(n, 3) == 0 and n >=6 .'); end
if size(x, 2) > size(x, 1), x = x'; end

k = length(x)/3;
y = 0;

for i = 0:k-2
    zi = 3*i + 1;
    for j = i + 1:k-1
        zj = 3*j + 1;
        r = sqrt((x(zi) - x(zj))^2 + (x(zi + 1) - x(zj + 1))^2 + (x(zi + 2) - x(zj + 2))^2);
        if r < 1e-6
            y = 1e300;
            return;
        end
        y = y + (1/r^12 - 1/r^6);
    end
end
end

function xl = get_xl(nx)
    xl = -100*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 100*ones(nx, 1);
end

function fmin = get_fmin(nx)
    if nx == 6
        fmin = -0.2500000000000000555;
    else
        fmin = nan;
    end
end

function xmin = get_xmin(nx)
    if nx == 6
        xmin = [77.6224683935837447279; -11.7752898627967788059; -88.5186017059375132021; ...
                78.4901216811143171981; -12.4121273796732225492; -88.1999533129028350231];
    else
        xmin = nan(nx, 1);
    end
    
end