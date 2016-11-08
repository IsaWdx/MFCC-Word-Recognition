load('knndata.mat')% data_dtw_train data_dtw_test label_dtw_train label_dtw_test model
%data_dtw_train_len data_dtw_test_len
load('model_953.mat')
alphabet = size(codebook,2);
percent = zeros([1,20]);
wrong = zeros([1,20]);
right = zeros([1,20]);
for i = 1:20
i
	%for k = 1:size(data_dtw_test,2)
	for k = 1:size(data_dtw_test,2)
	%i,k,right,wrong;
		current = reshape(data_dtw_test(i,k,:,:),[200,16]);
		%current = reshape(data_dtw_train(i,k,:,:),[200,16])
		mindistort = 11111111;
		result = 1;
		for j = 1:20				
			cj = reshape(codebook(j,:,:),[size(codebook,2),size(codebook,3)]);
			current;
			x =reshape(current',[1,size(current,1)*size(current,2)]);
			[id,distort] = fitvq( x ,16,cj,alphabet);

			if mindistort>distort
				mindistort = distort;
				result = j;
			end		
		end
	%	break
		if label_dtw_test(i,k)==i
			if result== i
				right(i)=right(i)+1;
			else
				wrong(i)=wrong(i)+1;
			end
		end
	%	break
		end
	%break
	percent(i) = right(i)/(wrong(i)+right(i));
end

save vqtest.mat wrong right percent

  
假设参考模板的特征矢量为：\(X={1,2,…, }\)，输入语音特征矢量序列为：\(Y={1,2,…, }\),\(I≠J\)。
设时间归正函数为：\(C={c(1),c(2),…,c(N)}\)，N为路径长度，\(c(n)=(i(n),j(n))\),表示第n个匹配点对，距离d(x_i(n) ,j_(n) )\)称为局部距离；
DTW算法：寻找一个最佳时间归正函数，使得待测语音的时间轴j非线性地映射到参考模板的时间轴i上，使得总失真最小：