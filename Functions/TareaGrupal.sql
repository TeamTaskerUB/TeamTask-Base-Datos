SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION IF EXISTS teamtasker.set_grupo_proyecto_usuario;
DELIMITER //
CREATE FUNCTION teamtasker.set_grupo_proyecto_usuario (idTareaGrupal INT, idUsuario INT)
RETURNS TINYINT
BEGIN
	DECLARE project_id INT; DECLARE check_user_id INT;
    SET @project_id = -1;
    SET @check_user_id = -1;
    
    #Se fija que los IDs ingresados sean válidos (números positivos.)
	IF idTareaGrupal < 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'idTareaGrupal es un valor inválido. Ingrese un número mayor a 0.';
    END IF;
    IF idUsuario < 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'idUsuario es un valor inválido. Ingrese un número mayor a 0.';
    END IF;
	
	#Verifica que el usuario especificado exista.
    SELECT Usuario.idUsuario INTO @check_user_id FROM teamtasker.Usuario WHERE Usuario.idUsuario = idUsuario;
    IF @check_user_id = -1 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'idUsuario no corresponde a un usuario existente.';
	END IF;
    
	#Selecciona el idProyecto (correspondiente a una Tarea Global) necesario para insertar en la tabla TareaGrupal_has_Usuario luego.
	SELECT TareaGrupal.idProyecto INTO @project_id FROM teamtasker.TareaGrupal WHERE TareaGrupal.idGrupo = idTareaGrupal;
    IF @project_id = -1 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'idTareaGrupal no corresponde a una Tarea Grupal existente.';
	END IF;
    
    #Crea la entrada apropiada.
    INSERT INTO teamtasker.TareaGrupal_has_Usuario (grupo, proyecto, usuario) VALUES (idTareaGrupal, @project_id, idUsuario);
    RETURN 1;
    
END;
//
DELIMITER ;
