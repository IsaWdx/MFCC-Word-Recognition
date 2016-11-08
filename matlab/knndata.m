load('data_end.mat')
%data = zeros(31,20,20,max_num_windows,24)
size(data)
%for i = 1:20
%	figure(5)
%	plot(reshape(datalen(:,i,:),[size(datalen,1),size(datalen,3)]))
%	
%end
model= zeros(20,200,16);
data_dtw_train_len = zeros(20,1);
data_dtw_test_len = zeros(20,1);

total_train = 450;
data_dtw_train = zeros(20,1,200,16);%num sample
data_dtw_test = zeros(20,1,200,16);%numtests
label_dtw_train = zeros(20,1);%num sample
label_dtw_test = zeros(20,1);%numtest

num_train = zeros(20)
num_test = zeros(20);
for j = 1:20
	count_train = 1;
	count_test = 1;
	for i = 1:24
		x= strcat('word',int2str(j),'ren',int2str(i))
		if i<=22
			for k = 1:25
				piece = reshape(data(i,j,k,:,:),[200,24]);
				piecelen = datalen(i,j,k);			

					piece = piece(1:200,1:16);%peicelen
					size(piece);			
					data_dtw_train(j,count_train,:,:) = piece;
					label_dtw_train(j,count_train)= j;%num sample
					data_dtw_train_len(j,count_train)= datalen(i,j,k);
					count_train = count_train+1;		
				

			end
		else
			for k = 1:25
				piece = reshape(data(i,j,k,:,:),[200,24]);
				piecelen = datalen(i,j,k);			
				
					piece = piece(1:200,1:16);%peicelen
					size(piece);			
				
				data_dtw_test(j,count_test,:,:) = piece;
				data_dtw_test_len(j,count_test)= datalen(i,j,k);
				label_dtw_test(j,count_test) = j;%num sample
				count_test=1+count_test;

			end
		end

	end
	num_test(j) = count_test-1;
	num_train(j) = count_train-1;
end
num_test
num_train
save knndata_end.mat data_dtw_train data_dtw_test label_dtw_train label_dtw_test model  num_train num_test data_dtw_train_len data_dtw_test_len





