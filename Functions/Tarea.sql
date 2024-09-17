DELIMITER //

CREATE FUNCTION modify_tarea_prioridad(
    idTareaUnitaria INT,
    nuevaPrioridad INT
)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE resultado VARCHAR(100);
    
    -- Verificamos si la tarea existe
    IF EXISTS (SELECT 1 FROM TareaUnitaria WHERE idTareaUnitaria = idTareaUnitaria) THEN
        -- Actualizamos la prioridad de la tarea
        UPDATE TareaUnitaria
        SET prioridad = nuevaPrioridad
        WHERE idTareaUnitaria = idTareaUnitaria;
        
        SET resultado = 'La prioridad ha sido modificada exitosamente.';
    ELSE
        -- Si no existe la tarea, retornamos un mensaje de error
        SET resultado = 'Error: La tarea no existe.';
    END IF;
    
    RETURN resultado;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION set_tarea_usuario_proyecto(
    idTareaUnitaria INT,
    idUsuario INT
)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE resultado VARCHAR(100);

    -- Verificamos si la tarea existe
    IF EXISTS (SELECT 1 FROM TareaUnitaria WHERE idTareaUnitaria = idTareaUnitaria) THEN
        -- Actualizamos la tarea con el usuario asignado
        UPDATE TareaUnitaria
        SET usuario = idUsuario
        WHERE idTareaUnitaria = idTareaUnitaria;
        
        SET resultado = 'La tarea ha sido asignada exitosamente al usuario.';
    ELSE
        SET resultado = 'Error: La tarea no existe.';
    END IF;

    RETURN resultado;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION set_etiquetas_tarea(
    idTareaUnitaria INT,
    etiqueta INT
)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE resultado VARCHAR(100);

    -- Verificamos si la tarea existe
    IF EXISTS (SELECT 1 FROM TareaUnitaria WHERE idTareaUnitaria = idTareaUnitaria) THEN
        -- Actualizamos la tarea con la etiqueta
        UPDATE TareaUnitaria
        SET etiqueta = etiqueta
        WHERE idTareaUnitaria = idTareaUnitaria;
        
        SET resultado = 'La etiqueta ha sido asignada exitosamente a la tarea.';
    ELSE
        SET resultado = 'Error: La tarea no existe.';
    END IF;

    RETURN resultado;
END //

DELIMITER ;

