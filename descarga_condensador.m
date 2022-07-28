clearvars;
clear;
clc;

% Condensador cargado inicialmente por una fuente de 10V y en t > 0 se desconecta 
syms Vc(t) Ic(t) vi t s r1 r2 c Vcs  Vct Ics Ict

% Valores 
E = 10;
R1 = 5;
R2 = 1;
C = 1e-3;
Vci = E*R2/(R1+R2); % condicion inicial del voltaje
Ici = -E/(R1+R2);   % condicion inicial de la corriente

% Voltaje
funVc = Vc + r2 * c * diff(Vc, t) == 0 
laplace_funVc = laplace(funVc)
funVc = subs(laplace_funVc, [laplace(Vc(t), t, s)], [Vcs])
Vcs = solve(funVc, Vcs)
Vct = ilaplace(Vcs)
Vct = subs(Vct, [Vc(0), r2, c], [Vci, R2, C])

% Corriente
funIc = r2 * c *diff(Ic, t) +  Ic == 0
laplace_funIc = laplace(funIc)
funIc = subs(laplace_funIc, [laplace(Ic(t), t, s)], [Ics])
Ics = solve(funIc, Ics)
Ict = ilaplace(Ics)
Ict = subs(Ict, [Ic(0), r2, c], [Ici, R2, C])

figure(1)
ezplot(Vct,[0 R2*C*5]); % grafica desde 0 hasta los 5 taons
title('Voltaje en el Capacitor');
legend('Vc(t)');
xlabel('t(s)'); 
ylabel('Vc(V)');
%ylim([0 1]);

figure(2)
ezplot(Ict, [0 R2*C*5]);
title('Corriente en el capacitor');
legend('Ic(t)');
xlabel('t(s)'); 
ylabel('Ic(A)');



