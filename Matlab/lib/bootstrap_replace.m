function [newpoints]= bootstrap_replace(datapoints, n_samples_desired)
if nargin<2,
  n_samples_desired = size(datapoints,1);
end;

n_samples = size(datapoints,1);
selected_centroids = floor(rand(1,n_samples_desired)*n_samples)+1; 
newpoints = datapoints(selected_centroids',:);