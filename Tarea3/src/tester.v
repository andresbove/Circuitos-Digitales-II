module tester (
    input BALANCE_ACTUALIZADO,
    input ENTREGAR_DINERO,
    input PIN_INCORRECTO,
    input ADVERTENCIA,
    input BLOQUEO,
    input FONDOS_INSUFICIENTES,
    
    output reg reset, TARGETA_RECIBIDA, TIPO_TRANS, DIGITO_STB, MONTO_STB, clock,
    //input wire [3:0] num, // Número binario de 4 bits a insertar
    output reg [31:0] MONTO,  
    output reg [3:0] DIGITO, // número en el boton en binario (4 bits)
    output reg  [15:0] PIN // Declarar PIN como un registro    
);



  initial begin
    // Inicialización de las señales
    clock = 0;
    reset = 1; 
    TARGETA_RECIBIDA = 0; 
    MONTO_STB = 0;
    MONTO = 0; 
    //DIGITO = 0; 
    PIN = 0; 
    
    // Prueba 1
    #5 reset = 0;
    #5 reset = 1;
    #15 reset = 1; TARGETA_RECIBIDA = 1 ; PIN = 16'b0110100101101001;
    #5 DIGITO = 4'b0110; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #5 DIGITO = 4'b1001; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #5 DIGITO = 4'b0110; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #5 DIGITO = 4'b1001; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #3 TIPO_TRANS = 0;
    #3 MONTO = 5000; MONTO_STB = 1;
    
    #3 TIPO_TRANS = 1;
    #3 MONTO = 5000; MONTO_STB = 1;
    #3 reset = 0;
    #3 reset = 0;
    #3 TIPO_TRANS = 0;
    #6 reset = 1;TARGETA_RECIBIDA = 0;

    #8 TARGETA_RECIBIDA = 1 ; PIN = 16'b0110100101101001;
    #5 DIGITO = 4'b0100; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #5 DIGITO = 4'b0100; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #5 DIGITO = 4'b0100; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #5 DIGITO = 4'b0100; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #3 MONTO = 5000; MONTO_STB = 1;


    #8 TARGETA_RECIBIDA = 1 ; PIN = 16'b0110100101101001;
    #5 DIGITO = 4'b0100; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #5 DIGITO = 4'b0100; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #5 DIGITO = 4'b0100; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #5 DIGITO = 4'b0100; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #3 MONTO = 5000; MONTO_STB = 1;


    #8 TARGETA_RECIBIDA = 1 ; PIN = 16'b0110100101101001;
    #5 DIGITO = 4'b0100; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #5 DIGITO = 4'b0100; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #5 DIGITO = 4'b0100; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #5 DIGITO = 4'b0100; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #3 MONTO = 5000; MONTO_STB = 1;

    #8 TARGETA_RECIBIDA = 1 ; PIN = 16'b0110100101101001;
    #5 DIGITO = 4'b0100; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #5 DIGITO = 4'b0100; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #5 DIGITO = 4'b0100; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #5 DIGITO = 4'b0100; DIGITO_STB = 1;
    #3 DIGITO_STB = 0;DIGITO = 0;
    #3 MONTO = 5000; MONTO_STB = 1;


   #50 $finish;
   
  end

  // Generar la señal de reloj
  always begin
    #2 clock = ~clock; // Cambiar el valor de la señal de reloj cada 5 unidades de tiempo
  end 

endmodule
