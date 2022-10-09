clear all
clc

time = 5e3;
dt = 1;
ext_stim = zeros(time/dt,4);
% ext_stim(2000:4000,1) = 2;
% ext_stim(2000:4000,2) = 2;

%%
D1 = 5;
G1 = 0.1;
[E1,F1] = RG(D1,G1,ext_stim,time,dt);
U_E1 = E1(1,:);
h_E1 = E1(3,:);
U_F1 = F1(1,:);
h_F1 = F1(3,:);

% D2 = 0.743;
% G2 = 0.3;
% [E2,F2] = RG(D2,G2,ext_stim,time,dt);
% U_E2 = E2(1,:);
% h_E2 = E2(3,:);
% U_F2 = F2(1,:);
% h_F2 = F2(3,:);

to_plot = 1;


%%
Sh = -.6; VmidH = -60;
tails = round(find_periods(U_E1,U_F1,dt)/2);
U_Range = -70:1:-40; 
hInf = @(U) 1./(1 + exp(-Sh*(U-VmidH))*0.5); %Steady-state value of h, as a function of U.

if to_plot ==1
    h = figure;
    set(h,'Position',[500,200,700,600])
%     xlim([-70,-40])
    hold on
%     axis square
    grid on
    
    plot(U_Range,hInf(U_Range),'g:','linewidth',2)
    pREs = plot(U_E1(1),h_E1(1),'r','linewidth',2);
    pRE =  plot(U_E1(1),h_E1(1),'ro','markersize',10,'linewidth',2);
    pRFs = plot(U_F1(1),h_F1(1),'b','linewidth',2);
    pRF = plot(U_F1(1),h_F1(1),'bo','markersize',10,'linewidth',2);
%     pSEs = plot(U_E2(1),h_E2(1),'m:','linewidth',2);
%     pSE =  plot(U_E2(1),h_E2(1),'mo','markersize',10,'linewidth',2);
%     pSFs = plot(U_F2(1),h_F2(1),'k:','linewidth',2);
%     pSF = plot(U_F2(1),h_F2(1),'ko','markersize',10,'linewidth',2);
    
    
     pause(0.5);
    
    for i = 2:time/dt
        pREs.XData = U_E1(max(1,i-tails):i);
        pREs.YData = h_E1(max(1,i-tails):i);
        
        pRE.XData = U_E1(i);
        pRE.YData = h_E1(i);
        
        pRFs.XData = U_F1(max(1,i-tails):i);
        pRFs.YData = h_F1(max(1,i-tails):i);
                
        pRF.XData = U_F1(i);
        pRF.YData = h_F1(i);
        
%         pSEs.XData = U_E2(max(1,i-tails):i);
%         pSEs.YData = h_E2(max(1,i-tails):i);
%         
%         pSE.XData = U_E2(i);
%         pSE.YData = h_E2(i);
%         
%         pSFs.XData = U_F2(max(1,i-tails):i);
%         pSFs.YData = h_F2(max(1,i-tails):i);
%                 
%         pSF.XData = U_F2(i);
%         pSF.YData = h_F2(i);
        

        pause(1e-3);
    end
    
% if to_plot == 2
%     h = figure;
%     set(h,'Position',[500,200,400,600])
%     subplot(2,1,1)
%     hold on
%     grid on
%     plot(U_Range,hInf(U_Range),'g:','linewidth',2)
%     title(['D = ',num2str(D1),'     Gw = ',num2str(G1)])
%     
%     pREs = plot(U_E1(1),h_E1(1),'r','linewidth',2);
%     pRE =  plot(U_E1(1),h_E1(1),'o','markersize',10,'linewidth',2);
%     pRFs = plot(U_F1(1),h_F1(1),'b','linewidth',2);
%     pRF = plot(U_F1(1),h_F1(1),'o','markersize',10,'linewidth',2);
%     
%     subplot(2,1,2)
%     hold on
%     grid on
%     plot(U_Range,hInf(U_Range),'g:','linewidth',2)
%     title(['D = ',num2str(D2),'     Gw = ',num2str(G2)])
%     
%     pSEs = plot(U_E2(1),h_E2(1),'r','linewidth',2);
%     pSE =  plot(U_E2(1),h_E2(1),'o','markersize',10,'linewidth',2);
%     pSFs = plot(U_F2(1),h_F2(1),'b','linewidth',2);
%     pSF = plot(U_F2(1),h_F2(1),'o','markersize',10,'linewidth',2);
%     
%     pause(.5);
%     
%     for i = 2:time/dt
%         pREs.XData = U_E1(max(1,i-tails):i);
%         pREs.YData = h_E1(max(1,i-tails):i);
%         
%         pRE.XData = U_E1(i);
%         pRE.YData = h_E1(i);
%         
%         pRFs.XData = U_F1(max(1,i-tails):i);
%         pRFs.YData = h_F1(max(1,i-tails):i);
%                 
%         pRF.XData = U_F1(i);
%         pRF.YData = h_F1(i);
%         
%         pSEs.XData = U_E2(max(1,i-tails):i);
%         pSEs.YData = h_E2(max(1,i-tails):i);
%         
%         pSE.XData = U_E2(i);
%         pSE.YData = h_E2(i);
%         
%         pSFs.XData = U_F2(max(1,i-tails):i);
%         pSFs.YData = h_F2(max(1,i-tails):i);
%                 
%         pSF.XData = U_F2(i);
%         pSF.YData = h_F2(i);
%         
% 
%         pause(1e-3);
%     end
%        
% end
       
end