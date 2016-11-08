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
		maxprob = -11111111;
		result = 1;
		for j = 1:20
			%[ds,ix,newpiece] = dtw_metric(reshape(model(j,:,:),[200,16]),current,1);
			%newpiece = newpiece';
			%size(newpiece);
			
			cj = reshape(codebook(j,:,:),[size(codebook,2),size(codebook,3)]);
			
			%id = fitvq(  reshape(newpiece,[1,size(newpiece,1)*size(newpiece,2)]),16,cj,alphabet);
			current;
			x =reshape(current',[1,size(current,1)*size(current,2)]);
			id = fitvq( x ,16,cj,alphabet);
			
			id = reshape(id,[1,200]);
			%print id 看看
			%data_dtw_test_len(i,k);
			id = id(1,1:data_dtw_test_len(i,k)-10);
			%id = id(1,1:data_dtw_train_len(i,k))
			ej = reshape(em(j,:,:),[size(em,2),size(em,3)]);
			tj = reshape(tr(j,:,:),[size(tr,2),size(tr,3)]);
			[prob,logpseq]= hmmdecode(id,tj,ej);
			logpseq;
			prob;
			j;
			if logpseq>maxprob
				maxprob = logpseq;
				result = j;
			end
		
		
		end
		%break
		if label_dtw_test(i,k)==i
			if result== i
				right(i)=right(i)+1;
			else
				wrong(i)=wrong(i)+1;
			end
		end
		%break
		end
	%break
	percent(i) = right(i)/(wrong(i)+right(i));
end

save hmmtest.mat wrong right percent

  