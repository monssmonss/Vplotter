function Tracer(M_DEP)

%% %%%%%%%%%%%%%%%%%   OPTIMISATION DU TRACAGE   %%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf(' \n %%%%%%%%%%%%%%%%%%%   OPTIMISATION DU TRACAGE   %%%%%%%%%%%%%%%%%%%%%%%%%% ')
%%
index=[1:size(M_DEP,1)]';
M_TRAC=[index,M_DEP];
Order=[];

M_TRAC_x1=sortrows(M_TRAC,2:3);
M_TRAC_y1=sortrows(M_TRAC,3:2);
M_TRAC_x2=sortrows(M_TRAC,4:5);
M_TRAC_y2=sortrows(M_TRAC,5:4);
%% finding the nearest point
Transformation = 1
Order=[Order;Transformation];
if(Transformation>0) % if the transformation is done in the righ order
    x=M_DEP(abs(Transformation) ,3);
    y=M_DEP(abs(Transformation) ,4);
    [~,index_x2]=ismember(Transformation , M_TRAC_x2(:,1));
    [~,index_y2]=ismember(Transformation , M_TRAC_y2(:,1));
    
    [out,rank]=sort([  M_TRAC_x1(:,2)  ;  M_DEP( abs(Transformation) , 3 )  ]);
    [bool,index_x1]=ismember( size(M_TRAC_x1(:,2),1)+1 , rank );
    
    [out,rank]=sort([  M_TRAC_y1(:,2)  ;  M_DEP(abs(Transformation),4)  ]);
    [bool,index_y1]=ismember( size(M_TRAC_y1(:,2),1)+1 , rank );
    clear out, bool, rank     
else 
    x=M_DEP(abs(Transformation) ,1);
    y=M_DEP(abs(Transformation) ,2);
    [~,index_x1]=ismember(Transformation , M_TRAC_x1(:,1));
    [~,index_y1]=ismember(Transformation , M_TRAC_y1(:,1));
    
    [out,rank]=sortrows([  M_TRAC_x2(:,2)  ;  M_DEP( abs(Transformation) , 1 )  ]);
    [bool,index_x1]=ismember( size(M_TRAC_x1(:,2),1)+1 , rank );
    
    [out,rank]=sortrows([  M_TRAC_y2(:,2)  ;  M_DEP( abs(Transformation) , 2 )  ]);
    [bool,index_y1]=ismember( size(M_TRAC_y1(:,2),1)+1 , rank );
    clear out, bool, rank 
end
%%
% On sait maintenant les lignes correspondant au point (x,y) dans
% M_TRAC_x1;M_TRAC_y1;M_TRAC_x2;M_TRAC_y2

% On étudie les lignes au dessus et dessous de celles-ci. On a donc (au
% maximum) 8 lignes à étudier. 
% Cela va nous donner une distance minimale notée.
% Enfin, on etudie toutes les lignes telles que Dx ou Dy < D
% 
% Cela revient à etudier les points situés dans un carré de côté D,
% déterminé par les 8 lignes.

%%
D= inf;
M_TRAC_x1(index_x1,:)=[];
M_TRAC_x2(index_x2,:)=[];
M_TRAC_y1(index_y1,:)=[];
M_TRAC_y2(index_y2,:)=[];
% if 1/R=0
%     distance = min(sqrt( (x-x_ini)^2+(y-y_ini)^2),sqrt( (x-x_end)^2+(y-y_end)^2))
% else
%     distance = abs( sqrt( (x-x_center)^2+(y-y_center)^2)-R)
%     
% end
% M_TRAC(a,:)=[]

%% 


[out,rank]=sort([M_TRAC_x1(:,2);M_DEP(abs(Transformation) ,3)]);
[bool,index_test]=ismember(size(M_TRAC_x1(:,2),2)+1,rank);