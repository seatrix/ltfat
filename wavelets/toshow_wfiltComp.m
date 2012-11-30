function toshow_wfiltComp

load vonkoch;
f=vonkoch';
clear vonkoch;
%f = traindoppler;
figure(1);
clf;
plot(f);

scalegramBounds = [-200 0];


figure(3);
clf;
waitS =3;



J = 5;
w = waveletfb('db',5);
c = fwt(f,w,J);
figure(2);clf;plotwavc(c,'clim',scalegramBounds);
figure(3);freqzfb(fftshift(multid(w.h,J)));
pause(waitS);

w = waveletfb('optfs',2);
c = fwt(f,w,J);
figure(2);clf;plotwavc(c,'clim',scalegramBounds);
figure(3);freqzfb(multid(w.h,J));
pause(waitS);

w = waveletfb('dden',6);
c = fwt(f,w,J);
figure(2);clf;plotwavc(c,'clim',scalegramBounds);
figure(3);freqzfb(multid(w.h,J));
pause(waitS);

w = waveletfb('hden',3);
c = fwt(f,w,J);
figure(2);clf;plotwavc(c,'clim',scalegramBounds);
figure(3);freqzfb(multid(w.h,J));
pause(waitS);

w = waveletfb('dgrid',3);
c = fwt(f,w,J);
figure(2);clf;plotwavc(c,'clim',scalegramBounds);
figure(3);freqzfb(multid(w.h,J));
pause(waitS);

w = waveletfb('symds',3);
c = fwt(f,w,J);
figure(2);clf;plotwavc(c,'clim',scalegramBounds);
figure(3);freqzfb(multid(w.h,J));
pause(waitS);





w = waveletfb('dtree');
c = fwt(f,w,J);
figure(2);clf;plotwavc(c,'clim',scalegramBounds);
hdt = cell(2,J);
hdt{1} = w.h{1};
hdt{2} = w.h{2};
for jj = 2:J
  hdt{1,jj} = w.h{3};
  hdt{2,jj} = w.h{4};  
end
figure(3);freqzfb(multid(hdt,J));
pause(waitS);


