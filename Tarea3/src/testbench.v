`include "tester.v"
`include "Tarea3.v"

module controlador_TB;
        // Señales de salida

    wire reset;
    wire TARGETA_RECIBIDA;
    wire TIPO_TRANS;
    wire DIGITO_STB;
    wire MONTO_STB;
    wire clock;
    //wire wire [3:0] num, // Número binario de 4 bits a insertar
    wire [31:0] MONTO;
    wire [3:0] DIGITO; // número en el boton en binario (4 bits)
    wire  [15:0] PIN; // Declarar PIN como un registro    
    wire BALANCE_ACTUALIZADO;
    wire ENTREGAR_DINERO;
    wire PIN_INCORRECTO;
    wire ADVERTENCIA;
    wire BLOQUEO;
    wire FONDOS_INSUFICIENTES;

   // wire valid;
    
    // Generación de estímulo
    initial begin
        $dumpfile("testbench.vcd"); // Genera un archivo VCD para ver la simulación
        $dumpvars(-1, DUT); // Agrega todas las variables a ser volcadas en el archivo VCD
    end

        // Instancia del módulo a testear
        
    controlador DUT (
        // .señal_instanciada(señal_TestBench),
        .reset(reset),
        .TARGETA_RECIBIDA(TARGETA_RECIBIDA),
        .TIPO_TRANS(TIPO_TRANS),
        .MONTO_STB(MONTO_STB),
        .DIGITO_STB(DIGITO_STB),
        .clock(clock),
        .MONTO(MONTO),
        .DIGITO(DIGITO),
        .PIN(PIN),
        .BALANCE_ACTUALIZADO(BALANCE_ACTUALIZADO),
        .ENTREGAR_DINERO(ENTREGAR_DINERO),
        .PIN_INCORRECTO(PIN_INCORRECTO),
        .ADVERTENCIA(ADVERTENCIA),
        .BLOQUEO(BLOQUEO),
        .FONDOS_INSUFICIENTES(FONDOS_INSUFICIENTES)
    );


    tester P0 (
        // .señal_instanciada(señal_TestBench),
        .reset(reset),
        .TARGETA_RECIBIDA(TARGETA_RECIBIDA),
        .TIPO_TRANS(TIPO_TRANS),
        .DIGITO_STB(DIGITO_STB),
        .clock(clock),
        .MONTO(MONTO),
        .MONTO_STB(MONTO_STB),
        .DIGITO(DIGITO),
        .PIN(PIN),
        .BALANCE_ACTUALIZADO(BALANCE_ACTUALIZADO),
        .ENTREGAR_DINERO(ENTREGAR_DINERO),
        .PIN_INCORRECTO(PIN_INCORRECTO),
        .ADVERTENCIA(ADVERTENCIA),
        .BLOQUEO(BLOQUEO),
        .FONDOS_INSUFICIENTES(FONDOS_INSUFICIENTES)
    );
endmodule