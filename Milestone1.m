% Incremental practice for Algebra & Discrete Mathematics
% 2022-23
% 
% Name of the student: Pablo Carbayo Aranda
% Milestone 1
% Briefly describe the steps taken to address this milestone:
% 
% 
% 
% 

clear all
clc;
%% Variables
data_dir = '/home/pablo/Escritorio/Universidad/Codigo/matlab/matlab-drive/Algebra/PracticaIncremental2223/Data/'; % Relative path to the data


%% Carga de datos
%autores
opts = detectImportOptions(strcat(data_dir,'1_authors.csv'));
opts = setvartype(opts, {'ID_author','AU_ID_scopus','full_name','affiliation'}, {'int32','int64','string','string'});
authors = readtable(strcat(data_dir,'1_authors.csv'), opts);
%colaboraciones
opts = detectImportOptions(strcat(data_dir,'3_collaborations.csv'));
opts = setvartype(opts, {'ID_author_1','ID_author_2','scopus_id_collaborations'}, {'int32','int32','string'});
collaborations = readtable(strcat(data_dir,'3_collaborations.csv'), opts);


%% Cálculo de pesos de las aristas

%Estan mal calculados ya que no se calcula la relacion 
% 1/numero de pares de autores en la publicacion

pesos = zeros(height(collaborations), 1); %Creamos un vector vacio con la altura de la tabla de colaboraciones
for i = 1:height(collaborations) %Recorremos la tabla colaboraciones
    scopusIDs = collaborations.scopus_id_collaborations{i}; %Obtenemos el campo scopus_id_collaborations
    numIDs = length(strsplit(scopusIDs, ',')); %Separamos el campo anterior con "," como limite 
    pesos(i) = numIDs; %La longitud del vector de IDs determina el peso de la relacion
end


figure(1)
%% Muestra del grafo obtenido
grafo = graph(collaborations.ID_author_1, collaborations.ID_author_2, pesos,string(authors.ID_author)); %Construimos el grafo
p=plot(grafo, 'Layout', 'force'); %Mostramos el grafo
title('Grafo de colaboraciones entre autores'); %Establecemos el titulo de la figura

