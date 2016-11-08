load('knndata_end.mat')
badstart = 1;
badend=0;

train_x = reshape(data_dtw_train,[size(data_dtw_train,1)*size(data_dtw_train,2),200,16]);
train_y = reshape(label_dtw_train,[1,size(data_dtw_train,1)*size(data_dtw_train,2)]);
% 录音录2秒钟
Time = 2;

% 输入你的学号
Id = '13307130444';

% 输入你录的单词名

%参数
max_num_windows = 200;
data = zeros(31,20,20,max_num_windows,24);
datalen = zeros(31,20,20);

n = 16000;
MH = 0.03;
ML = 0.01;
framelen = 256; % a big window for men 20ms
inc = 80; %  half window 0-1/2 is very ok
zpara = 1.5;

Word = getWord();

FS = 8000;
nBits = 16;
recObj = audiorecorder(FS, nBits, 1);
a= 1;
cnt = 0;
data = zeros(1,max_num_windows,16);
while 	a ==1
		cnt=cnt+1;
		disp(strcat('Start speaking. number',num2str(cnt)))
		recordblocking(recObj, Time);
		disp('End of Recording.');
		myRecording = getaudiodata(recObj);
		filename = strcat(Id, '_');
		filename = strcat(filename,num2str(cnt,'%02d')); 
		%datestr(now, 30));
		filename = strcat('D:\Study\SignalProcess4\src\display\',filename, '.wav');
		audiowrite(filename, myRecording, FS);
		pred_data = zeros(200,16);
		%sound(myRecording,8000);
		[wrong,au] = getCut('x',n,MH,ML ,framelen,inc,zpara,badstart,badend,myRecording);
		MFCCco = MFCC(au);
		pred_data(1:size(MFCCco,1),1:16) = MFCCco(:,1:16);
		
		data(cnt,:,:) = pred_data;
		pred_y = KNN_TS(train_x, train_y, reshape(pred_data,[1,200,16]), 10, [1,3,5,10]);
		
		%	Word{pred_y(1)}
		%Word{pred_y(2)}
		Word{pred_y(3)}
		%Word{pred_y(4)}
		x = input('continue? 1:yes 2:no');
		
		if x==2
		a = 2;
		else
		a = 1;
		end
		
		
end


save test1 data



		