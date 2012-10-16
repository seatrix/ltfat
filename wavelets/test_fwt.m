function test_failed = test_fwt


ord = 10;
J=10;
   
    wavName = sprintf('db%d',ord);
    [H, G] = dbfilt(ord);
    dwtmode('per','nodisp');


    %f = 1:2^J*18+2^J/2+1;
    %f = f(:);
    f = [randn(2^J*180+2,1),randn(2^J*180+2,1),randn(2^J*180+2,1)];

    [C,L] = wavedec(f,J,wavName);



    c = fwt(f,H,J);
    fhat = ifwt(c,G,J,length(f));

    if(norm(f(:)-fhat(:))>1^-10)
     figure(2);clf;
     stem([f,fhat]);
    end

%     [err,coefs] = checkCoefs(c,C,L,G{1},G{2},J);
% 
%     if(err>1^-10)
%      figure(1);
%      clf;
%      printCoeffs(c,coefs);
%          error('Coefficients are not equal! Error is %g',err);
%     end




function [err, coefs]  = checkCoefs(c,C,S,lo_r,hi_r,J)

coefs = cell(J+1,1);

coefs{1,1} = appcoef(C,S,lo_r,hi_r,J);
for j=1:J
     [coefs{end-j+1}] = detcoef(C,S,j); 
end


err = 0;
err = err +  norm(c{J+1,1}(:) - coefs{J+1,1}(:));
for j=1:J
     err = err +  norm(c{j,1}(:) - coefs{j,1}(:)); 
end

function printError( x,y)

[J,N1] = size(x);

for j=1:J
    subplot(J,1,j);
     err = x{j} - y{j};
      stem(err);
      lh = line([0 length(x{j})],[eps eps]);
      set(lh,'Color',[1 0 0]);
      lh =line([0 length(x{j})],[-eps -eps]);
      set(lh,'Color',[1 0 0]);

end

function printCoeffs( x,y)

[J,N1] = size(x);

for j=1:J
    subplot(J,1,j);
    % err = x{j}(:) - y{j}(:);
      stem([x{j}(:),y{j}(:)]);
      lh = line([0 length(x{j})],[eps eps]);
      set(lh,'Color',[1 0 0]);
      lh =line([0 length(x{j})],[-eps -eps]);
      set(lh,'Color',[1 0 0]);

end

