module controlador (
    input reset, A, B, C, D, clock,
    output reg Bloqueo,
    output reg Aguja,
    output reg Alarma
);

// Variables internas
reg [7:0] state;
reg [7:0] nxt_state;
reg [7:0] last_state;
reg permiso;

// Variables para el control del tiempo
//reg [2:0] contador_tiempo = 0; // Contador de 4 bits para contar hasta 15 segundos
reg [1:0] contador = 0;

// Máquina de estados
always @(posedge clock or posedge reset) begin
    if (reset || D == 1) begin
        state <= 8'b00000000; 
    end else begin
        state <= nxt_state;
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

    nxt_state = state; // Por defecto, próximo estado es el mismo que el estado actual
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
