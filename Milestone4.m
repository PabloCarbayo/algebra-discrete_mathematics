% Incremental practice for Algebra & Discrete Mathematics
% 2022-23
% 
% Name of the student: Pablo Carbayo Aranda
% Milestone 4
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

vectorArboles={}; %Creamos un vector de arboles vacio

%% Carga de datos
datos = load(strcat(data_dir,'Graphs_research_groups.mat')); %Utilizamos el archivo proporcionado en el campus virtual
vectorGrafos = datos.research_groups_G;

%% Calculo de arboles

for i=1:length(vectorGrafos) %Recorremos el vector de grafos
    grafo=vectorGrafos{i}; %Almacenamos el grafo actual
    nodosGrafo=grafo.Nodes; %Almacenamos los nodos del grafo
    aristasGrafo=grafo.Edges; %Almacenamos las aristas del grafo
    
    vectorPesos=zeros(1,height(nodosGrafo)); %Creamos un vector de ceros con longitud igual a la cantidad de nodos del grafo
    for j=1:height(nodosGrafo) %Recorremos la columna de nodos
        peso=0; %Inicializamos el peso a 0
        idNodo=nodosGrafo.Name{j}; %Seleccionamos e ID del nodo del que queremos calcular el peso de sus aristas incidentes
        for x=1:height(aristasGrafo) %Recorremos la columna de aristas del grafo
            aristaElegido=aristasGrafo(x,:); %Seleccionamos el arista
            if(strcmp(aristaElegido.EndNodes{1},idNodo)  | strcmp(aristaElegido.EndNodes{2},idNodo)) %Comprobamos que el nodo elegido es source o target del arista
                peso=peso+aristaElegido.Weight; %Sumamos el peso del arista al peso total
                vectorPesos(j)=peso; %Actualizamos la posicion del nodo en el vector de pesos totales

            end
        end
    end
    
    indiceNodoRaiz= find(vectorPesos == max(vectorPesos)); % Encuentra el índice del nodo con el peso máximo
    nodoRaiz=nodosGrafo.Name{indiceNodoRaiz,:}; %Asignamos el nodo raiz
    
    grafo.Edges.Weight = -grafo.Edges.Weight; %Invertimos los pesos de las aristas para obtener el arbol generador maximo
    
    arbol = minspantree(grafo, 'Type', 'tree', 'Root', nodoRaiz); %generamos el arbol de maximo coste

    
    grafo.Edges.Weight = -grafo.Edges.Weight; %Invierte nuevamente los pesos de las aristas en el árbol generador máximo
    arbol.Edges.Weight = -arbol.Edges.Weight; %Invertimos los pesos de las aristas del arbol 

    columnaPesos=transpose(vectorPesos); %Transponemos el vector de pesos de las aristas incidentes al nodo
    arbol.Nodes=addvars(nodosGrafo,columnaPesos,'After','affiliation','NewVariableNames','PesosAdyacentes'); %Añadimos la columna de pesos a la tabla de nodos del arbol

    nombreVentana=['Research Group ',num2str(i)]; %Cambiamos el nombre de la ventana
    figure('Name',nombreVentana);

   %% Dibujo del arbol

    p = plot(arbol); %Dibujamos el arbol
    highlight(p,nodoRaiz,'NodeColor','red');
    highlight(p,arbol,EdgeColor="magenta");
    vectorArboles{i}=arbol; %almacenamos el arbol en el vector 

end

%% Guardado de arboles

save(strcat(data_dir,'Milestone4.mat'),"vectorArboles") %guardamos el vector de arboles en el fichero Milestone4.mat





