function [index,sum_distortion_min]=fitvq(training_seq,dimension,codebook,codebook_size)
m=round(length(training_seq)/dimension);
m;
size(training_seq);
training_seq;
sum_distortion_min = 0;
if (m*dimension-length(training_seq)<0)
  error('length of training_seq is not a multiple of dimension')
end
for i=1:m
  training_seq_block=training_seq(1,(i-1)*dimension+1:i*dimension);
  training_matrix(i,:)=training_seq_block;
  distortion_block=[ ];
  for j=1:codebook_size;
    distort=sum((training_seq_block-codebook(j,:)).^2);
    distortion_block=[distortion_block distort];
  end
  [distortion_min,ind]=min(distortion_block);
sum_distortion_min  = sum_distortion_min +distortion_min;
  index(i)=ind;
end
index;
