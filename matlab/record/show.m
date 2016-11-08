Time = 2;
FS = 8000;
nBits = 16;
recObj = audiorecorder(FS, nBits, 1);
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
while True
disp('Start speaking.')
recordblocking(recObj, Time);
disp('End of Recording.');
myRecording = getaudiodata(recObj);
display(Word{knn()})
display(Word{hmm()})
a = input('Is the result true? 1:True 2:not True');
end