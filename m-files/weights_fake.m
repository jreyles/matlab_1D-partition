%function: WEIGHT_FAKE
%WEIGHT takes in event data text file, distributes evenly spaced fake data
%through out the event data, assigns each actual event data point
%weight 1 and each fake event weight 0 and outputs the vector 'weight'
%containing the weights of each data point respectivley. Deletes
%repeated data in vector 'E' and updates coressponding weights and deletions 
%in vector 'weight'. Stores the new data with evenly dispursed fake
%data as a text file 'weights.txt'



%Input: filename = event data text file,
%       storedfilename = text filename to be stored.
function [weight] = weights_fake(filename,storedfilename)
%Open event data text file and store as vector 'A'. Store the length of 'A'
%as 'L'
fid=fopen(filename);
A=fscanf(fid, '%f', [1 inf]);
fclose(fid);

L=length(A);

%Create evenly dispursed fake data, combine it with 'A' and index the sorting
%of the combine vector. Store sorted and combined data as vector 'E' and the
%index change after sorting as vector 'IE'.
fake_data=[A(1):.0001:A(L)]
combine=[A fake_data];
[E IE]=sort(combine);

%Assign each data point in vector 'E' a weight. Actual event data is
%weighted 1 and fake data is weighted zero. Vector 'weight' is outputted.
for i=1:length(IE)
    if IE(i) > L;
     weight(i)=0;
    else weight(i)=1;
    end
end
%Go through the array combined E and take out the repeated data 
%Update the corresdponding weight 
j=1;
while j<length(E)
    key = E(j);
    k=j+1;
    while k<=length(E)&& key == E(k)
        weight(j)=weight(j)+weight(k);
        E(k)=[];
        weight(k)=[];
    end
    j=j+1;
end 



%Store the new sorted vector E as a textfile 'storedfilename'. 
fid=fopen(storedfilename, 'w');
fprintf(fid, '%f\n', E);
fclose(fid);




