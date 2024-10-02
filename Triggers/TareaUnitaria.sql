

DELIMITER //

CREATE TRIGGER Demasiadas_Actividades
BEFORE INSERT ON TareaUnitaria
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM TareaUnitaria WHERE usuario = NEW.usuario) >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El usuario ya tiene el número máximo de tareas asignadas';
    END IF;
END//

DELIMITER ;

DELIMITER $$

CREATE TRIGGER desvincular_tarea
AFTER DELETE ON `TareaUnitaria` FOR EACH ROW
BEGIN
  
  DELETE FROM `Grupo_has_Usuario`
  WHERE `usuario` = OLD.usuario 
    AND `grupo` = OLD.grupo 
    AND `Grupo_Proyecto` = (SELECT `proyecto` FROM `Grupo` WHERE `idGrupo` = OLD.grupo);
END $$

DELIMITER ;
