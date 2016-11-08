load('knndata_all.mat')% data_dtw_train data_dtw_test label_dtw_train label_dtw_test model
%data_dtw_train_len data_dtw_test_len
codebook = zeros(20,50,16);
tr = zeros(20,10,10);
em = zeros(20,10,50);
for i = 1:20
	trans = rand(10);
	emis=  rand([10,50]);
	x = i;
	current = data_dtw_train(i,1:num_train(i),1:200,:);
	flat = reshape(current,[1,size(current,3)*size(current,2)*size(current,4)]);
	x= reshape(flat, [size(current,2)*200,16])';
	flat = reshape(x,[1,size(current,3)*size(current,2)*size(current,4)]);
	[cb,distortion,ind] = vq(flat,16,50,0.15);
	index = reshape(ind,[size(current,2),200]);
	seq = index(1,1:data_dtw_train_len(i,1))
	seqs = {seq}
	for j = 2:size(current,2)
		seqs = [index(j,1:data_dtw_train_len(i,j)) seqs]
	end
	[estTR,estE] = hmmtrain(seqs,trans,emis,'Tolerance',1e-3);
	tr(i,:,:) = estTR;
	em(i,:,:) = estE;
	codebook(i,:,:) = cb;
	

	
end
filename = 'model'
save(filename, 'tr', 'em', 'codebook','seqs')


