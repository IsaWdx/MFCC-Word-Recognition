function MFCCco = MFCC(au)
	M = 24;
	framelen = 256;
	inc = 80;
	fs = 8000;
	
	for k=1:24
    n=0:23;   
    dctcoef(k,:)=cos((2*n+1)*k*pi/(2*24));
	end   
	w=1+6*sin(pi*[1:24] ./24);  
	w=w/max(w);   
	
	%Mel滤波器阶数24 0.5 high end of highest filter
	bank=melbankm(M,framelen,fs,0,0.4,'t');
	bank=full(bank);
	bank=bank/max(bank(:));
	

	
	%预加重、分帧、加窗
	au = filter([1 -0.9375],1,double(au));	
	%sound(au,8000);
	m = zeros(1,24);
	frames = enframe(au, framelen, inc); %参数可以调整
	for i=1:size(frames,1)
		f = frames(i,:);
		window = f'.*hamming(framelen);
		%用FFT计算信号频谱
		t = abs(fft(window));
		%计算频谱平方
		t = t.^2;
		%Mel滤波器组， 取对数，dct
		size(bank,2);
		c1=dctcoef*log(bank*t(1:size(bank,2)));   
		c2=c1.*w';
		m(i,:)=c2';   
		%c = dct(log(bank*t(1:size(bank,2))));
		%size(bank);
		%m(i,:) = c';
	end
	del = zeros(1,24);
	for i=3:size(frames,1)-2
		del(i-2,:) = (m(i-2,:).*(-2) + m(i-1,:).*(-1) + m(i+1,:).*(1) +  m(i,:).*(2))./sqrt(10);
	end
	
	size(m);
	MFCCco = m;
	size(del);
	%MFCCco = del;
	showplot = 1;
	if showplot == 0
		figure(5);
		imagesc(del);
	end



	

	% subplot(2,1,1) 
	% ccc_1=ccc(:,1);
	% plot(ccc_1);title('MFCC');ylabel('幅值');
	% [h,w]=size(ccc);
	% A=size(ccc);
	% subplot(212)    
	% plot([1,w],A);
	% xlabel('维数');
	% ylabel('幅值');
	% title('维数与幅值的关系')


end

	