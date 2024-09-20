Máquina de Estados, SPI Master

PH = Phase, flanco
P = Polarity, donde empieza

Estado 1. Revisar reset
            si hay reset, todo en 0 y pasa al estado 2
            si no hay reset, se queda en el estado 1

Estado 2. Seteo de SCK
            si  CKP = 0 y CPH = 0: 
                se va al estado 3
            si  CKP = 0 y CPH = 1: 
                se va al estado 4
            si  CKP = 1 y CPH = 0: 
                se va al estado 5
            si  CKP = 1 y CPH = 1:
                se va al estado 6


Estado 3. 
            SCK lee datos en el 1er flanco (positivo)
            se va al estado 7

Estado 4. 
            SCK lee datos en el 2do flanco (negativo)
            se va al estado 7

Estado 5. 
            SCK lee datos en el 1er flanco (negativo)
            se va al estado 7

Estado 6. 
            SCK lee datos en el 2d0 flanco (positivo)
            se va al estado 7

Estado 7.  Registro desplazable (8 bits c/u)
            I.      Poner la salida MOSI con el valor del LSB del array1
            II.     Eliminar el LSB del array1
            III.    Correr todos los bits restantes del array1 1 bit a la derecha 
            IV.     Ponerle el valor del LSB del array2 al MSB del array1
            V.      Eliminar el LSB del array2
            VI.     Correr todos los bits restantes del array2 1 bit a la derecha
            VII.    Poner el valor de la entrada MISO al MSB del array2

            Guardar la señal del MISO como el MSB del array2
            desplazar los 8 bits, uno por uno, de la entrada MISO al array1 (contador)

            Ejemplo de los arrays del Master:
            
                     array2   array1
            I.      00000001 00000010
            II.     00000001 0000001X
            III.    00000001 X0000001
            IV.     00000001 10000001
            V.      0000000X 10000001
            VI.     X0000000 10000001
            VII.    00000000 10000001


