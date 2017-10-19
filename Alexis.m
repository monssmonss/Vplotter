clear all
close all
clc

diary('Alexis.txt')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp(['Date du document ',datestr( now )])
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

syms x y x1 y1 x2 L1 L2

disp(sprintf([' \n Dans le modèle de V-printer suivant on notera: \n',...
    '\t -(x,y) les coordonnées du stylo par rapport à l origine du repère \n',...
    '\t -(x1,y1) les coordonnées de l axe du premier moteur \n',...
    '\t -(x2,y1) les coordonnées de l axe du second moteur\n',...
    '\t -Ll la longueur séparant le stylo de l axe du moteur 1 \n',...
    '\t -L2 la longueur séparant le stylo de l axe du moteur 2 \n',...
    '\n \n',...
    'NB: On se place dans le repère (O,X,Y) où l axe X est orienté suivant la droite reliant les deux moteurs. \n']))

eq1= (x-x1)^2+(y-y1)^2;
eq2= (x-x2)^2+(y-y1)^2;
disp('Comme le point de coordonnées (x,y) appartient aux cercles ((x1,y1),L1) et ((x2,y1),L2) on a : ')
L1=sqrt(eq1);
L2=sqrt(eq2);

%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%           Exemple                    %')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('Si l on prend x1=0, x2=1, y1=1, x=0.6, y=0.8 \t on obtient les valeurs approchées suivantes:')
x=0.6;
y=0.8;
x1=0;
x2=1;
y1=1;

L1_cherche=vpa(subs(L1),3);
L2_cherche=vpa(subs(L2),3);

%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%           Modèle inverse             %')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp(sprintf([' \n Si cette fois on souhaite connaitre la valeurs de x et y en fonction de L1 et L2, on procède comme suit: \n',...
    '\t On reprend les équations vues plus haut \n',...
    '\t On a (y-y1)=L1^2-(x-x1)^2 = L2^2-(x-x2)^2 \n',...
    '\t On a donc L1^2-L2^2=(x-x1)^2-(x-x2)^2 \n',...
    '\t Ohlala qu elle est belle cette identitée remarquable !!! \n',...
    '\t L1^2-L2^2=(x2-x1)(2x-x1-x2) \n',...
    '\n \t x=(L1^2-L2^2)/(2*(x2-x1))+(x2+x1)/2 \n',...
    '\t y=-sqrt(L1^2-(testx-x1)^2)+y1 \n ',...
    '\t Il y a deux solutions mais on enlève la valeur telle que y>y1 (on suppose donc que la composante du poids suivant l axe Y est négative ']))
L1=L1_cherche;
L2=L2_cherche;
Solution_x=vpa( (L1^2-L2^2)/(2*(x2-x1))+(x2+x1)/2 , 3);
Solution_y=vpa( -sqrt(L1^2-(Solution_x-x1)^2)+y1 , 3);

disp('On retrouve bien les bonnes valeurs =D')
disp('L autre solution est symétrique par rapport à y1')
Solution_y2=vpa( +sqrt(L1^2-(Solution_x-x1)^2)+y1 , 3);
%% 
clear all
close all
clc


syms x y x1 y1 x2 L1 L2
x=simplify((L1^2-L2^2)/(2*(x2-x1))+(x2+x1)/2)
y=simplify(-sqrt(L1^2-(x-x1)^2)+y1)

d=(x2-x1);
J_x=simplify(jacobian([x;y],[L1,L2]))
%%
x1=-500;
x2=500;
y1=0;
[x,y] = meshgrid(0:0.03:1);
eq1= (x-x1)^2+(y-y1)^2;
eq2= (x-x2)^2+(y-y1)^2;
L1=sqrt(eq1);
L2=sqrt(eq2);
dX=double(abs(subs(J_x(1,1)*0.2+J_x(1,2)*0.2)));
%%
dY=double(vpa(subs(J_x(2,1)*0.2+J_x(2,2)*(0.2))));

% figure 
% mesh(x,y,dX,dY)

[a1,a2] = meshgrid(20:1:80);
for e=20:1:80
    for f=20:1:80
T1(e-19,f-19)=10*cos(f*pi/180)/sin((e+f)*pi/180);
T2(e-19,f-19)=10*cos((100-e)*pi/180)/sin((100-e+f)*pi/180);
    end
end
figure
mesh(a1,a2,T1)
hold on
mesh(100-a1,a2,T2)
hold off
% mesh(a1,a2,T2)
% mesh(a1,a2,T1)