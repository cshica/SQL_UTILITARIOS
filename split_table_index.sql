CREATE FUNCTION [dbo].[split_table_index] --SELECT * FROM dbo.SPLIT_TABLE_INDEX(',VALVERDE,SOLANO,VARGAS,',',',3)
(
	 @CADENA   VARCHAR(MAX)
	 ,@SEPARADOR CHAR(1)
	 ,@POS INT
)
RETURNS   @TABLA TABLE (ID INT, VALOR NVARCHAR(MAX))
BEGIN
	DECLARE @CONT INT=0
	DECLARE @INDEX INT =0
	DECLARE @EXISTE_SEPARADOR BIT=1
	DECLARE @VALOR NVARCHAR(MAX)
	WHILE (@EXISTE_SEPARADOR=1)
	BEGIN
		SET @INDEX=CHARINDEX(@SEPARADOR,@CADENA)
		IF(@INDEX>0)
		BEGIN
		
			SET @VALOR =SUBSTRING(@CADENA,0, @INDEX)
			SET @CADENA=SUBSTRING(@CADENA,@INDEX+1, LEN(@CADENA))

			IF(LEN(@VALOR)>0)
			BEGIN
		 
				SET @CONT=ISNULL(@CONT,0)+1
				INSERT INTO @TABLA(ID,VALOR) VALUES (@CONT,@VALOR)
			END
		END
		ELSE
		BEGIN 
	
 			SET @CONT=ISNULL(@CONT,0)+1
			SET @VALOR =@CADENA
			IF(LEN(@CADENA)>0)
			BEGIN
 				INSERT INTO @TABLA(ID,VALOR) VALUES (@CONT,@VALOR)
			END
			SET @EXISTE_SEPARADOR=0
		END
	END
	DELETE FROM @TABLA WHERE ID!=@POS
RETURN  
END