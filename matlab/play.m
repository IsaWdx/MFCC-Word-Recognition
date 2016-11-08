% 输入你的学号
Id = '13307130444';

% 输入你录的单词名
Word = {
  '数字',
  '语音',   
  '信号',
  '分析',
  '识别', 
 '北京',
 '背景',
 '上海',   
 '商行', 
 '复旦',
 'Speech', 
 'Voice',
 'Sound', 
 'Happy',  
 'Lucky', 
 'File',
 'Open', 
 'Close', 
 'Start', 
 'Stop'};
Time = 2;
FS = 8000;
nBits = 16;
recObj = audiorecorder(FS, nBits, 1);

for j = 1:20
	
	item = Word{j};
	for i = 1:20
	%if i == 1
		disp(strcat(strcat('Playing ',num2str(i)),item));
		filename = strcat(Id, '_');
		filename = strcat(filename, item);
		filename = strcat(filename, '_');
		filename = strcat(filename,num2str(i',%02d')); 
		filename = strcat(filename, '.wav');
		
		while(true)
		[y Fs] = audioread(filename);
		sound(y,Fs);
		a = input('Is it ok? 1:ok 2:not ok');
		if (a == 2)
			disp(strcat(strcat('Start speaking.',num2str(i)),item))
			recordblocking(recObj, Time);
			disp('End of Recording.');
			myRecording = getaudiodata(recObj);
			audiowrite(filename, myRecording, FS)
		else
			break;
		end
		end
	%end
	end
end
