n = floor(10.^linspace(1,3.5,30));
%n = floor(linspace(10,10^4,30));

N = 10;

times = zeros(4,length(n));

L0 = tril(genDiagDomMat(n(end)));

%n=floor(sqrt(n));
%L0 = tril(gallery('poisson',n(end)));

b0 = rand(n(end),1);

for k=1:length(n)
    L=L0(1:n(k),1:n(k));
    b=b0(1:n(k));
    for j = 1:N
        tic;
        vorSubsV1(L,b);
        times(1,k)=times(1,k)+toc;

        tic;
        vorSubsV2(L,b);
        times(2,k)=times(2,k)+toc;

        tic;
        vorSubsV3(L,b);
        times(3,k)=times(3,k)+toc;

        tic;
        L\b;
        times(4,k)=times(4,k)+toc;
    end
end
times = times./N;

plot(n,times);
legend('V1','V2','V3','V4','inbuild');