SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION IF EXISTS teamtasker.set_grupo_proyecto_usuario;
DELIMITER //
CREATE FUNCTION teamtasker.set_grupo_proyecto_usuario (idTareaGlobal INT, idUsuario INT)
RETURNS TINYINT
BEGIN
	DECLARE check_id INT;
    SET @check_id = -1;
    
    #Se fija que los IDs ingresados sean válidos (números positivos.)
    IF idTareaGlobal < 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'idTareaGlobal es un valor inválido. Ingrese un número mayor a 0.';
    END IF;
    
    IF idUsuario < 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'idUsuario es un valor inválido. Ingrese un número mayor a 0.';
    END IF;
    
    #Se verifica que exista el usuario con su ID.
    SELECT Usuario.idUsuario INTO @check_id FROM teamtasker.Usuario WHERE Usuario.idUsuario = idUsuario;
    IF @check_id = -1 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'idUsuario no pertenece al ID de un usuario en la base de datos.';
    END IF;
    SET @check_id = -1;
    
    #Se verifica que exista la tarea global con su ID.
    SELECT TareaGlobal.idProyecto INTO @check_id FROM teamtasker.TareaGlobal WHERE TareaGlobal.idProyecto = idTareaGlobal;
     IF @check_id = -1 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'idTareaGlobal no pertenece al ID de una tarea global en la base de datos.';
    END IF;
    INSERT INTO Usuario_has_TareaGlobal (Usuario_idUsuario, TareaGlobal_idProyecto) VALUES (idUsuario, idTareaGlobal);
    RETURN 1;
END;