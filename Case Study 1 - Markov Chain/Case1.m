% Case Study 1
[num,text,raw] = xlsread("Transition_Matrix_b");
a = num^99;  % Steady state
for i=1:13
    p(i) = a(1,i);  % Pi values
end
s = [0 0 0;   % States
    1 0 0;
    0 1 0;
    0 0 1;
    1 1 0;
    1 0 1;
    0 1 1;
    2 0 0;
    0 2 0;
    0 0 2;
    2 1 0;
    2 0 1;
    0 2 1];
r = [3.0 4.5 5.9;  % Man-hour requirements
    4.4 3.8 5.3];
% Question 1
W1 = zeros(13,1); 
W2 = zeros(13,1);
TotalW1=0; % Expected daily workload of the repairman with skill 1
TotalW2=0; % Expected daily workload of the repairman with skill 2
for i = 1:13
    for   j = 1:3
        W1(i,1) = W1(i,1) + s(i,j)*r(1,j);
        W2(i,1) = W2(i,1) + s(i,j)*r(2,j);
    end
    W11(i,1)=min(W1(i,1),8);
    W21(i,1)=min(W2(i,1),8);
    TotalW1=TotalW1+p(i)*W11(i,1);
    TotalW2=TotalW2+p(i)*W21(i,1);
end
% Question 2
Temp1 = zeros(13,1); 
Temp2 = zeros(13,1);
TotalTemp1=0; % Expected daily workload of the temporary workers for skill 1
TotalTemp2=0; % Expected daily workload of the temporary workers for skill 2
for i = 1:13
    Temp1(i,1) = W1(i,1)-8;
    Temp2(i,1) = W2(i,1)-8;
    Temp11(i,1)= max(Temp1(i,1),0);
    Temp21(i,1)= max(Temp2(i,1),0);
    TotalTemp1=TotalTemp1+p(i)*Temp11(i,1);
    TotalTemp2=TotalTemp2+p(i)*Temp21(i,1);
end
TotalTemp = TotalTemp1+TotalTemp2; % Expected daily workload of the temporary workers
% Question 3
N1 = 0; % Expected number of cars in a day under operation 1
N2 = 0; % Expected number of cars in a day under operation 2
N3 = 0; % Expected number of cars in a day under operation 3
for i = 1:13
    N1 = N1 + s(i,1)*p(i);
    N2 = N2 + s(i,2)*p(i);
    N3 = N3 + s(i,3)*p(i);
end
% Question 4
NC = N1 + N2 + N3; % Expected total number of cars
% Question 5
AR = p(2) + p(5) + p(6) + p(8) + p(11) + p(12); % Acceptance rate to repair shop
% Question 6
ET = 1/AR; % Expected time between two admissions
% Question 7
FR = N1*0.3+N2*(0.2)+ N3*( 0.05); % Expected number of cars failed to repair
SR = N3 - N3*0.05; % Expected number of cars succesfully repaired
Profit = SR*800 - ((TotalW1+TotalW2)*10 + TotalTemp*12 + FR*100); % Expected daily profit

fprintf("Question 1:\n%f \n%f\n" , TotalW1, TotalW2);
fprintf("Question 2:\n%f\n" , TotalTemp);
fprintf("Question 3:\n%f \n%f \n%f\n" , N1, N2, N3);
fprintf("Question 4:\n%f\n" , NC);
fprintf("Question 5:\n%f\n" , AR);
fprintf("Question 6:\n%f\n" , ET);
fprintf("Question 7:\n%f\n" , Profit);