a = [-2:-1,1:2];
b = -20:-1;
c = -400:45;
d = -40:85;

C = combvec(a,b,c,d);  % Get all combinations

n = size(C,2);
disp(n);

C_valid = zeros(100,4);
j = 1;

h = waitbar(0, 'Starting');
s = clock;

t1 = clock;
inc = 10000;
%tic;

for i = 1:n

    a = C(1,i);
    b = C(2,i);
    c = C(3,i);
    d = C(4,i);

    if check_cubic(a,b,c,d)

        C_valid(j,:) = C(:,i);   % Store valid polynomial
        
        j = j + 1;
    end

    if mod(i,inc) == 0
  
        %h = waitbar(i/n,h,['remaining time =',num2str(estimated_min-(etime(clock,s)/60)),'min']);

            is = datetime(clock)-datetime(s);
            esttime = is * (n/i);

        h = waitbar(i/n,h,['remaining time = ',char(esttime-(datetime(clock)-datetime(s)))]);
    end
end

close(h)

C_valid = C_valid(1:j-1,:)

function [res,f_roots,ff_roots,fff_roots] = check_cubic(a,b,c,d)

    res = false;

    ff_roots = [];
    fff_roots = [];

    f_roots = roots([a b c d]);
    
    if isreal(f_roots) && length(unique(f_roots)) == 3                                  % 1 Three  roots of f(x)
        if all(mod(f_roots,1) == 0)                                        % 2 Check all integer roots of f(x)
            if all(mod(polyval([a,b,c,d],f_roots),1) == 0)                 % 3 All f(root) is integer

                ff_roots = roots([3*a,2*b,c]);

                if isreal(ff_roots) && length(unique(ff_roots)) == 2                           % 1 The  roots of f'(x)
                    if all(mod(ff_roots,1) == 0)                           % 2 Check all integer roots of f'(x)
                        if all(mod(polyval([3*a,2*b,c],ff_roots),1) == 0)  % 3 All f'(root) is integer

                            fff_roots = roots([6*a,2*b]);

                            if isreal(fff_roots) && length(isreal(unique(fff_roots))) == 1                          % 1 The  root of f''(x)
                                if all(mod(ff_roots,1) == 0)                           % 2 Check all integer roots of f''(x)
                                    if all(mod(polyval([6*a,2*b],fff_roots),1) == 0)  % 3 All f''(root) is integer

                                          res = true;
 
                                    end
                                end
                            end                
                        end
                    end
                end     
            end
        end
    end
end