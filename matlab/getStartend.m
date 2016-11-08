function [start, endp] = getStartend(framesize, zcr, amp, framelen, inc , z0, MH, ML,badstart,badend)
	startMH = 0;
	startML = 0;
	endMH = 16000;
	endML = 16000;
	startZV = 0;
	endZV = 16000;
	
	gs = 1;
	ge = 1;
	if badstart ==1
		gs = 20;
	end
	if badend == 1
		ge = 5;
	else if badend == 2
		ge = 10;
		end
	for i = gs: framesize
		if amp(i) >= MH 
			startMH = i;
			startMHV = inc*i+1;
			%50th of this frame, however it is approximately the same as the beginning
			break;
		end
	end
	
	
	
	%%out
	for i = ge: framesize
		if amp(framesize-i+1) >= MH && amp(framesize-i) >= MH 
			endMH = framesize-i+1;
			endMHV = inc*(framesize-i+1)+1;
			%50th of this frame, however it is approximately the same as the beginning
			break;
		end
	end
		

	for i = 1: startMH
		if amp(startMH-i+1) >= ML
			startML = startMH-i+1;
			startMLV = inc*(startMH-i+1)+1;
			%50th of this frame, however it is approximately the same as the beginning
			break;
		end
	end
	for i = endMH:framesize
		if amp(i) < ML	
			endML = i;
			endMLV = inc*i+1;%50th of this frame, however it is approximately the same as the beginning
			break;
		end
	end
	startZ =-1;
	endZ = -1;
	
	for i = 1: 4%one window for 50
		if startML - i<1
		startZ = 1;
		startZV = 1;
		break
		end
		if zcr(startML - i) <= z0
			startZ = startML - i +1;
			startZV = inc*(startML - i +1)+1;%50th of this frame, however it is approximately the same as the beginning
			break;
		end
	end
	for i = endML:endML+4
		if i>size(zcr,1)
		endZ = size(zcr,1);
		endZV = 16000;
		break
		end
		if zcr(i) <= z0
			endZ = i;
			endZV = inc*i+1;%50th of this frame, however it is approximately the same as the beginning
			break;
		end
	end

	if startZ == -1
		i=startML-4;
		startZ =i;
		startZV = inc*i+1;
		end
		
	if endZ == -1
		i=endML+4;
		endZ =i;
		endZV = inc*i+1;
		end
	
	start = startZV;
	endp = endZV;

end
	




