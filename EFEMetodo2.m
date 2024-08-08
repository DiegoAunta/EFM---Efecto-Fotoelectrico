function [V_0] = EFEMetodo2(V, I, grafica)
    % Selecciona el rango de datos para el ajuste
    % Por ejemplo, para ajustar entre los índices 50 y 150
    indices = 10:100;
    
    % Extrae los datos del rango seleccionado
    V_segment = V(indices);
    I_segment = I(indices);
    
    % Realiza el ajuste lineal por mínimos cuadrados
    % p(1) es la pendiente, y p(2) es la intersección
    p = polyfit(V_segment, I_segment, 1);
    
    % Genera los valores ajustados para todo el dominio
    V_full_range = linspace(min(V), max(V), 1000); % Crea un rango de valores de voltaje
    I_fit_full_range = polyval(p, V_full_range); % Calcula la corriente ajustada para todo el rango
    
    % Linea tangente
    % Encuentra el maximo despues del inicio de la curva
    limite = length(V)-5;
    I_exp = I(100:limite);
    
    [max_I, indice_maximo] = max(I_exp);
    ind_max_abs = 100-1+indice_maximo;
    
    V_segment_exp = V(ind_max_abs-4: ind_max_abs);
    I_segment_exp = I(ind_max_abs-4: ind_max_abs);
    
    % Realiza el ajuste lineal por mínimos cuadrados
    % p(1) es la pendiente, y p(2) es la intersección
    p2 = polyfit(V_segment_exp, I_segment_exp, 1);
    
    % Genera los valores ajustados para todo el dominio
    V_full_range_exp = linspace(min(V), max(V), 1000); % Crea un rango de valores de voltaje
    I_fit_full_range_exp = polyval(p2, V_full_range_exp); % Calcula la corriente ajustada para todo el rango
    
    % Interpolacion
    yi1 = interp1(V_full_range, I_fit_full_range, V_full_range, 'linear');
    yi2 = interp1(V_full_range_exp, I_fit_full_range_exp, V_full_range, 'linear');
    
    % Encontrar la diferencia y el punto de mínima diferencia
    difference = abs(yi1 - yi2);
    [minDiff, index] = min(difference);
    
    V_0 = V_full_range(index);
    
    % Grafica
    if grafica == 1

    % Grafica los datos originales
    figure;
    plot(V, I, 'b.', 'MarkerSize',10); % Datos originales
    hold on;
    
    % Grafica la línea ajustada para todo el dominio
    plot(V_full_range, I_fit_full_range, 'r-', 'LineWidth', 0.2);
    
    % Grafica la línea ajustada para todo el dominio
    plot(V_full_range_exp, I_fit_full_range_exp, 'r-', 'LineWidth', 0.2);
    
    
    % Añade etiquetas y leyenda
    xlabel('V_f');
    ylabel('I_c');
    xlim ([min(V), -0.5])
    ylim ([min(I)-10, max(I)+10])
    
    set(gca, "Fontsize", 20, "FontName", "Cambria Math") % Opciones de fuente y tamaño
    grid on
    grid minor
    
    legend('I_c(V_f)');
    title('Segundo Metodo para obtener V_0');
    grid on;
    end
end