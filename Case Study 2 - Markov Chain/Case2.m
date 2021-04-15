%Case2 
l = 16;  %demand rate per day
m = 12;  %production rate of each machine
k = 100;    
h = 9;
cb = 8;
c1 = 20;
cp = 20;
pr = 80;
profit = 0;
aaPROFIT = 0;   %optimal value of profit
for b = 0:20
    for s = 0:50
        for s2 = -b+1:s-2
            for s1 = -b+2:s-1
                
                a = zeros(b+2*s-s1,b+2*s-s1);   %matrix of the coefficients of pi values
                
                a(1,1) = 2*m;
                a(1,2) = -l;
                
                for j = 2:b+s2
                    a(j,j-1) = 2*m;
                    a(j,j) = -2*m-l;
                    a(j,j+1) = l;
                end
                
                a(b+s2+1,b+s2) = 2*m;
                a(b+s2+1,b+s2+1) = -m-l;
                a(b+s2+1,b+s2+2) = l;
                
                for j = b+s2+2:b+s1
                    a(j,j-1) = m;
                    a(j,j) = -m-l;
                    a(j,j+1) = l;
                end
                
                a(b+s1+1,b+s1) = m;
                a(b+s1+1,b+s1+1) = -l-m;
                a(b+s1+1,b+s1+2) = l;
                a(b+s1+1,b+2*s-s1) = l;
                
                for j = b+s1+2:b+s-1
                    a(j,j-1) = m;
                    a(j,j) = -l-m;
                    a(j,j+1) = l;
                end
                
                a(b+s,b+s-1)= m;
                a(b+s,b+s) = -l-m;
                
                a(b+s+1,b+s) = m;
                a(b+s+1,b+s+1) = -l;
                
                for j = b+s+2:b+2*s-s1-1
                    a(j,j-1) = l;
                    a(j,j) = -l;
                end
                
                for j = 1: b+2*s-s1
                    a(b+2*s-s1,j) = 1;
                end
                
                aa = zeros(b+2*s-s1,1);        
                aa(b+2*s-s1,1) = 1;
                
                p = linsolve(a,aa);     %pi values
                
                tot1 = 0;       %tot's are for sum calculations
                for i = 1:b+s2
                    tot1 = tot1 + p(i);
                end
                
                tot2 = 0;
                for i = b+s2+1:b+s
                    tot2 = tot2 + p(i);
                end
                
                tot3 = 0;
                for i = b+1:b+s+1
                    tot3 = tot3 + p(i)*(i-b-1);
                end
                
                tot4 = 0;
                for i = b+s+2:b+2*s-s1
                    tot4 = tot4 + p(i)*(-i+2*s+b+1);
                end
                
                tot5 = 0;
                for i = 1:b
                    tot5 = tot5 + p(i)*(-i+b+1);
                end
                
                profit = pr*l*(1-p(1)) - (  k*l*p(2*s+b-s1) + cp*(2*m*tot1+m*tot2) + h*(tot3+tot4) + cb*tot5 + c1*p(1)*l  );
               
                if(profit > aaPROFIT) %if better than the last optimal, update optimal values
                    aaPROFIT = profit;
                    aaB = b;
                    aaS2 = s2;
                    aaS1 = s1;
                    aaS = s;
                    aaP = zeros(aaB+2*aaS-aaS1,1);
                    for i = 1:aaB+2*aaS-aaS1
                        aaP(i,1) = p(i);
                    end
                end
            end
        end
    end
end

parta = 0;
for i = aaB+aaS+1:aaB+2*aaS-aaS1
    parta = parta + aaP(i);
end

partb = 0;
for i = aaB+aaS2+1:aaB+aaS
    partb = partb + aaP(i);
end

partc1 = 0;
for i = 1:aaB+aaS2
    partc1 = partc1 + aaP(i);
end
partc2 = 0;
for i = aaB+aaS2+1:aaB+aaS
    partc2 = partc2 + aaP(i);
end
partc = partc1 + partc2/2;

partd1 = 0;
for i = aaB+1:aaB+aaS+1
    partd1 = partd1 + aaP(i)*(i-aaB-1);
end
partd2 = 0;
for i = aaB+aaS+2:aaB+2*aaS-aaS1
    partd2 = partd2 + aaP(i)*(-i+2*aaS+aaB+1);
end
partd = partd1 + partd2;

parte = 0;
for i = 1:aaB
    parte = parte + aaP(i)*(-i+aaB+1);
end

partf = aaPROFIT;



