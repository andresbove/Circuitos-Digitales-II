module SPI_Master(
    input wire CLK,   // Clock de entrada
    input wire reset, // Señal de reset
    output reg SCK,   // Clock de salida
    output reg MOSI,  // Salida MOSI
    output reg CS,    // Chip Select
    input wire MISO   // Entrada MISO
);

// Parámetros de configuración
parameter CKP = 1;  // Polarity del reloj
parameter CPH = 1;  // Fase del reloj

/*codificacion de estados*/
// Definición de parámetros para los estados
parameter S1 = 4'b0000;     // revisar Reset
parameter S2 = 4'b0001;     // configuracion de SCK 
parameter S3 = 4'b0010;     // SCK empieza en 0, 1er flanco. Va al estado 7
parameter S4 = 4'b0011;     // SCK empieza en 0, 2do flanco. Va al estado 8
parameter S5 = 4'b0100;     // SCK empieza en 1, 1er flanco. Va al estado 9 
parameter S6 = 4'b0101;     // SCK empieza en 1, 2do flanco. Va al estado 10
parameter S7 = 4'b0110;     // Mueve el registro desplazable para el estado 3
parameter S8 = 4'b0111;     // Mueve el registro desplazable para el estado 4

/*Definición de registros para guardar informacion*/
reg [3:0] state, next_state;    // Definición de Registros para guardar los estados. 4 bits ya que son 10 estados

reg [7:0] array1 = 8'b00000001; // Valor predeterminado para array1. 1 en decimal
reg [7:0] array2 = 8'b00000010; // Valor predeterminado para array2. 2 en decimal

reg [1:0] clk_divider = 2'b00;  // Contador para dividir la frecuencia de CLK

/*Máquina de estados*/
always @(posedge CLK or posedge reset) begin // Flip Flops
    if (reset) begin
        SCK = 0;
        MOSI = 0;
        CS = 0;
    end else begin
        state <= S1;                        // siempre que hay un reset, se va al estado S1 
        state <= next_state;                // para el FF, state depende de 'nxt_state'
    end
end

/*Logica de proximo estado*/
always @(*) begin
    next_state = state;
    case(state)
        4'b0000: begin                    // Estado 1. Si reset es 1 se reinician todas las salidas y se va al Estado 2.
            if (reset) begin
                SCK <= 0;            // SCK en 0   
                next_state = S2;     // Se va al Estado 2.
                CS = 1;              // CS en 1 (deseleccionado por defecto)
            end else begin         
                next_state = S1;     // sino hay reset se queda hasta que haya uno
            end
        end
        4'b0001: begin                            // Estado 2. Configuracion de SCK. Dependiendo del valor de
            case({CKP, CPH})                // CKP y CPH, se irá a un estado u otro
                2'b00: next_state = 4'b0011;     // CKP = 0 y CPH = 0, se va al estado 3
                2'b01: next_state = 4'b0100;     // CKP = 0 y CPH = 1, se va al estado 4
                2'b10: next_state = 4'b0101;     // CKP = 1 y CPH = 0, se va al estado 5     
                2'b11: next_state = 4'b0110;     // CKP = 1 y CPH = 1, se va al estado 6
            endcase
        end
        4'b0010: begin                   // Estado 3. Se establece el valor inicial de SCK como 0 y se va al estado 7
            SCK <= 0;               // SCK = 0
            CS <= 0;                // Habilita el Chip Select
            next_state = S7;        // Se va al estado 7, de flancos positivos
        end
        4'b0011: begin                   // Estado 4. Se establece el valor inicial de SCK como 0 y se va al estado 8
            SCK <= 0;               // SCK = 0
            CS <= 0;                // Habilita el Chip Select
            next_state = S8;        // Se va al estado 8, de flancos negativos
        end
        4'b0100: begin                   // Estado 5. Se establece el valor inicial de SCK como 1 y se va al estado 9
            SCK <= 1;               // SCK = 1
            CS <= 0;                // Habilita el Chip Select
            next_state = S8;        // Se va al estado 8, de flancos negativos
        end
        4'b0101: begin                   // Estado 6. Se establece el valor inicial de SCK como 0 y se va al estado 7
            SCK <= 1;               // SCK = 1
            CS <= 0;                // Habilita el Chip Select
            next_state = S7;        // Se va al estado 7, de flancos positivos
        end
        4'b0110: begin                   // Estado 7. Mueve el registro desplazable para el estado 3
            // Desplazamiento
            // Desplazamiento del array1
            array1 <= {array2[7], array1[7:1]};
            // Desplazamiento del array2
            array2 <= {MISO, array2[7:1]};
            MOSI <= array1[0];      // Actualización de MOSI
            next_state = S3;        // Se va al estado 3
        end
        4'b0111: begin                   // Estado 8. Mueve el registro desplazable para el estado 4
            // Desplazamiento del array1
            array1 <= {array2[7], array1[7:1]};
            // Desplazamiento del array2
            array2 <= {MISO, array2[7:1]};
            MOSI <= array1[0];      // Actualización de MOSI
            next_state = S4;        // Se va al estado 4
        end
        default: next_state = S1;   // Estado por defecto es S1
    endcase
end

always @(posedge CLK) begin
    if (clk_divider == 2'b11) begin
        clk_divider <= 2'b00;  // Reset del contador
        SCK <= ~SCK;            // Invertir el valor de SCK cada vez que se alcance el divisor de frecuencia
    end else begin
        clk_divider <= clk_divider + 1; // Incrementar el contador
    end
end

endmodule
