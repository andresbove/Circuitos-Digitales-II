module controlador (
    input reset, TARGETA_RECIBIDA, TIPO_TRANS, DIGITO_STB, MONTO_STB, 
    input [31:0] MONTO,
    input [3:0] DIGITO,
    input [15:0] PIN,
    output reg BALANCE_ACTUALIZADO,
    output reg ENTREGAR_DINERO,
    output reg PIN_INCORRECTO,
    output reg ADVERTENCIA,
    output reg BLOQUEO,
    output reg FONDOS_INSUFICIENTES,
);

// Variables internas
reg [7:0] state;
reg [7:0] nxt_state;
reg [7:0] last_state;
reg permiso;

// Variables para el control del tiempo
reg [1:0] contador = 0;

// Máquina de estados
always @(posedge clock or posedge reset) begin
    if (reset || D == 1) begin
        state <= 8'b00000000; 
    end else begin
        state <= nxt_state; // para el FF: 'state' depende de 'nxt_state'
    end

    if (state == 8'b00010100 && D == 1'b1) begin
       permiso = 1'b1;
    end

    if (state != 8'b00010100 && D == 1'b1)begin
    contador = contador + 1;end

    
    if (A == 0) begin
        // Si A y B son 1, y C es 0, levantar la aguja
        contador <= 2'b00;
    end 

    if (contador == 3)begin 
        Alarma = 1;
    end else begin 
        Alarma = 0;
    end
end

// Lógica de próximo estado
always @(*) begin

    nxt_state = state; // // para la logica combinacional: 'nxt_state' depende de 'state'
    case(state)
       8'b00000000: if (A == 1 && B == 1) nxt_state <= 8'b00000001;
       8'b00000001: if (A == 1 && B == 0) nxt_state <= 8'b00000010;
       8'b00000010: if (A == 1 && B == 1) nxt_state <= 8'b00000101;
       8'b00000101: if (A == 1 && B == 0) nxt_state <= 8'b00001010;
       8'b00001010: if (A == 1 && B == 0) nxt_state <= 8'b00010100;
    endcase
    //last_state = state; // Actualizar el último estado

        
        if (A == 0 && C == 0)begin 
        permiso = 1'b0;
        state <= 8'b00000000;
       //contador <= 2'b00;
        end

         if (A == 1 && permiso == 1 && C == 1) begin
            // Si A y B son 0, y C es 1, bajar la aguja
            Aguja = 1;
            Bloqueo = 1;
         end else begin
            Bloqueo = 0;
            end
        if (A == 0 && permiso == 1 && C == 1) begin
            // Si A y B son 0, y C es 1, bajar la aguja
            Aguja = 1;
            Bloqueo = 0;
           // contador <= 2'b00;

        end else if (A == 1 && permiso == 1 && C == 0) begin
            // Si A y B son 1, y C es 0, levantar la aguja
            Aguja = 1;
        end else if (A == 1 && permiso == 0) begin
            // Si A y B son 1, y C es 0, levantar la aguja
            Aguja = 0;
        end else if (A == 0) begin
            // Si A y B son 1, y C es 0, levantar la aguja
            Aguja = 0;
        end
end

endmodule
