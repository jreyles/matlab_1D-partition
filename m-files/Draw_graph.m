function [  ] = Draw_graph( filename,n,optchangepoint )
%%%%%% DRAW_GRAPH The function reads in event data and graph the event rate 
%%%%%%%%%%%%%%%%% into blue bars. Then, it graphs the optimal partions,
%%%%%%%%%%%%%%%%% indicated by thick red lines on the same graph. 

%%%%% Step 1: 
% Read original event data into matrix A
fid=fopen(filename);
A=fscanf(fid,'%f',[1 inf]);
fclose(fid);
A=sort(A); 
% Let Tmin = smallest time that appears in event data
Tmin=A(1);
% and Tmax= largest time the appears in event data 
L=length(A);
Tmax=A(L);

%%%%% Step 2: Draw binned bar graph of original data
% Divide interval [Tmin,Tmax] into n (user defined) subintervals 
% of width deltaT
deltaT=(Tmax-Tmin)/n;
% On interval k in 1:n, count number of events m occurring between
% time Tmin + (k-1)*deltaT and Tmin + k*deltaT
i=1;
H=Tmin; % Initialize array of horizontal position 
for k=1:n
    m(k)=0; %Initialize the number of events at the subinterval k 
    while i<=L && A(i)>=Tmin+(k-1)*deltaT && A(i)<=Tmin+k*deltaT
        m(k)=m(k)+1; % Update the number of events at the subinterval k 
        i=i+1;
    end
    H=[H Tmin+(k)*deltaT]; % Update array of horizontal position 
end
H=H(1:n);
% Draw histogram bar at height m/delta T, horizontal position
% Tmin + (k-1)*deltaT, width deltaT.
bar(H,m/deltaT);
hold; 

%%%%% Step 3: Draw red lines representing blocks of optimal partition
% For each block in the optimal partition:
% Find the beginning and end times of the block 
optchangepoint=[optchangepoint L]
L2=length(optchangepoint); 
optchange=A(optchangepoint(1)); 
for j=2:L2-1
    optchange=[optchange A(optchangepoint(j)) A(optchangepoint(j))];
end
optchange=[optchange A(optchangepoint(L2))];
% For a block going from Tstart to Tend, containing m events, 
% let rate = m/(Tend-Tstart) 
rate=[(optchangepoint(2:L2)-optchangepoint(1:L2-1)+1)./(A(optchangepoint(2:L2))-A(optchangepoint(1:L2-1)))];
block=[];
for i=1:L2-1
    block=[block rate(i) rate(i)];
end
%  Draw a red line from (Tstart,rate) to (Tend,rate)
plot(optchange,block,'red', 'LineWidth',3); 
hold;

end

