function [  ] = Draw_graph_weight_superimposed_user( filename,n, K, weight)
%%%%%% DRAW_GRAPH_WEIGHT The function reads in event data and graph the event rate 
%%%%%%%%%%%%%%%%% into blue bars. It will automatically remove any event with
%%%%%%%%%%%%%%%%% weight of 0. Then, it graphs K optimal partions from 
%%%%%%%%%%%%%%%%% K different algorithms with different colors 
%%%%%%%%%%%%%%%%% K ranges from 1 to 10.For n, use the total number of data
%%%%%%%%%%%%%%%%% values.  

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
        if weight(i)>0  % Take out fake event 
             m(k)=m(k)+1; % Update the number of events at the subinterval k 
        end
        i=i+1;
    end
    H=[H Tmin+(k)*deltaT]; % Update array of horizontal position 
end
H=H(1:n);
% Draw histogram bar at height m/delta T, horizontal position
% Tmin + (k-1)*deltaT, width deltaT.
vlines=bar(H,m/deltaT);
%set legend for Event Data
set(vlines,'Displayname','Event Data');
legend('Location','north');
hold;


%%%%% Step 3: Draw different color lines representing blocks of optimal
%%%%% partitions
% For each block in the optimal partition:
% Find the beginning and end times of the block 

%%start loop here for j=1:k

for l=1:K
    optchangepoint1=input('Enter optchangepoint: ');
color=['rgmyck'];
%ask user to input optchangepoint
%plot using entire code below (not including hold)
optchangepoint1=[optchangepoint1 L];
L2=length(optchangepoint1); 
optchange=A(optchangepoint1(1)); 
for j=2:L2-1
    optchange=[optchange A(optchangepoint1(j)) A(optchangepoint1(j))];
end
optchange=[optchange A(optchangepoint1(L2))];
% For a block going from Tstart to Tend, containing m events, 
% let rate = m/(Tend-Tstart) 
rate=[]; 
V=[];
B=[];
for i=1:L2-1
    V= [V sum(weight(optchangepoint1(i):(optchangepoint1(i+1)-1)))];
    B= [B A(optchangepoint1(i+1)-1)-A(optchangepoint1(i))];
    rate=[rate V(i)./B(i)];
    end 
display(rate); 
block=[];
for i=1:L2-1
    block=[block rate(i) rate(i)];
end
%  Draw a color(i) line from (Tstart,rate) to (Tend,rate)

%set legends for each optimal changepoint 
hlines=plot(optchange, block, color(l), 'LineWidth', 2); 
set(hlines,'Displayname',['Optimal Changepoint from algorithm ',num2str(l)]);
legend('Location','north');
end 
hold;

%Step 4: Add Title to the graph 
title(['Graph of ',num2str(K),' optimal partitions'],'FontWeight','Bold'); 
xlabel('Event Data (time)');
ylabel('Event rate');

end


