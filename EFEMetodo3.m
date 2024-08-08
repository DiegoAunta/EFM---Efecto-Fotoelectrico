function mejorC = EFEMetodo3(vecV, vecI, grafica)
    % Definir la función exponencial
    function I = expFunc(V, A, B, C)
        I = A * (exp(B * (V - C)) - 1);
    end

    vecV = vecV((length(vecV)-70):(length(vecV)));
    vecI = vecI((length(vecI)-70):(length(vecI)));

    % Verificar que vecV y vecI tengan la misma longitud
    if length(vecV) ~= length(vecI)
        error('Los vectores vecV y vecI deben tener la misma longitud.');
    end

    % Definir los rangos de límites inferior y superior para el ajuste
    limites_inferior = linspace(min(vecV), max(vecV) - 1, 50); % Ajustar el número de puntos
    limites_superior = linspace(min(vecV) + 1, max(vecV), 50);

    % Ajustar opciones para la función lsqcurvefit
    opts = optimset('Display', 'off');

    % Inicializar el mejor ajuste
    mejorA = NaN; mejorB = NaN; mejorC = NaN;
    mejorD = Inf;

    for limInf = limites_inferior
        for limSup = limites_superior
            % Asegurarse de que limSup sea mayor que limInf
            if limSup <= limInf
                continue;
            end

            % Filtrar los datos dentro del rango de limInf a limSup
            V = vecV(vecV > limInf & vecV <= limSup);
            I = vecI(vecV > limInf & vecV <= limSup);

            % Verificar que haya datos suficientes después del filtrado
            if length(V) < 60
                continue;
            end

            % Definir valores iniciales y límites para lsqcurvefit
            x0 = [10, 7, -3]; % Valores iniciales [A, B, C]
            lb = [min(I)-1, 0, min(V) - 1]; % Límites inferiores
            ub = [max(I)*2, 10, max(V) + 1]; % Límites superiores

            try
                % Ajuste de la gráfica
                [parametros, ~, residual] = lsqcurvefit(@(x, V) expFunc(V, x(1), x(2), x(3)), x0, V, I, lb, ub, opts);
                TA = parametros(1);
                TB = parametros(2);
                TC = parametros(3);

                % Evaluar la calidad del ajuste con el residuo total
                D = sum(residual.^2); % Error cuadrático total

                if D < mejorD
                    mejorA = TA;
                    mejorB = TB;
                    mejorC = TC;
                    mejorD = D;
                end
            catch ME
                % Mostrar mensaje de error en caso de fallo
                disp(['Error en ajuste con limInf = ', num2str(limInf), ' y limSup = ', num2str(limSup)]);
                disp(['Mensaje de error: ', ME.message]);
            end
        end
    end

    % Calcular el valor de C donde I(C) está lo más cercano a 0
    if isnan(mejorC)
        error('No se encontró un ajuste válido.');
    end

    % Encontrar el valor de C donde I es lo más cercano a cero
    % Resolver A * (exp(B * (V - C)) - 1) = 0 para I = 0
    % En este caso, no hay valor de C que haga que I sea exactamente cero.
    % Pero puedes considerar ajustar para encontrar el valor más cercano a cero.
    % Aquí, simplemente se muestra el mejor valor de C encontrado en el ajuste.

    % Graficar los resultados si grafica es 1
    if grafica == 1
        figure;
        hold on;
        scatter(vecV, vecI, 'b.', 'DisplayName', 'Datos Originales');
        V_fit = linspace(min(vecV), max(vecV), 100);
        I_fit = expFunc(V_fit, mejorA, mejorB, mejorC);
        plot(V_fit, I_fit, 'r', 'DisplayName', 'Ajuste Exponencial');
        xlabel('V_f');
        ylabel('I_c');
        xlim ([min(vecV), -0.5])
        ylim ([min(vecI)-10, max(vecI)+10])

        set(gca, "Fontsize", 20, "FontName", "Cambria Math") % Opciones de fuente y tamaño
        grid on
        grid minor
        legend show;
        title('Tercer Metodo para obtener V_0');
        hold off;
    end
end
