function [V_fuera_rango, I_fuera_rango] = EFEMetodo1(V, I, margen_error1, grafica)
    % Encuentra la parte constante
    % Aquí asumimos que la parte constante está en los primeros 20 puntos
    constante_I = I(10:60);

    % Encuentra el máximo y el mínimo en la parte constante
    max_constante = max(constante_I);
    min_constante = min(constante_I);

    %Define un margen de error para cada serie de datos
    margen_error = sqrt(max_constante^2 + min_constante^2) *margen_error1;
    if margen_error < 0.2
        margen_error = margen_error1;
    end

    % Calcula los límites con el margen de error
    limite_superior = max_constante + margen_error;
    limite_inferior = min_constante - 10;

    % Encuentra el primer punto fuera del rango
    fuera_rango_indice = find(I > limite_superior | I < limite_inferior, 1);

    % Guarda el primer dato fuera del rango
    V_fuera_rango = V(fuera_rango_indice);
    I_fuera_rango = I(fuera_rango_indice);
    
    if grafica == 1
    % Crea la gráfica
    figure;
    plot(V, I, "Marker",".","MarkerSize", 10,"color", 'b', 'LineStyle','none');
    hold on;

    % Marca las líneas horizontales en la parte constante
    yline(max_constante, 'r--', 'LineWidth', 1.5); % Línea horizontal en el máximo
    yline(min_constante, 'g--', 'LineWidth', 1.5); % Línea horizontal en el mínimo

    % Plotea el primer punto fuera del rango
    plot(V_fuera_rango, I_fuera_rango, 'ro', 'MarkerSize', 6);

    % Añade etiquetas y título
    xlabel('V_f');
    ylabel('I_c');
    title('Primer Metodo para obtener V_0');
    legend('I(V)', 'Max Constante', 'Min Constante', 'Primer Punto Fuera de Rango');
    xlim ([min(V), -0.5])

    set(gca, "Fontsize", 20, "FontName", "Cambria Math") % Opciones de fuente y tamaño
    grid on
    grid minor
    % Muestra la gráfica
    hold off;
    end
end