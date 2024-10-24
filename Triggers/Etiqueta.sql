DELIMITER //

CREATE TRIGGER Eliminar_Etiqueta_Tarea
AFTER DELETE ON Etiqueta
FOR EACH ROW
BEGIN
    DELETE FROM TareaUnitaria
    WHERE etiqueta = OLD.idEtiqueta;
    
    DELETE FROM TareaGrupal
    WHERE etiqueta = OLD.idEtiqueta;
END//

DELIMITER ;