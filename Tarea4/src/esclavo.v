module SPI_Slave(
    input wire SCK,   // Clock de entrada
    input wire MOSI,  // entrada MOSI
    input wire SS,    // Slave Select
    output reg MISO   // Salida MISO
);


// Parámetros de configuración
parameter CKP = 1;  // Polarity del reloj
parameter CPH = 1;  // Fase del reloj

/*codificacion de estados*/
// Definición de parámetros para los estados
parameter S2 = 4'b0001;     // configuracion de SCK 
parameter S3 = 4'b0010;     // SCK empieza en 0, 1er flanco. Va al estado 7
parameter S4 = 4'b0011;     // SCK empieza en 0, 2do flanco. Va al estado 8
parameter S5 = 4'b0100;     // SCK empieza en 1, 1er flanco. Va al estado 9 
parameter S6 = 4'b0101;     // SCK empieza en 1, 2do flanco. Va al estado 10
parameter S7 = 4'b0110;     // Mueve el registro desplazable para el estado 3
parameter S8 = 4'b0111;     // Mueve el registro desplazable para el estado 4

/*Definición de registros para guardar informacion*/
reg [3:0] state, next_state;    // Definición de Registros para guardar los estados. 4 bits ya que son 10 estados

reg [7:0] array2 = 8'b00000010; // Valor predeterminado para array1. 2 en decimal
reg [7:0] array1 = 8'b00000000; // Valor predeterminado para array2. 0 en decimal


/*Máquina de estados*/
always @(posedge SCK) begin // Flip Flops
    if (SS) begin
        state <= S2;                        // siempre que hay un SS, se va al estado S2 
    end else begin
        state <= next_state;                // para el FF, state depende de 'nxt_state'
    end
end

/*Logica de proximo estado*/
always @(*) begin
        next_state = state;
    case(state)
        S2: begin                            // Estado 2. Configuracion de SCK. Dependiendo del valor de
            case({CKP, CPH})                // CKP y CPH, se irá a un estado u otro
                2'b00: next_state = S3;     // CKP = 0 y CPH = 0, se va al estado 3
                2'b01: next_state = S4;     // CKP = 0 y CPH = 1, se va al estado 4
                2'b10: next_state = S5;     // CKP = 1 y CPH = 0, se va al estado 5     
                2'b11: next_state = S6;     // CKP = 1 y CPH = 1, se va al estado 6
            endcase
        end
        S3: begin                   // Estado 3. Se establece el valor inicial de SCK como 0 y se va al estado 7
            if (SS == 1) 
                next_state = S7;  // Se va al estado 7, de flancos positivos
            else
                next_state = S2;  // Volver al estado 2 si no se selecciona el dispositivo
        end
        S4: begin                   // Estado 4. Se establece el valor inicial de SCK como 0 y se va al estado 8
            if (SS == 1) 
                next_state = S8;  // Se va al estado 8, de flancos negativos
            else
                next_state = S2;  // Volver al estado 2 si no se selecciona el dispositivo
        end
        S5: begin                   // Estado 5. Se establece el valor inicial de SCK como 1 y se va al estado 9
            if (SS == 1) 
                next_state = S8;  // Se va al estado 8, de flancos negativos
            else
                next_state = S2;  // Volver al estado 2 si no se selecciona el dispositivo
        end
        S6: begin                   // Estado 6. Se establece el valor inicial de SCK como 0 y se va al estado 7
            if (SS == 1) 
                next_state = S7;  // Se va al estado 7, de flancos positivos
            else
                next_state = S2;  // Volver al estado 2 si no se selecciona el dispositivo
        end
        S7: begin
            next_state = S3;        // Volver al estado 3 después de mover el registro desplazable
        end
        S8: begin
            next_state = S4;        // Volver al estado 4 después de mover el registro desplazable
        end
        default: next_state = S2;
    endcase
end

always @(posedge SCK) begin
    if (SS) begin
        // Desplazamiento del array1
        array1 <= {array2[7], array1[7:1]};
        // Desplazamiento del array2
        array2 <= {MOSI, array2[7:1]};
        // Actualización de MISO
        MISO <= array1[0];
    end
end

endmodule
