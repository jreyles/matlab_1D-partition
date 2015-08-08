function [ O lastchange optchangepoint ] = Main_Circle( N,utility, Main_1D, celldata,read, filename,D )
%MAIN_CIRCLE The function will return the optimal parition of a circle
%%%%%%%%%%%% by running the algorithm of 1D problem on all possible
%%%%%%%%%%%% starting point. Then it compares the score of each starting
%%%%%%%%%%%% point and return the largest one as well as the corresponding
%%%%%%%%%%%% optimal partition 

%% Step 1: Calculate optimal parition on the i=1 starting point
[O L C]= Main_1D(N,utility,celldata);
max=O(N); 
lastchange=L;
optchangepoint=C; 
%% Step 2: Calculate the optimal partion on all possible (2:N) starting
%% points and compare each score to choose the 'most fit' optimal partition
for i=2:N 
    % Reconstruct the array data for different ith starting point
    event=read(filename); 
    temp=event(1:i-1);
    event(1:i-1)=[];
    event(N-(i-2):N)=temp;
    event=event*10^D; 
    % Calculate celldata for the ith starting point array 
    celldata=[(event(1)+event(2))/2 (event(3:N)-event(1:N-2))/2 (event(N)-event(N-1))/2];
    % Run 1D algorithm on the ith starting point array 
    [O L C]= Main_1D(N,utility,celldata);
    % Compare the output with the current Max score and make a change to
    % lastchange and optchangepoint if the ouptput is greater than the
    % current Max score  
    if O(N)>=max;
        max =O(N);
        lastchange=L;
        optchangepoint=C;
        %convert optchangepoint with respect to original data 
        optchangepoint=optchangepoint+(i-optchangepoint(1)); 
    end
end
end

