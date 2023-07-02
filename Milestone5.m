% Incremental practice for Algebra & Discrete Mathematics
% 2022-23
% 
% Name of the student: Pablo Carbayo Aranda
% Milestone 5
% Briefly describe the steps taken to address this milestone:
% 
% 
% 
% 

clear all
clc;
%% Variables

%% Variable definition
data_dir = '/home/pablo/Escritorio/Universidad/Codigo/matlab/matlab-drive/Algebra/PracticaIncremental2223/Data/'; % Relative path to the data


%% Carga de datos
%archivo con los arboles
datos = load(strcat(data_dir,'Milestone4.mat')); %Utilizamos el archivo generado en el hito anterior
vectorArboles = datos.vectorArboles;

%% Muestra de los arboles
for i=1:length(vectorArboles)
    
    arbolActual = vectorArboles{i}; %Asignamos el arbol actual
    vectorAuxiliar = sort(arbolActual.Nodes.PesosAdyacentes,"descend"); %Creamos un vector auxiliar donde almacenamos los pesos incidentes
    
    indiceRaiz=find(arbolActual.Nodes.PesosAdyacentes==vectorAuxiliar(1));%Buscamos el indice del nodo con mayor peso
    raiz=arbolActual.Nodes.Name{indiceRaiz}; %Establecemos la raiz del arbol con el nodo del indice anterior

    indiceSumidero=find(arbolActual.Nodes.PesosAdyacentes==vectorAuxiliar(length(vectorAuxiliar))); %Buscamos el indice del nodo con menor peso
    sumidero= arbolActual.Nodes.Name{indiceSumidero}; %Establecemos el sumidero del arbol con el nodo del indice anterior

    nombreVentana=['Research Group ',num2str(i)]; %Generamos el nombre de la ventana y titulo del grafo
    figure('Name',nombreVentana); %Cambiamos el nombre de la ventana

    p=plot(arbolActual,'Layout','layered','Sources',raiz,'Sinks',sumidero,'NodeLabel',arbolActual.Nodes.full_name); %Representamos el arbol, donde el nodo con mas peso incidente es la raiz y el que menos el sumidero,
                                                                                                                    % mostrando el nombre de cada investigador
    title(nombreVentana); %Establecemos el titulo del grafo
    ylabel(" Nivel de aportacion ") %Establecemos el eje Y como el nivel de aportacion
    highlight(p,raiz,'NodeColor','red'); %Cambiamos el color a la raiz
    highlight(p,arbolActual,"LineStyle","-.","EdgeColor","black") %Cambiamos el estilo y color de las aristas
    

end