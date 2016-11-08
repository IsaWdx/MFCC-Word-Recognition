function [wrong,newau] = getCut(filename,n,MH,ML ,framelen,inc,zpara,badstart,badend,au)%s,x,xx,
		%showfilename = 1;
		
		if filename ~= 'x'
		[au,Fs] = audioread(filename);
		end
		Word = getWord();
		Fs = 8000;
		
		%Student = getStudent();
		%if xx <10
		
		%filename = strcat(strcat(Student{s},'_',Word{x}),'_0',int2str(xx),'.wav');
		%else
		%	filename = strcat(strcat(Student{s},'_',Word{x}),'_',int2str(xx),'.wav');
		%end
		%if showfilename == 0
		%	filename
		%end
		
		au = au / max(abs(au));
		zcr = getZcr(au, framelen, inc);
		z0 = sum(zcr)/size(zcr,1)*zpara;
		[amp,framesize] = getAmp(au, framelen, inc);
		start = 0;
		endp = n;
		[start, endp] = getStartend(framesize, zcr, amp, framelen, inc , z0, MH, ML,badstart,badend);
		start;
		endp;
		size(au);
		sum(zcr);
		wrong = 0;
		if sum(zcr)<700
			wrong = 1;
			
			end
		newau = au(start:endp,:);

		size(newau);
		showplot = 1;
		if showplot ==1
			figure(5);
			title('sound');
			
			subplot(5,1,1),plot(au);		
			grid on;
			subplot(5,1,2),plot([zeros(start,1);newau]);
			axis([0 16000 -1 1]); 
			subplot(5,1,3),plot(newau);
			grid on;
			subplot(5,1,4),plot(zcr);		
			axis([0 framesize 0 50]); 
			grid on;
			subplot(5,1,5),plot([0;amp]);			
			axis([0 framesize 0 1]); 		
			grid on;
			%sound(newau,Fs);
			
			%a = input('Is it ok? 1:ok 2:not ok');
		end
end