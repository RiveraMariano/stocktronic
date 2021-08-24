-- TRIGGER PARA INSERTAR UNA ENTREGA ---------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER AUDITORIA_ENTREGA
    AFTER INSERT OR UPDATE ON PRODUCTO
    FOR EACH ROW
BEGIN 
    INSERT INTO H_ENTREGAS (FEC_ENTREGA, ID_PRODUCTO, ID_PROVEEDOR) VALUES (SYSDATE, :NEW.ID_PRODUCTO, :NEW.ID_PROVEEDOR);
    
    EXCEPTION
		WHEN OTHERS THEN
			INSERT INTO H_ERRORES(FEC_ERROR, DESCRIPCION, ID_USUARIO) VALUES (SYSDATE, 'ERROR EN EL TRIGGER ENTREGAS', 1);
    COMMIT;
END AUDITORIA_ENTREGA;

-- TRIGGER PARA INSERTAR UNA ORDEN -----------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER INSERT_ORDEN
    AFTER INSERT ON INFO_PAGO
    FOR EACH ROW
BEGIN
    INSERT INTO ORDEN (FEC_ORDEN, MONTO_TOTAL, ID_INFOPAGO, ID_USUARIO) 
    VALUES (SYSDATE, (:NEW.TOTAL * 1.13), :NEW.ID_INFOPAGO, :NEW.ID_USUARIO);
END;

-- TRIGGER PARA INSERTAR UN DETALLE_ORDEN -----------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER INSERT_DETALLE_ORDEN
    AFTER INSERT ON ORDEN
    FOR EACH ROW
        DECLARE
            V_INICIO NUMBER;
            V_FIN NUMBER;
            V_ID_PRODUCTO NUMBER;
            V_CANTIDAD NUMBER;
            V_PRECIO NUMBER;
            V_URL_IMAGEN VARCHAR2(200);
            V_PRECIO_FINAL NUMBER;
BEGIN
    SELECT MAX(ID_CARRITO) INTO V_FIN FROM CARRITO;
    FOR I IN (SELECT ID_CARRITO, ID_USUARIO FROM CARRITO)
    LOOP 
        V_INICIO := 0;
        LOOP 
            IF I.ID_CARRITO = V_INICIO AND I.ID_USUARIO = :NEW.ID_USUARIO THEN
                SELECT C.ID_PRODUCTO, C.CANTIDAD INTO V_ID_PRODUCTO, V_CANTIDAD FROM USUARIO U INNER JOIN CARRITO C 
                ON U.ID_USUARIO = C.ID_USUARIO WHERE U.ID_USUARIO = :NEW.ID_USUARIO AND I.ID_CARRITO = C.ID_CARRITO;
        
                SELECT P.PRECIO, P.URL_IMAGEN INTO V_PRECIO, V_URL_IMAGEN FROM USUARIO U INNER JOIN CARRITO C 
                ON U.ID_USUARIO = C.ID_USUARIO INNER JOIN PRODUCTO P ON C.ID_PRODUCTO = P.ID_PRODUCTO 
                WHERE U.ID_USUARIO = :NEW.ID_USUARIO AND I.ID_CARRITO = C.ID_CARRITO;
                
                V_PRECIO_FINAL := V_PRECIO * V_CANTIDAD;
                INSERT INTO DETALLE_ORDEN (ID_PRODUCTO, PRECIO, CANTIDAD, URL_IMAGEN, ID_ORDEN, ID_USUARIO) 
                VALUES (V_ID_PRODUCTO, V_PRECIO_FINAL, V_CANTIDAD, V_URL_IMAGEN, :NEW.ID_ORDEN, :NEW.ID_USUARIO);
            END IF;
            V_INICIO := V_INICIO + 1;
        EXIT WHEN V_INICIO > V_FIN;
        END LOOP; 
    END LOOP;
    
    EXCEPTION
		WHEN OTHERS THEN
			INSERT INTO H_ERRORES(FEC_ERROR, DESCRIPCION, ID_USUARIO) VALUES (SYSDATE, 'ERROR EN EL TRIGGER DETALLE ORDEN', 1);
    COMMIT;
END INSERT_DETALLE_ORDEN;

-- TRIGGER PARA RESTAR LA CANTIDAD DE UN PRODUCTO -------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER UPDATE_CANTIDAD_PRODUCTO
    AFTER INSERT ON ORDEN
    FOR EACH ROW
        DECLARE
            V_INICIO NUMBER;
            V_FIN NUMBER;
            V_ID_PRODUCTO NUMBER;
            V_CANTIDAD_PRODUCTO NUMBER;
            V_CANTIDAD_CARRITO NUMBER;
            V_CANTIDAD_FINAL NUMBER;
BEGIN
    SELECT MAX(ID_CARRITO) INTO V_FIN FROM CARRITO;
    FOR I IN (SELECT ID_CARRITO, ID_USUARIO FROM CARRITO)
    LOOP 
        V_INICIO := 0;
        LOOP 
            IF I.ID_CARRITO = V_INICIO AND I.ID_USUARIO = :NEW.ID_USUARIO THEN
                SELECT P.ID_PRODUCTO, P.CANTIDAD, C.CANTIDAD INTO V_ID_PRODUCTO, V_CANTIDAD_PRODUCTO, V_CANTIDAD_CARRITO 
                FROM USUARIO U INNER JOIN CARRITO C ON U.ID_USUARIO = C.ID_USUARIO 
                INNER JOIN PRODUCTO P ON C.ID_PRODUCTO = P.ID_PRODUCTO 
                WHERE U.ID_USUARIO = :NEW.ID_USUARIO AND I.ID_CARRITO = C.ID_CARRITO;
                
                V_CANTIDAD_FINAL := V_CANTIDAD_PRODUCTO - V_CANTIDAD_CARRITO;
                UPDATE PRODUCTO SET CANTIDAD = V_CANTIDAD_FINAL WHERE ID_PRODUCTO = V_ID_PRODUCTO;
            END IF;
            V_INICIO := V_INICIO + 1;
        EXIT WHEN V_INICIO > V_FIN;
        END LOOP; 
    END LOOP;
    
    EXCEPTION
		WHEN OTHERS THEN
			INSERT INTO H_ERRORES(FEC_ERROR, DESCRIPCION, ID_USUARIO) VALUES (SYSDATE, 
            'ERROR EN EL TRIGGER UPDATE CANTIDAD', 1);
    COMMIT;
END UPDATE_CANTIDAD_PRODUCTO;

-- TRIGGER PARA VACIAR EL CARRITO -----------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER VACIAR_CARRITO
    AFTER INSERT ON DETALLE_ORDEN
    FOR EACH ROW
BEGIN
    DELETE CARRITO WHERE ID_USUARIO = :NEW.ID_USUARIO AND ID_PRODUCTO = :NEW.ID_PRODUCTO;
    
    EXCEPTION
		WHEN OTHERS THEN
			INSERT INTO H_ERRORES(FEC_ERROR, DESCRIPCION, ID_USUARIO) VALUES (SYSDATE, 
            'ERROR EN EL TRIGGER VACIAR CARRITO', 1);
    COMMIT;
END VACIAR_CARRITO;

-- COMMIT AL TRIGGERS
COMMIT;