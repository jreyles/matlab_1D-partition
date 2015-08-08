function [opt lastchange optchangepoints] = MainCPcombined_weight(weight,N,utility,celldata)
%MAINCPCOMBINED_WEIGHT(weight,N,utility,celldata)
%   Given a utility function utility(weight, celldata,j,n) that calculates
%   the utility of data cells j..n in a single block, finds
%   the optimal partition on the interval of N data cells.

%% Step 1: Find optimal parition on N event data and record the position of
%% optimal partition at each index into the array 'lastchange' 
for n=1:N
    for j=1:n
        if j==1 
            max = utility(weight,celldata,1,n);
            lastchange(n)=1;
        else if opt(j-1)+utility(weight,celldata,j,n) > max; 
            max = opt(j-1)+utility(weight,celldata,j,n);
            lastchange(n)= j;
            end
        end
    end
    opt(n)= max; 
end

%% Step 2: Store the changepoints(the first cell of the last block) of the
%% optimal parition into the array 'optchangepoint'
j=lastchange(N);
optchangepoints = [j];
while j>1
j=lastchange(j-1);
optchangepoints=[j optchangepoints];
end