-- Método de pago elegido en el checkout (transferencia | mercadopago | tarjeta).
-- Se completa al crear el pedido. Ejecutar UNA vez (ADD COLUMN simple: compatible MySQL y MariaDB).
ALTER TABLE pedido
    ADD COLUMN metodo_pago varchar(20) NOT NULL DEFAULT 'transferencia' AFTER estado_pago;
