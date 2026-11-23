// FSM Moore 4 estados: ABS
// Jose Pablo Manriquez Amavizca
// A01708548



module FSM (
    input wire clk, // señal de relog
    input wire rst, // señal de reinicio
    input wire brake, // break, representa el accionamiento del freno
    input wire lock,  // representa un bloqueo en el ABS
    output reg [1:0] state // estado actual
);

    // los cuatro estados
    localparam S0 = 2'b00,  // Idle valve = 00
               S1 = 2'b01,  // Pressure_inc valve = 01
               S2 = 2'b10,  // Pressure_reelase valve = 10
               S3 = 2'b11;  // Pressure_hold valve = 11

    reg [1:0] next_state;   // estado siguiente

    always @(posedge clk or posedge rst) begin // ejecutamos cuando ocurre un flanco de reloj o un reset
        if (rst) // si es reset, l estado es Idle por default
            state <= S0;
        else
            state <= next_state; // si notod va bien, actualizamos el estado al estado siguiente
    end

    // Ahora codificamos las 11 transiciones que habíamos propuesto en la tabla
    always @(*) begin  // cada vez que cambia alguna de las señales de entrada se vuelve a evaluar la lógica, es combinacional
        case (state)
            S0: begin
                if (brake == 0)
                    next_state = S0;
                else
                    next_state = S1;
            end

            S1: begin
                if (brake == 0)
                    next_state = S0;
                else if (lock == 0)
                    next_state = S1;
                else
                    next_state = S2;
            end

            S2: begin
                if (brake == 0)
                    next_state = S0;
                else if (lock == 0)
                    next_state = S3;
                else
                    next_state = S2;
            end

            S3: begin
                if (brake == 0)
                    next_state = S0;
                else if (lock == 0)
                    next_state = S1;
                else
                    next_state = S2;
            end
        endcase

    end

endmodule