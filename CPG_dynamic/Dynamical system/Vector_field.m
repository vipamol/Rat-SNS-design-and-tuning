clear all
clc

time = 5e3;
dt = 1;
ext_stim = zeros(time/dt,4); % disturbance

% ext_stim(1000:2000,1) = 2;

% ext_stim(2000:3000,1) = -2;
% ext_stim(2000:3000,2) = 2;

%% 
D = 6;
Gw = 0;

[E,F,EN,FN] = RG(D,Gw,ext_stim,time,dt);

U_E = E(1,:);
h_E = E(3,:);
U_F = F(1,:);
h_F = F(3,:);

tails = 440;
% tails = round(find_periods(U_E,U_F,dt)/2);

Sh = -.6; VmidH = -60;
U_Range = -70:1:-40; 
hInf = @(U) 1./(1 + exp(-Sh*(U-VmidH))*0.5); %Steady-state value of h, as a function of U.

h = figure;
set(h,'Position',[500,200,900,600])
pause(0.5);

  for i = 500:time/dt
      plot(U_Range,hInf(U_Range),'g:','linewidth',2)
      hold on 
      grid on
      
      VE_null = @(U) (EN(1,i)-60-U)./(EN(2,i)*(U-50));
      plot(U_Range,VE_null(U_Range),'r','linewidth',2)
      VF_null = @(U) (FN(1,i)-60-U)./(FN(2,i)*(U-50));
      plot(U_Range,VF_null(U_Range),'b','linewidth',2)
   
      pREs = plot(U_E(500),h_E(500),'r:','linewidth',2);
      pRE =  plot(U_E(500),h_E(500),'ro','markersize',8,'linewidth',2);
      pRFs = plot(U_F(500),h_F(500),'b:','linewidth',2);
      pRF = plot(U_F(500),h_F(500),'bo','markersize',8,'linewidth',2);
      
      pREs.XData = U_E(max(1,i-tails):i);
      pREs.YData = h_E(max(1,i-tails):i);
      
      pRE.XData = U_E(i);
      pRE.YData = h_E(i);
      
      pRFs.XData = U_F(max(1,i-tails):i);
      pRFs.YData = h_F(max(1,i-tails):i);
      
      pRF.XData = U_F(i);
      pRF.YData = h_F(i);
      
        hold off
        ylim([0 1])
      pause(1e-3);
%       keyboard    
  end