function [h,relres,iter]=iframemul(f,Fa,Fs,s,varargin)
%IFRAMEMUL  Inverse of frame multiplier
%   Usage: h=iframemul(f,Fa,Fs,s);
%         [h,relres,iter]=iframemul(...);
%
%   Input parameters:
%          Fa   : Analysis frame
%          Fs   : Synthesis frame
%          s    : Symbol
%          f    : Input signal
%
%   Output parameters: 
%          h    : Output signal
%
%   `iframemul(f,F,s)` applies the inverse of the frame multiplier with
%   symbol *s* to the signal *f*. The frame *Fa* is used for analysis
%   and the frame *Fs* for synthesis.
%
%   Because the inverse of a frame multiplier is not necessarily again a
%   frame multiplier for the same frames, the problem is solved using an 
%   iterative algorithm.
%
%   `[h,relres,iter]=iframemul(...)` additionally returns the relative
%   residuals in a vector *relres* and the number of iteration steps *iter*.
%
%   `iframemul` takes the following parameters at the end of the line of
%   input arguments:
%
%     'tol',t      Stop if relative residual error is less than the
%                  specified tolerance. Default is 1e-9 
%
%     'maxit',n    Do at most n iterations.
%
%     'print'      Display the progress.
%
%     'quiet'      Don't print anything, this is the default.

%   See also: iframemul
  
% Author: Peter L. Søndergaard

if nargin < 4
    error('%s: Too few input parameters.',upper(mfilename));
end;

definput.keyvals.tol=1e-9;
definput.keyvals.maxit=100;
definput.keyvals.printstep=10;
definput.flags.print={'quiet','print'};

[flags,kv]=ltfatarghelper({},definput,varargin);

% TODO: Check that the symbol length match the input signal length

% The frame multiplier is not positive definite, so we cannot solve it
% directly using pcg.
% Apply the multiplier followed by its adjoint. 
A=@(x) framemuladj(framemul(x,Fa,Fs,s),Fa,Fs,s);

[h,flag,dummytilde,iter1,relres]=pcg(A,framemuladj(f,Fa,Fs,s),kv.tol,kv.maxit);



