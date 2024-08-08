%Margen de error
error = 0.2;

% Definir los vectores para almacenar los resultados
V0M1 = zeros(1, 5);
I0M1 = zeros(1, 5);
% Definir los vectores para almacenar los resultados
V0M2 = zeros(1, 5);
I0M2 = zeros(1, 5);
% Definir los vectores para almacenar los resultados
V0M3 = zeros(1, 5);
I0M3 = zeros(1, 5);


% Hallar V0 con el primer metodo
[V0M1(1), I0M1(1)] = EFEMetodo1(V1, I1, error, 1);
[V0M1(2), I0M1(2)] = EFEMetodo1(V2, I2, error, 1);
[V0M1(3), I0M1(3)] = EFEMetodo1(V3, I3, error, 1);
[V0M1(4), I0M1(4)] = EFEMetodo1(V4, I4, error, 1);
[V0M1(5), I0M1(5)] = EFEMetodo1(V5, I5, error, 1);
% [V0M1(6), I0M1(6)] = EFEMetodo1(V6, I6, error/2, 0);
% [V0M1(7), I0M1(7)] = EFEMetodo1(V7, I7, error/2, 0);
% [V0M1(8), I0M1(8)] = EFEMetodo1(V8, I8, error, 0);

% Hallar V0 con el segundo metodo
[V0M2(1)] = EFEMetodo2(V1, I1, 1);
[V0M2(2)] = EFEMetodo2(V2, I2, 1);
[V0M2(3)] = EFEMetodo2(V3, I3, 1);
[V0M2(4)] = EFEMetodo2(V4, I4, 1);
[V0M2(5)] = EFEMetodo2(V5, I5, 1);
% [V0M2(6)] = EFEMetodo2(V6, I6, 0);
% [V0M2(7)] = EFEMetodo2(V7, I7, 0);
% [V0M2(8)] = EFEMetodo2(V8, I8, 0);

% Hallar V0 con el tercer metodo

[V0M3(1)] = EFEMetodo3(V1, I1, 1);
[V0M3(2)] = EFEMetodo3(V2, I2, 1);
[V0M3(3)] = EFEMetodo3(V3, I3, 1);
[V0M3(4)] = EFEMetodo3(V4, I4, 1);
[V0M3(5)] = EFEMetodo3(V5, I5, 1);
% [V0M3(6)] = EFEMetodo3(V6, I6, 0);
% [V0M3(7)] = EFEMetodo3(V7, I7, 0);
% [V0M3(8)] = EFEMetodo3(V8, I8, 0);

% Calcular la desviación estándar del vector V0
% desvV0_M1 = std(V0M1)*100;
% desvV0_M2 = std(V0M2)*100;
% desvV0_M3 = std(V0M3)*100;

%Exportar resultados
% Abrir el archivo para escribir
fid = fopen('Frecuencias2_Metodo1.txt', 'w');

% Escribir el vector transpuesto en el archivo
fprintf(fid, 'Vector V0 transpuesto:\n');
fprintf(fid, '%f\n', V0M1');

% Cerrar el archivo
fclose(fid);

%Exportar resultados
% Abrir el archivo para escribir
fid = fopen('Frecuencias2_Metodo2.txt', 'w');

% Escribir el vector transpuesto en el archivo
fprintf(fid, 'Vector V0 transpuesto:\n');
fprintf(fid, '%f\n', V0M2');

% Cerrar el archivo
fclose(fid);

%Exportar resultados
% Abrir el archivo para escribir
fid = fopen('Frecuencias2_Metodo3.txt', 'w');

% Escribir el vector transpuesto en el archivo
fprintf(fid, 'Vector V0 transpuesto:\n');
fprintf(fid, '%f\n', V0M3');

% Cerrar el archivo
fclose(fid);