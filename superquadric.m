%   author: Yuxiong Zou
%   Much like SPHERE(), ELLIPSOID(), or SUPERQUAD(), this
%   function calculates and returns the matrices required to
%   plot a general superquadric particle using MESH() or SURF().
function [xo,yo,zo]=superquadric(varargin)
% [X Y Z]=SUPERELLIPSOID({AXES}, C, R, P, {N})

%     (X-Cx)^n2     (Y-Cy)^n2               (Z-Cz)
%  ( ---------  +  ---------  )^(n1/n2) + ( ------- )^n1  =  1
%       Rx             Ry                     Rz
%
%   Where the vector C=[Cx Cy Cz] defines the particle center, 
%   the vector R=[Rx Ry Rz] defines the axial radii, 
%   and the vector P = [n1 n2] defines the blockiness.
%   If C, R, or P are scalar, the specified value will be used for all axes.
% 
%   As with the built-in functions, the number of points can be set.
%   The default value for N is 50.
% 
%   If no outputs are specified, a new surf plot will be created.
%   Display axes can be specified if the first argument is an axes handle.
%
%   See also: SPHERE, ELLIPSOID, SUPERQUAD, SUPERTOROID


%error(nargchk(3,5,nargin));
narginchk(3,5)
[ha,inargs,nargs]=axescheck(varargin{:});

[C,R,P]=deal(inargs{1:3});

n=50;
if nargs > 3
	n=inargs{4}; 
end

if numel(C)==1
	C=repmat(C,[1 3]);
end
if numel(R)==1
	R=repmat(R,[1 3]);
end
if numel(P)==1
	P=repmat(P,[1 3]);
end

M=2./P;

v=linspace(-pi/2,pi/2,n);
u=linspace(-pi,pi,n);
[VV UU]=meshgrid(v,u);

cosV=cos(VV); % error needs to be clamped at k*pi/2
sinV=sin(VV);
cosU=cos(UU);
sinU=sin(UU); % error needs to be clamped at k*pi
cosV(:,[1 n])=0;
sinU([1 n],:)=0;

x=C(1)+R(1).*sign(cosV).*abs(cosV).^M(1) .* sign(cosU).*abs(cosU).^M(2);
y=C(2)+R(2).*sign(cosV).*abs(cosV).^M(1) .* sign(sinU).*abs(sinU).^M(2);
z=C(3)+R(3).*sign(sinV).*abs(sinV).^M(1);


if(nargout == 0)
    ha=newplot(ha);
	surf(x,y,z,'parent',ha)
else
	xo=x;
	yo=y;
	zo=z;
end
























