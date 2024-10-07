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

