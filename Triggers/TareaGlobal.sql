DELIMITER $$

CREATE TRIGGER after_tareaglobal_delete
AFTER DELETE ON TareaGlobal
FOR EACH ROW
BEGIN
    
    DELETE FROM TareaGrupal
    WHERE idProyecto = OLD.idProyecto;

    
    DELETE tu FROM TareaUnitaria tu
    WHERE tu.grupo IN (SELECT tg.idGrupo FROM TareaGrupal tg WHERE tg.idProyecto = OLD.idProyecto);
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_tareaglobal_delete_unlink_users
AFTER DELETE ON proyecto
FOR EACH ROW
BEGIN
    -- Desvincular a los usuarios asociados al proyecto eliminado
    DELETE FROM TareaGrupal_has_Usuario
    WHERE proyecto = OLD.idProyecto;
END$$

DELIMITER ;

