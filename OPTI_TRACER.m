function Opti_tracer( M_DEP )
%% %%%%%%%%%%%%%%%%%   OPTIMISATION DU TRACAGE   %%%%%%%%%%%%%%%%%%%%%%%%%%

%% initialisation est ce que tracer
for a=1:size(M_DEP,1)
    M_DEP(a,7)=0;
end

%% initialisation Tracer
M_TRAC(1,:)=M_DEP(1,:);
M_TRAC(1,7)=1;
M_DEP(1,7)=0;
%% Recherche du meilleur Candidat
while size(M_TRAC,1)<size(M_DEP,1)
DIST=inf;
b=1;
for a=1:size(M_DEP,1) 
    if M_DEP(a,7)==0 && (((M_TRAC(end,1))^2+(M_TRAC(end,2))^2)-((M_DEP(a,1))^2+(M_DEP(a,2))^2))^2<DIST
        DIST=(((M_TRAC(end,1))^2+(M_TRAC(end,2))^2)-((M_DEP(a,1))^2+(M_DEP(a,2))^2))^2;
        M_CHOIX(1,:)=M_DEP(a,:);
        b=a;
    end
end
M_TRAC=[M_TRAC;M_CHOIX];
M_DEP(b,7)=1;
end

%% Liaison entre les tracer
TRACER=[0,0,0,0,0,0,0];
for a=1:size(M_TRAC,1)-1
    
    
    
        % si les deux tracer son des cercles
    if M_TRAC(a,1)==M_TRAC(a,3)&& M_TRAC(a,2)==M_TRAC(a,4)&& M_TRAC(a+1,1)==M_TRAC(a+1,3)&& M_TRAC(a+1,2)==M_TRAC(a+1,4) && M_TRAC(a,4)~=0
            TRACER=[TRACER;M_TRAC(a,:);M_TRAC(a,3)+M_TRAC(a,5),M_TRAC(a,4),M_TRAC(a+1,1)+M_TRAC(a+1,5),M_TRAC(a+1,2),0,0,0];
        
        
        % si le le premier est un cercle    
    elseif M_TRAC(a,1)~=M_TRAC(a,3)&& M_TRAC(a,2)~=M_TRAC(a,4)&& M_TRAC(a+1,1)==M_TRAC(a+1,3)&& M_TRAC(a+1,2)==M_TRAC(a+1,4) && M_TRAC(a,4)~=0
            TRACER=[TRACER;M_TRAC(a,:);M_TRAC(a,3),M_TRAC(a,4),M_TRAC(a+1,1)+M_TRAC(a+1,5),M_TRAC(a+1,2),0,0,0];
        
        
        % si le le second est un cercle
    elseif M_TRAC(a,1)==M_TRAC(a,3)&& M_TRAC(a,2)==M_TRAC(a,4)&& M_TRAC(a+1,1)~=M_TRAC(a+1,3)&& M_TRAC(a+1,2)~=M_TRAC(a+1,4) && M_TRAC(a,4)~=0
            TRACER=[TRACER;M_TRAC(a,:);M_TRAC(a,3)+M_TRAC(a,5),M_TRAC(a,4),M_TRAC(a+1,1),M_TRAC(a+1,2),0,0,0];
        
        
        % sinon
    else
        TRACER=[TRACER;M_TRAC(a,:);M_TRAC(a,3),M_TRAC(a,4),M_TRAC(a+1,1),M_TRAC(a+1,2),0,0,0];
    end
end
TRACER=[TRACER;M_TRAC(end,:)];
assignin('base','TRACER',TRACER)
disp('optimisation termine')
end

