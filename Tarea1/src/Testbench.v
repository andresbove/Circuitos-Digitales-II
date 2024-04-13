`include "probador.v"
`include "Tarea1.v"

module controlador_TB;
        // Señales de salida
    wire Bloqueo;
    wire Aguja;
    wire Alarma;
    wire A;
    wire B;
    wire C;
    wire clock;
    wire reset;
    wire cont;

   // wire valid;
    
    // Generación de estímulo
    initial begin
        $dumpfile("testbench.vcd"); // Genera un archivo VCD para ver la simulación
        $dumpvars(-1, DUT); // Agrega todas las variables a ser volcadas en el archivo VCD
    end

        // Instancia del módulo a testear
    controlador DUT (
        .reset(reset),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .Bloqueo(Bloqueo),
        .Aguja(Aguja),
        .clock(clock),
        .Alarma(Alarma)
       // .valid(valid)
    );


    probador P0 (
        .reset(reset),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .Bloqueo(Bloqueo),
        .Aguja(Aguja),
        .clock(clock),
        .Alarma(Alarma)
       // .valid(valid)
    );
//cambio para notar push
endmodule