function [V] = utility_event_weight(weight,celldata,j,n)
%UTILITY_EVENT Takes in weight and celldata vectors to compute the score of
%   blocks j to n 

% Calculate N, the number of real events from block j to n using weight
% vector
N=sum(weight(j:n));
% Calculate the length a by summing the widths of the j to n blocks 
a=sum(celldata(j:n));
% Calculate the score of the block j to n using betaln function to Time To
% Event (TTE) data with paramaters N+1 and a-N+1 
V=betaln(N+1,a-N+1);

end

