%function: WEIGHTS
%WEIGHT takes in event data text file, assigns each data point
%weight 1 and outputs the vector 'weight'
%containing the weights of each data point respectivley. Deletes
%repeated data in vector 'E' and updates coressponding weights and deletions 
%in vector 'weight'. Stores the new data with repeats deleted 
%as a text file 'weights.txt'



%Input: filename = event data text file,
%       storedfilename = text filename to be stored.
function [weight] = weights(filename,storedfilename)
%Open event data text file and store as vector 'A'. Store the length of 'A'
%as 'L'
fid=fopen(filename);
A=fscanf(fid, '%f', [1 inf]);
fclose(fid);

L=length(A);

weight = ones(1,L)

%Go through the vector A and take out the repeated data 
%Update the corresdponding weight. 
j=1;
while j<length(A)
    key = A(j);
    k=j+1;
    while k<=length(A)&& key == A(k)
        weight(j)=weight(j)+weight(k);
        A(k)=[];
        weight(k)=[];
    end
    j=j+1;
end 



%Store the new sorted vector A as a textfile 'storedfilename'. 
fid=fopen(storedfilename, 'w');
fprintf(fid , '%f\n', A);
fclose(fid);




