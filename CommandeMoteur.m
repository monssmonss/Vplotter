function CommandeMoteur( ~,~)
TRACER=evalin('base','TRACER');
%% Trouver une equation general pour traduire tout les mouvements en longueur L1 et L2 puis en commande moteur
%% Il vaut mieux trouver les equations et change en L1 et L2 a la fin







%% offset de toutes les positions de 300 sur y et 200 sur x pour les moteurs
%% Ecartement initial des deux moteurs pour les tests 1600 .
% for a=1:size(TRACER,1)
% x=TRACER(a,1);
% y=TRACER(a,2);
x1=-200;
y1=-300;
x2=1400;
y2=-300;

eq1= (x-x1)^2+(y-y1)^2;
eq2= (x-x2)^2+(y-y1)^2;

L1=sqrt(eq1);
L2=sqrt(eq2);

L1_cherche(a,1)=vpa(subs(L1),3);
L2_cherche(a,2)=vpa(subs(L2),3);
% end



end