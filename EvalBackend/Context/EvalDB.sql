CREATE DATABASE EvalDB;
USE EvalDB;

--Creando tabla CLIENTES
CREATE TABLE Clientes(
	ClienteID INT PRIMARY KEY,
	Nombre VARCHAR(100),
	Correo VARCHAR(30)
);

--Creando tabla COMPRAS
CREATE TABLE Compras(
	CompraID INT PRIMARY KEY,
	ClienteID INT,
	Monto DECIMAL(10,2),
	FechaCompra DATE
	CONSTRAINT FK_CLIENTEID FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

--Creando consulta para clientes con compras mayores a $100
SELECT Nombre,Correo FROM Clientes
--Hacemos una subconsulta para obtener los clientes con compras mayores a 100 y que sean en este mes 
WHERE ClienteId IN(
	SELECT ClienteID FROM Compras
	WHERE Monto>=100
	AND FechaCompra like CONCAT('2025-',FORMAT(GETDATE(), 'MM'),'-%') 
)

--CREANDO TABLA PRODUCTOS
CREATE TABLE Productos(
	ProductoID int PRIMARY KEY IDENTITY (1,1),
	Nombre varchar(50)not null,
	Precio decimal(10,2) not null
)

--AGREGANDO PRODUCTOID A LA TABLA COMPRAS
ALTER TABLE Compras ADD ProductoID int;

--CREANDO LA RELACION ENTRE LA TABLA COMPRAS Y PRODUCTOS
ALTER TABLE Compras ADD 
CONSTRAINT FK_IDPRODUCTO FOREIGN KEY (ProductoID) references Productos(ProductoID)

--ACTUALIZACION MASIVA, AUMENTAR PRECIOS EN 10%
UPDATE Productos 
SET Precio=	Precio + (Precio*0.1)
WHERE Precio < 50

-- ACTUALIZANDO MEDIANTE STORED PROCEDURES
CREATE PROCEDURE sp_AumentarPrecioProductos
    @porcentaje int 
AS
BEGIN
	UPDATE Productos 
	SET Precio=	Precio + (Precio* (@porcentaje/100))
	WHERE Precio < 50
END;

EXEC sp_AumentarPrecioProductos 10

SELECT * FROM Productos