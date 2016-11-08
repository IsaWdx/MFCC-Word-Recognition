load('knndata.mat')

train_x = reshape(data_dtw_train,[size(data_dtw_train,1)*size(data_dtw_train,2),200,16]);
train_y = reshape(label_dtw_train,[1,size(data_dtw_train,1)*size(data_dtw_train,2)]);

test_x = reshape(data_dtw_test,[size(data_dtw_test,1)*size(data_dtw_test,2),200,16]);
test_y = reshape(label_dtw_test,[1,size(label_dtw_test,1)*size(label_dtw_test,2)]);
pred_y = KNN_TS(train_x, train_y, test_x, 10, [1,3,5,10]);
size(data_dtw_test,1)
size(data_dtw_test,2)
pred_k = zeros([4,size(data_dtw_test,1),size(data_dtw_test,2)]);
percent = zeros([20,4]);
wrong = zeros([20,4]);
right = zeros([20,4]);
for j = 1:4
	pred_k(j,:,:) = reshape(pred_y(j,:,:),[size(data_dtw_test,1),size(data_dtw_test,2)]);
	for i= 1:20
		for m = 1:size(data_dtw_test,2)
			%if label_dtw_test(i,m) == 0
			%	x = '1'
			%	continue;
			%end
			if pred_k(j,i,m)==i
				right(i,j)=right(i,j)+1;
			else
				wrong(i,j)=wrong(i,j)+1;
			end
		end
	percent(i,j) = right(i,j)/(right(i,j)+wrong(i,j));
	end
end


save knn_result.mat percent right wrong



		