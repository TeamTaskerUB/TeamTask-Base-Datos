use teamtasker;
DELIMITER //

CREATE PROCEDURE get_usuarios_grupo_proyecto (IN idTareaGrupal INT)
BEGIN
   SELECT * FROM Usuario
   INNER JOIN tareagrupal_has_usuario tgu ON u.idUsuario = tgu.Usuario
    INNER JOIN tareagrupal tg ON tgu.Grupo = tg.IdGrupo
    WHERE tg.idGrupo = IdTareaGrupal;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE get_adminsGrupo_grupo_proyecto(IN idTareaGrupal INT)
BEGIN
    SELECT tg.admin, u.nombre, u.apellido, u.mail
    FROM TareaGrupal tg
    JOIN Usuario u ON tg.admin = u.idUsuario
    WHERE tg.idGrupo = idTareaGrupal;
END //

DELIMITER ;