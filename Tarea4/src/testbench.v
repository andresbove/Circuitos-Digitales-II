`include "maestro.v"
`include "esclavo.v"

module testbench();

    // Definición de los wires y regs para conectar los módulos
    reg CLK, reset;
    wire SCK, MOSI, SS, MISO;

    // Instanciación de los módulos SPI_Master y SPI_Slave
    SPI_Master master(
        .CLK(CLK),
        .reset(reset),
        .SCK(SCK),
        .MOSI(MOSI),
        .CS(SS),
        .MISO(MISO)
    );

    SPI_Slave slave(
        .SCK(SCK),
        .MOSI(MOSI),
        .SS(SS),
        .MISO(MISO)
    );

    // Generación de clock
    always #5 CLK = ~CLK;

    // Generación de reset
    initial begin
        reset = 1;
        #10 reset = 0;

    end

    // Testcase
    initial begin
        // Configuración inicial
        #20;
        // Inicio de la comunicación
        // Aquí puedes añadir tus propias secuencias de prueba
        // por ejemplo, cambiar el valor de MOSI en momentos específicos
        // y comprobar si MISO refleja correctamente esos cambios
        #100 $finish;
    end

endmodule
