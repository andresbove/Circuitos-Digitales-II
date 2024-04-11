module me (
    input reset, A, B, C, clock,
    output reg Bloqueo,
    output reg Aguja
);

// Variables internas
reg [7:0] state;
reg [7:0] nxt_state;
reg [7:0] last_state;
reg permiso;

// Variables para el control del tiempo
reg [3:0] contador_tiempo = 0; // Contador de 4 bits para contar hasta 15 segundos
reg [2:0] contador = 0;

// Máquina de estados
always @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= 8'b00000000; 
    end else begin
        state <= nxt_state;
    end

    if (state == 8'b00010100) begin
       permiso = 1'b1; 
    end else begin
        permiso = 1'b0; 
    end

end

// Lógica de próximo estado
always @(*) begin
    nxt_state = state; // Por defecto, próximo estado es el mismo que el estado actual
     

    case(state)
       //89fj'b00000000: if (A == 1 && B == 0) nxt_state <= 8'b00000000;
       8'b00000000: if (A == 1 && B == 1) nxt_state <= 8'b00000001;
       8'b00000001: if (A == 1 && B == 0) nxt_state <= 8'b00000010;
       8'b00000010: if (A == 1 && B == 1) nxt_state <= 8'b00000101;
       8'b00000101: if (A == 1 && B == 0) nxt_state <= 8'b00001010;
       8'b00001010: if (A == 1 && B == 0) nxt_state <= 8'b00010100;

       

        /*default: begin
            //nxt_state = 8'b00000000; // Manejo de estado inesperado
            if (state == last_state) begin
                    contador <= contador + 1;
            end
        end*/
    endcase
    //last_state = state; // Actualizar el último estado

        if (A == 0 && permiso == 1 && C == 0)begin 
        permiso = 1'b0;
        state <= 8'b00000000;
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
    //end

/*
// Incrementar el contador de tiempo en cada ciclo de reloj
always @(posedge clock) begin
    if (reset) begin
        contador_tiempo <= 0;
    end else if (contador_tiempo < 15) begin
        contador_tiempo <= contador_tiempo + 1;
    end
end 

  */  
end

endmodule
