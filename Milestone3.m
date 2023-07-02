% Incremental practice for Algebra & Discrete Mathematics
% 2022-23
% 
% Name of the student: Pablo Carbayo Aranda
% Milestone 3
% Briefly describe the steps taken to address this milestone:
% 
% 
% 
% 

clear all
clc;

%% Variable definition
data_dir = '/home/pablo/Escritorio/Universidad/Codigo/matlab/matlab-drive/Algebra/PracticaIncremental2223/Data/'; % Relative path to the data

%% Carga de datos
datos = load(strcat(data_dir,'Graphs_research_groups.mat')); %Utilizamos el archivo proporcionado en el campus virtual
vectorGrafos = datos.research_groups_G; %Almacenamos el vector de grupos de investigacion

%% Representacion de los grafos
for i=1:length(vectorGrafos) %Recorremo el vector de grafos

    nombreVentana=['Research Group ',num2str(i)]; %Cambiamos el nombre de la ventana 
    figure('Name',nombreVentana);

    g=vectorGrafos{i}; %Almacenamos el grafo actual
    
    grosorArista=5*g.Edges.Weight/max(g.Edges.Weight); %Calculamos el grosor del arista proporcional a su peso
    plot(g,'LineWidth',grosorArista)
    title(nombreVentana);
end