DELIMITER //

CREATE FUNCTION delete_perfil_usuario(
    idUsuario INT,
<<<<<<< Updated upstream
    idPerfil INT -- Cambiado de perfil a idPerfil
=======
    perfil VARCHAR(100) -- Cambiado a perfil
>>>>>>> Stashed changes
)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE resultado VARCHAR(100);
    DECLARE idPerfil INT;

    -- Buscamos el idPerfil correspondiente al nombre del perfil
    SELECT idPerfil INTO idPerfil
    FROM Perfil
    WHERE nombre = perfil
    LIMIT 1;

    -- Verificamos si el perfil asignado existe para ese usuario
    IF EXISTS (SELECT 1 
               FROM Usuario_has_Perfil 
               WHERE idUsuario = idUsuario 
               AND idPerfil = idPerfil) THEN
        -- Eliminamos el perfil asignado al usuario
        DELETE FROM Usuario_has_Perfil
        WHERE idUsuario = idUsuario
<<<<<<< Updated upstream
        AND idPerfil = idPerfil; -- Cambiado a idPerfil
=======
        AND idPerfil = idPerfil;
>>>>>>> Stashed changes

        SET resultado = 'El perfil ha sido removido exitosamente del usuario.';
    ELSE
        -- Si no existe, retornamos un mensaje de error
        SET resultado = 'Error: El perfil no existe para este usuario.';
    END IF;

    RETURN resultado;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION set_perfil_usuario(
    idUsuario INT,
<<<<<<< Updated upstream
    idPerfil INT -- Cambiado de perfilAsignado a idPerfil
=======
    perfilAsignado VARCHAR(100) -- Cambiado a perfilAsignado
>>>>>>> Stashed changes
)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE resultado VARCHAR(100);
    DECLARE idPerfil INT;

    -- Buscamos el idPerfil correspondiente al nombre del perfil asignado
    SELECT idPerfil INTO idPerfil
    FROM Perfil
    WHERE nombre = perfilAsignado
    LIMIT 1;

    -- Verificamos si el perfil ya está asignado al usuario
    IF EXISTS (SELECT 1 
               FROM Usuario_has_Perfil 
               WHERE idUsuario = idUsuario 
               AND idPerfil = idPerfil) THEN
        -- Si el perfil ya está asignado, devolvemos un mensaje
        SET resultado = 'Error: El perfil ya está asignado al usuario.';
    ELSE
        -- Si el perfil no está asignado, lo insertamos en la tabla Usuario_has_Perfil
<<<<<<< Updated upstream
        INSERT INTO Usuario_has_Perfil (idUsuario, idPerfil) -- Cambiado a idPerfil
=======
        INSERT INTO Usuario_has_Perfil (idUsuario, idPerfil)
>>>>>>> Stashed changes
        VALUES (idUsuario, idPerfil);

        SET resultado = 'El perfil ha sido asignado exitosamente al usuario.';
    END IF;

    RETURN resultado;
END //
<<<<<<< Updated upstream

DELIMITER ;
=======
DELIMITER ;


>>>>>>> Stashed changes
