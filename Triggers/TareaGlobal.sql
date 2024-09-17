DELIMITER //

CREATE TRIGGER eliminar_proyecto_asociado
BEFORE DELETE ON proyecto
FOR EACH ROW
BEGIN
    -- Eliminar las tareas unitarias asociadas al proyecto eliminado
    DELETE FROM tareaunitaria
    WHERE grupo = OLD.idProyecto;

    -- Desvincular a los usuarios añadidos al proyecto eliminado
    DELETE FROM grupohasusuario
    WHERE Grupo_Proyecto = OLD.idProyecto;
END;
//

DELIMITER ;
