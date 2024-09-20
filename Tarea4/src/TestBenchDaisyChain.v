`include "maestro.v"
`include "esclavo.v"

module tb_SPI;

// Entradas del maestro
reg CLK;
reg reset;
wire MISO; // Cambiado de reg a wire

// Salidas del maestro
wire SCK;
wire MOSI;
wire CS;

// Entradas del esclavo
wire SS;
wire SCK_slave;
wire MOSI_slave;

// Salidas del esclavo
wire MISO_slave1;
wire MISO_slave2;

// Conectando las señales
assign SS = CS; // En modo daisy chain, el chip select del esclavo se conecta al chip select del maestro
assign SCK_slave = SCK;
assign MOSI_slave = MOSI;
assign MISO_slave1 = MISO;
assign MISO_slave2 = MISO_slave1; // El MISO del segundo esclavo se conecta al MISO del primer esclavo

// Instancia del maestro SPI
SPI_Master uut_master (
    .CLK(CLK),
    .reset(reset),
    .SCK(SCK),
    .MOSI(MOSI),
    .CS(CS),
    .MISO(MISO)
);

// Instancia del primer esclavo SPI
SPI_Slave uut_slave1 (
    .SCK(SCK_slave),
    .MOSI(MOSI_slave),
    .SS(SS),
    .MISO(MISO_slave1) // Conexión del MISO del primer esclavo
);

// Instancia del segundo esclavo SPI
SPI_Slave uut_slave2 (
    .SCK(SCK_slave),
    .MOSI(MOSI_slave),
    .SS(SS), // Misma señal de selección de esclavo para ambos
    .MISO(MISO_slave2) // Conexión del MISO del segundo esclavo
);

// Generación del reloj
always #5 CLK = ~CLK; // Periodo de reloj de 10 unidades de tiempo

initial begin
    // Inicialización de las señales
    CLK = 0;
    reset = 1;
    $display("Inicializando la simulacion");
    $display("Time = %0t, CLK = %b, reset = %b, MISO = %b, SCK = %b, MOSI = %b, CS = %b, MISO_slave1 = %b, MISO_slave2 = %b", 
             $time, CLK, reset, MISO, SCK, MOSI, CS, MISO_slave1, MISO_slave2);

    // Generar archivo de volcado
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_SPI);

    // Esperar algunos ciclos para reset
    #20;
    reset = 0;

    // Esperar suficiente tiempo para ver la comunicación
    #200;
    $display("Finalizando la simulacion");
    $display("Time = %0t, CLK = %b, reset = %b, MISO = %b, SCK = %b, MOSI = %b, CS = %b, MISO_slave1 = %b, MISO_slave2 = %b", 
             $time, CLK, reset, MISO, SCK, MOSI, CS, MISO_slave1, MISO_slave2);

    // Terminar la simulación
    $finish;
end

// Monitorización de señales
initial begin
    $monitor("Time = %0t, CLK = %b, reset = %b, MISO = %b, SCK = %b, MOSI = %b, CS = %b, MISO_slave1 = %b, MISO_slave2 = %b", 
             $time, CLK, reset, MISO, SCK, MOSI, CS, MISO_slave1, MISO_slave2);
end

endmodule
