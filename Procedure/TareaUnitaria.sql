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



