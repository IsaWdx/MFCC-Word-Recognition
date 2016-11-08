dir1='D:/Study/SignalProcess4/data/1*.';
dir2=dir(dir1);
max_num_windows = 200;
data = zeros(30,20,20,max_num_windows,24);
datalen = zeros(31,20,20);
word = getWord();
n = 16000;
MH = 0.03;
ML = 0.01;
framelen = 256; % a big window for men 20ms
inc = 80; %  half window 0-1/2 is very ok
zpara = 1.5;
vector = [4,12,1,2,3]
for xx  = 1:length(vector)
	i = vector(xx);
	dirname = dir2(i).name;
	

	for j = 1:20
	j
		newdir = strcat('D:/Study/SignalProcess4/data/',dirname,'/',dirname,'_',word{j},'*.wav');
		wordfiles = dir(newdir);
		if length(wordfiles)<20
			x = 'less file here'
			dirname;
			y = j;
			newdir;

		end
		if length(wordfiles)>20
			x = 'more file here'
			dirname;
			y = j;
			newdir		;	
		end		

		wrong = 0;
		for k = 1:length(wordfiles)			
			filename = strcat('D:/Study/SignalProcess4/data/',dirname,'/',wordfiles(k).name);
			
			[wrong,au] = getCut2(filename,n,MH,ML ,framelen,inc,zpara,badstart,badend);

			mfccco = MFCC(au);
			data(i,j,k,1:size(mfccco,1),:) = mfccco;
			if wrong == 0
			datalen(i,j,k) = size(mfccco,1);
			else 
			datalen(i,j,k) = 0;
			end			
		
		end

	end	

end
save data_end.mat datalen data 

