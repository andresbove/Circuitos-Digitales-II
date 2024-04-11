`include "probador.v"
`include "Tarea1.v"

module aguja_tb;
        // Señales de salida
    wire Bloqueo;
    wire Aguja;
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
        $dumpvars(-1, uut); // Agrega todas las variables a ser volcadas en el archivo VCD
    end

        // Instancia del módulo a testear
    me uut (
        .reset(reset),
        .A(A),
        .B(B),
        .C(C),
        .Bloqueo(Bloqueo),
        .Aguja(Aguja),
        .clock(clock)
       // .valid(valid)
    );


    probador P0 (
        .reset(reset),
        .A(A),
        .B(B),
        .C(C),
        .Bloqueo(Bloqueo),
        .Aguja(Aguja),
        .clock(clock)
       // .valid(valid)
    );

endmodule