DELIMITER //

CREATE PROCEDURE get_usuarios_proyecto(
    IN idTareaGlobal INT
)
BEGIN
    SELECT u.idUsuario, u.nombre, u.apellido
    FROM teamtasker.Usuario u
    INNER JOIN teamtasker.TareaGrupal_has_Usuario tgu
        ON u.idUsuario = tgu.usuario
    INNER JOIN teamtasker.TareaGrupal tg
        ON tg.idGrupo = tgu.grupo
    WHERE tg.idProyecto = idTareaGlobal
    ORDER BY u.nombre;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE get_grupos_usuario_proyecto (
    IN idUsuario INT,
    IN idTareaGlobal INT
)
BEGIN
    DECLARE check_id INT;

    -- Verifica que el idUsuario exista
    SELECT COUNT(*) INTO check_id
    FROM Usuario
    WHERE idUsuario = idUsuario;

    IF check_id = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El idUsuario no existe.';
    END IF;

    -- Verifica que el idTareaGlobal exista
    SELECT COUNT(*) INTO check_id
    FROM TareaGrupal
    WHERE idProyecto = idTareaGlobal;

    IF check_id = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El idTareaGlobal no existe.';
    END IF;

    -- Si todo está bien, realiza la consulta
    SELECT tg.idGrupo, tg.nombre, tg.descripcion
    FROM TareaGrupal tg
    JOIN TareaGrupal_has_Usuario tgu ON tg.idGrupo = tgu.grupo
    WHERE tgu.usuario = idUsuario
      AND tg.idProyecto = idTareaGlobal;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE get_grupo_tareas_proyecto(
    IN idTareaGrupal INT
)
BEGIN
    DECLARE mensaje_error VARCHAR(255);

    -- Verificar si existe la tarea grupal
    IF NOT EXISTS (SELECT 1 FROM TareaGrupal WHERE idGrupo = idTareaGrupal) THEN
        SET mensaje_error = 'La tarea grupal no existe.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje_error;
    END IF;

    -- Obtener las tareas unitarias asociadas a la tarea grupal
    SELECT tu.idTareaUnitaria, tu.nombre, tu.grupo
    FROM TareaUnitaria tu
    WHERE tu.grupo = idTareaGrupal;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE get_id_grupo_proyecto(
    IN idProyecto INT,
    IN nombre VARCHAR(50)
)
BEGIN
    SELECT tg.idGrupo, tg.nombre, tg.descripcion, tg.completada, tg.DateIn, tg.DateEnd
    FROM TareaGrupal tg
    WHERE tg.idProyecto = idProyecto AND tg.nombre = nombre;
END //

DELIMITER ;
