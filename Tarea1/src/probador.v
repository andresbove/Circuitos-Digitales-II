module probador (
    output reg reset, A, B, C, D, clock, // Declarar como reg porque son driven en el testbench
    input Bloqueo, Aguja, Alarma
);


  initial begin
    // Inicialización de las señales
    reset = 1; 
    A = 0; 
    B = 0;
    C = 0;
    D = 0;
    clock = 0; 
    
    // Se activa el reset
    #5 reset = 0;
    
    // Escenario de prueba 1. Escenario Ideal.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 1; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 1; C = 0; D = 0;  // Como la contrasena es 00111111, se busca que las
    #4 A = 1; B = 0; C = 0; D = 0;  // ondas de los estados reflejen esos bits. Es un flop por
    #4 A = 1; B = 0; C = 0; D = 0; 
    #1 D = 1;
    #2 D = 0; // bit. Entonces, cada flop va a tener un valor binario.
    #4 A = 0; C = 1; // bit. Entonces, cada flop va a tener un valor binario.
    #4 A = 0; C = 1; // bit. Entonces, cada flop va a tener un valor binario.
    #4 A = 0; C = 0;
    #4 A = 0; C = 0;
    #4 A = 0;

    // Escenario de prueba 2. 2 intentos fallidos consecutivos.
    #10 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 1; C = 0; D = 0;  // Como la contrasena es 00111111, se busca que las
    #4 A = 1; B = 0; C = 0; D = 0;  // ondas de los estados reflejen esos bits. Es un flop por
    #4 A = 1; B = 0; C = 0; D = 0; 
    #1 D = 1;
    #2 D = 0; // bit. Entonces, cada flop va a tener un valor binario.

    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 1; C = 0; D = 0;  // Como la contrasena es 00111111, se busca que las
    #4 A = 1; B = 1; C = 0; D = 0;  // ondas de los estados reflejen esos bits. Es un flop por
    #4 A = 1; B = 1; C = 0; D = 0; 
    #1 D = 1;
    #2 D = 0; // bit. Entonces, cada flop va a tener un valor binario.
    #4 A = 0; B = 0;


  // Escenario de prueba 3. 3 intentos fallidos consecutivos.
    #25 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 1; C = 0; D = 0;  // Como la contrasena es 00111111, se busca que las
    #4 A = 1; B = 1; C = 0; D = 0;  // ondas de los estados reflejen esos bits. Es un flop por
    #4 A = 1; B = 1; C = 0; D = 0; 
    #1 D = 1;
    #2 D = 0; // bit. Entonces, cada flop va a tener un valor binario.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 1; C = 0; D = 0;  // Como la contrasena es 00111111, se busca que las
    #4 A = 1; B = 1; C = 0; D = 0;  // ondas de los estados reflejen esos bits. Es un flop por
    #4 A = 1; B = 1; C = 0; D = 0; 
    #1 D = 1;
    #2 D = 0; // bit. Entonces, cada flop va a tener un valor binario.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 1; C = 0; D = 0;  // Como la contrasena es 00111111, se busca que las
    #4 A = 1; B = 1; C = 0; D = 0;  // ondas de los estados reflejen esos bits. Es un flop por
    #4 A = 1; B = 1; C = 0; D = 0; 
    #1 D = 1;
    #2 D = 0; // bit. Entonces, cada flop va a tener un valor binario.
    #4 A = 0;B = 0;
    
    #35 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 1; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 0; C = 0; D = 0;  // Validacion de la contrasena en base a los estados.
    #4 A = 1; B = 1; C = 0; D = 0;  // Como la contrasena es 00111111, se busca que las
    #4 A = 1; B = 0; C = 0; D = 0;  // ondas de los estados reflejen esos bits. Es un flop por
    #4 A = 1; B = 0; C = 0; D = 0; 
    #1 D = 1;
    #2 D = 0; // bit. Entonces, cada flop va a tener un valor binario.
    #4 A = 0; C = 1; // bit. Entonces, cada flop va a tener un valor binario.
    #4 A = 0; C = 1; // bit. Entonces, cada flop va a tener un valor binario.
    #4 A = 1;

    #50 $finish;
   
  end

  // Generar la señal de reloj
  always begin
    #1 clock = ~clock; // Cambiar el valor de la señal de reloj cada 5 unidades de tiempo
  end 

endmodule
