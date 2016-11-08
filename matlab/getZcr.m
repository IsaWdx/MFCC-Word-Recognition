function zcr = getZcr(au, framelen, inc)

%计算平均过零率z0
%TO DO 如何选择过零率系数 这个地方做的不太好
%[a,Fs] = audioread('void.wav'); 
%a = a/max(abs(au));
%tmp1 = enframe(a(1:end-1),framelen,inc);
%tmp2 = enframe(a(2:end),framelen,inc);
%signs = (tmp1.*tmp2)<0;
%diffs = (tmp1 - tmp2)>0.01;
%zcr = sum(signs.*diffs,2);
%z0 = sum(zcr')/size(zcr,1);


%计算过零率
tmp1 = enframe(au(1:end-1),framelen,inc);
tmp2 = enframe(au(2:end),framelen,inc);
signs = (tmp1.*tmp2)<0;
diffs = (tmp1 - tmp2)>0.0001;
zcr = sum(signs.*diffs,2);
zcr = sum(signs.*diffs,2);

end





