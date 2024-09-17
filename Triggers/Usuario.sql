DELIMITER //

CREATE TRIGGER desvincular_usuario
BEFORE DELETE ON usuario
FOR EACH ROW
BEGIN
    -- Actualizar las tareas del usuario eliminado a pendientes de asignación
    UPDATE tareaunitaria
    SET usuario = NULL
    WHERE usuario = OLD.idUsuario;

    -- Desvincular al usuario de los proyectos
    DELETE FROM grupohasusuario
    WHERE usuario = OLD.idUsuario;
END;

//

DELIMITER ;
