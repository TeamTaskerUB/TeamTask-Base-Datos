use teamtasker;
DELIMITER $$

CREATE PROCEDURE get_tarea_proyecto_usuario_etiquetas (
    IN p_etiqueta INT,
    IN p_idTareaGlobal INT,
    IN p_idUsuario INT
)
BEGIN
    -- Verificar si existen tareas que coincidan con los parámetros
    IF EXISTS (
        SELECT 1 
        FROM TareaUnitaria tu
        INNER JOIN TareaGrupal tg ON tu.grupo = tg.idGrupo
        WHERE tu.etiqueta = p_etiqueta 
        AND tg.idProyecto = p_idTareaGlobal
        AND tu.usuario = p_idUsuario
    ) THEN
        -- Si existen, devolver las tareas correspondientes
        SELECT tu.* 
        FROM TareaUnitaria tu
        INNER JOIN TareaGrupal tg ON tu.grupo = tg.idGrupo
        WHERE tu.etiqueta = p_etiqueta 
        AND tg.idProyecto = p_idTareaGlobal
        AND tu.usuario = p_idUsuario;
    ELSE
        -- Si no existen, devolver un error
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se encontraron tareas que coincidan con los parámetros proporcionados.';
    END IF;
    
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE get_tareas_late_proyecto_usuario (
    IN p_idUsuario INT, 
    IN p_idTareaGlobal INT, 
    IN p_FechaHoy DATETIME
)
BEGIN
    -- Iniciar un bloque de manejo de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Si ocurre un error, devolver un mensaje de error
        SELECT 'Error: ocurrió un problema al intentar obtener las tareas atrasadas.' AS Error;
        ROLLBACK;
    END;

    -- Iniciar una transacción
    START TRANSACTION;

    -- Seleccionar las tareas unitarias que están atrasadas (dateEnd < FechaHoy) asignadas a un usuario en un proyecto específico
    SELECT tu.*
    FROM TareaUnitaria tu
    INNER JOIN TareaGrupal tg ON tu.grupo = tg.idGrupo
    WHERE tu.usuario = p_idUsuario
      AND tg.idProyecto = p_idTareaGlobal
      AND tu.dateEnd < p_FechaHoy
      AND tu.progreso < 100; -- Verificar que la tarea no esté completada (asumo que progreso = 100 es completada)

    -- Si no hay errores, confirmar la transacción
    COMMIT;

END $$

DELIMITER ;




