load('data_end.mat')
%data = zeros(31,20,20,max_num_windows,24)
size(data)
%for i = 1:20

model= zeros(20,200,16);
modellen = zeros(1,20);

total_train = 450;
data_dtw_train = zeros(1,200,16);%num sample
data_dtw_test = zeros(1,200,16);%numtests
label_dtw_train = zeros(1);%num sample
label_dtw_test = zeros(1);%numtest

num_train = zeros(20)
num_test = zeros(20)
count_train = 1;
count_test = 1;
for j = 1:20
	for i = 1:30
		x= strcat('word',int2str(j),'ren',int2str(i))
		if i<=22
			for k = 1:25
				piece = reshape(data(i,j,k,:,:),[200,24]);
				piecelen = datalen(i,j,k);			
				
					piece = piece(1:200,1:16);%peicelen
					size(piece);			
					data_dtw_train(count_train,:,:) = piece;
					label_dtw_train(count_train)= j;%num sample
					count_train = count_train+1;
					num_train(j) = num_train(j)+1;
				
	
			end
		else
			for k = 1:25
				piece = reshape(data(i,j,k,:,:),[200,24]);
				piecelen = datalen(i,j,k);			
				
					piece = piece(1:200,1:16);%peicelen
					size(piece);			
				
				data_dtw_test(count_test,:,:) = piece;
				label_dtw_test(count_test) = j;%num sample
				count_test=1+count_test;
				num_test(j) = num_test(j)+1;
		
			end
		end

	end
end
num_test
num_train
save rnndata_end.mat data_dtw_train data_dtw_test label_dtw_train label_dtw_test model modellen num_train num_test






