module controlador (
    input reset, TARGETA_RECIBIDA, TIPO_TRANS, DIGITO_STB, MONTO_STB, clock,
    //input wire [3:0] num, // Número binario de 4 bits a insertar
    input [31:0] MONTO,  
    input [3:0] DIGITO, // número en el boton en binario (4 bits)
    input  [15:0] PIN, // Declarar PIN como un registro    
    output reg BALANCE_ACTUALIZADO,
    output reg ENTREGAR_DINERO,
    output reg PIN_INCORRECTO,
    output reg ADVERTENCIA,
    output reg BLOQUEO,
    output reg FONDOS_INSUFICIENTES
);

// Variables internas
reg [63:0] BALANCE = 155000;
reg [1:0] INTENTOS;
reg [15:0] pin_interno;
reg [15:0] nxt_state;
reg [3:0] contadorInterno;


// Máquina de estados
always @(posedge clock) begin
    if (reset == 0) begin
        pin_interno <= 16'b0000000000000000;
        BALANCE_ACTUALIZADO = 0;
        ENTREGAR_DINERO = 0;
        PIN_INCORRECTO = 0;
        ADVERTENCIA = 0;
        BLOQUEO = 0;
        FONDOS_INSUFICIENTES = 0;
        INTENTOS = 0;
        pin_interno = 0;
        nxt_state = 0;
        contadorInterno = 0;
    end else begin
        // para el FF, 'pin_interno'(state) depende de 'nxt_state'. 
        pin_interno <= nxt_state; 
        //'pin_interno'(state) se actualiza con el valor de estado siguiente, en todos los flancos positivos del clock
    end
if (TARGETA_RECIBIDA != 1'b1) begin
    BALANCE = 64'd155000; // Asegurándote de que BALANCE sea un registro de 64 bits
    PIN_INCORRECTO = 1;
end

if (TARGETA_RECIBIDA == 1'b1) begin
   if (DIGITO_STB == 1'b1) begin
      // Desplazar el registro 4 bits a la izquierda e insertar el digito ingresado en cada ciclo positivo de clock
    pin_interno <= {pin_interno[11:0], DIGITO}; // Es un registro desplazable que se usa para guardar 'DIGITO' en 'pin_interno'
   contadorInterno = contadorInterno + 1; 
   end
end

if (contadorInterno == 4 && pin_interno != PIN) begin
    PIN_INCORRECTO = 1; 
    INTENTOS = INTENTOS + 1;
    contadorInterno = 0;     end
 end

// Lógica de próximo estado
always @(*) begin
// PIN_INCORRECTO = 1'b1; // Si el PIN es incorrecto
nxt_state <= pin_interno; // se almacena el estado anterior cuando no hayan flancos positivos. el proximo estado será el estado anterior.

if (DIGITO_STB == 1'b1) begin
if (pin_interno == PIN) begin
    PIN_INCORRECTO = 0; 
    INTENTOS = 0;
end end


if (TIPO_TRANS == 0 && PIN_INCORRECTO == 0) begin
        BALANCE = MONTO + BALANCE;
        BALANCE_ACTUALIZADO = 1;
       // #1 BALANCE_ACTUALIZADO = 0;
end

if (TIPO_TRANS == 1 && PIN_INCORRECTO == 0 && MONTO < BALANCE) begin
        BALANCE = BALANCE - MONTO;
        ENTREGAR_DINERO = 1;
        BALANCE_ACTUALIZADO = 1;
        //BALANCE_ACTUALIZADO = 0;
end

if (TIPO_TRANS == 1 && PIN_INCORRECTO == 0 && MONTO > BALANCE) begin
FONDOS_INSUFICIENTES = 1;
end

if (INTENTOS == 2)begin
    ADVERTENCIA = 1;
 end

 if (INTENTOS == 3)begin
    BLOQUEO = 1;
end
 
end


always @(negedge clock) begin
    BALANCE_ACTUALIZADO = 0;
end
endmodule