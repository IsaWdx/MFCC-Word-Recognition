function [amp,framesize] = getAmp(au,framelen, inc)
	frames = enframe(au(1:end),framelen,inc);
	amp = sum((abs(enframe(au, framelen, inc))).^2, 2);	
	maxamp = max(amp);
	amp = amp ./maxamp;
	framesize = size(frames,1);
	%framesize

end
