load('data_label.mat'); 
features_sparse = sparse(data); % features must be in a sparse matrix
libsvmwrite('data_label.train', label, features_sparse);
%svmscale
libsvmwrite('data_label.train', label, features_sparse)
model = svmtrain(label, features_sparse, '-c 1.2 -g 0.07');


load('test_data_label.mat'); % read a csv file
features_sparse = sparse(test_data); % features must be in a sparse matrix
[predicted_label, accuracy, decision_values] = svmpredict(test_label, features_sparse, model);
predicted_label
accuracy


