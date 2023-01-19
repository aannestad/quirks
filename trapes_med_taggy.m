% Integrate e^(0.02x) from 0 to 10:

disp(['Utslipp integral: ', num2str(32.2581*exp(0.031*10) - 32.2581*exp(0.031*0))])

utslipp_sum = 0;

delta_x = 1;

for x = 1:10
    utslipp_sum = utslipp_sum + ((exp(0.031*(x-1)) + exp(0.031*x))/2)*delta_x;
end

disp(['Utslipp sum: ',num2str(utslipp_sum)])

%%

% 5.52 b

rate = 0.031;

utslipp_1975 = 171000;
totalt_utslipp = utslipp_1975;

for i = 1:10
    totalt_utslipp = totalt_utslipp + utslipp_1975*(1+rate)^i;
end

disp(['Totalt_utslipp: ', num2str(totalt_utslipp)])



