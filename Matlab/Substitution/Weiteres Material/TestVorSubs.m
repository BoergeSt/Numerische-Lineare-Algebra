n=100;
k = 1000;

for i = 1:k
    L = tril(genDiagDomMat(n));
    %L = tril(gallery('poisson',floor(sqrt(n))));
    x_sol = rand(n,1)*2-1;
    b = L*x_sol;
    %x = vorSubsV1(L,b);
    %x = vorSubsV2(L,b);
    x = vorSubsV3(L,b);
    %x = vorSubsV4(L,b);
    
    error = abs(x-x_sol);
    error = norm(error,'inf');
    if issparse(L)
        plot(condest(L),error,'x');
    else
        plot(cond(L),error,'x');
    end
    hold on;
end
hold off 