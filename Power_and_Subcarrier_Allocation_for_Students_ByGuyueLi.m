

clear all; 
clc;

%%%%%%%%%%%%%%Parameter Setting%%%%%%%%%%%%%%%%%%%%%%
% K = 4; % Number of users
% K1 = 2; % Number of secure users
% N = 10; % Number of subcarriers
% for our given test sample
K = 8; % Number of users
K1 = 4; % Number of secure users
N = 64; % Number of subcarriers


NIte = 1e3;% Number of iterations


C = 0.3*ones(K1,1); % Secure requirement
% a = rand(K,N)*10;  % CNR
load a.mat % use given test sample
b = zeros(K,N);  % the largest CNR of other users
w = ones(K-K1, 1);

for k = 1:K
    for n = 1:N
        tmp = a(:,n);
        tmp(k) = [];
        b(k,n) = max(tmp);
    end
end


SNR = 0:5:40;
NSNR = length(SNR);
Rate = zeros(K1+1,NSNR);  % temp
Rate_iteration = zeros(NIte,NSNR);

for nsnr = 1:NSNR
    P = 10^(SNR(nsnr)/10); % total power constraint
    SubCarrierAllocation = zeros(N,1);
    lambda0 = 10;
    mu0 = 10 * ones(K1,1);
    
    
    for ite = 1:NIte
        %%%%%%%%%%%%%%%%%% Power allocation Begin %%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%% Power allocation End%%%%%%%%%%%%%%%%%%
        
        
        
        %%%%%%%%%%%%%%%% Subcarrier Assignment Begin %%%%%%%%%%%%%%%%
        % no this part for FSA1, FSA2 and FSA3 as their subcarrier assignments are fixed% 
         
        
        %%%%%%%%%%%%%%%% Subcarrier Assignment End%%%%%%%%%%%%%%%%
        
        
        %%%%%%%%%%%%%%%% Subgradient Update Begin %%%%%%%%%%%%%%%%
        step_size = 1/(P*100); % step step for subgradient descent 
        
        %%%%%%%%%%%%%%%%%% Subgradient Update End%%%%%%%%%%%%%%%%
        
        
        NRate = 0;
        %% it should be a bug, as each subCarrier can only be allocated to one user 
        % for n = 1:N
        %     for k = K1+1:K
        %         NRate = NRate + w(k-K1)*log(1+p_sa(k,n)*a(k,n));
        %     end
        % end
        for n = 1:N
            k = SubCarrierAllocation(n);
            NRate = NRate + w(k-K1)*log(1+p_sa(k,n)*a(k,n));
        end
        Rate_iteration(ite, nsnr)= NRate;
        
    end
    
    Rate(1,nsnr) = Rate(1,nsnr) + real(NRate);
end

figure;
plot(SNR,Rate(1,:), 'r-*', 'LineWidth', 2, 'MarkerSize', 12);
xlabel('SNR (dB)');
ylabel('Normal Rate');
legend('OptimalScheme')
grid on;







