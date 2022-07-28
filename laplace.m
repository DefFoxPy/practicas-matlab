% Transformada de Laplace
clearvars;
clear
clc

syms v(t) t R C s Vcs Vc

fun = diff(v,t) == (-v/(R*C))

TLEc = laplace(fun) 

TLEc = subs(TLEc, [laplace(v(t),t,s),v(0)], [Vcs,10])

Vcs = solve(TLEc, Vcs)

Vc = ilaplace(Vcs)