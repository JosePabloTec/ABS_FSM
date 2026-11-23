// Testbench
// Jose Pablo Manriquez Amavizca
// A01708548

`timescale 1ns/1ps

module FSM_tb;

    reg clk;  // Registro para generar la señal de reloj
    reg rst;  // Registro para accionar la señal de reset
    reg brake; // Registro para simular una entrada de freno
    reg lock;  // Registro para simular una señal de bloqueo
    wire [1:0] state; // 2 bits para observar el estado actual de la FSM, 00 | 01 | 10 | 11 : s0 | s1 | s2 | s3

    // Instanciamos la maquina de estados FSM
    FSM uut (
        .clk(clk), // Conectamos la señal de reloj
        .rst(rst), // la señal de renicio
        .brake(brake), //la entrada de freno
        .lock(lock),   // la nntrada de lock
        .state(state) // estado actual de nuestra FSM
    );

    // Generamos la señal de reloj con un periodo de 10 ns
    always #5 clk = ~clk; // como cada 5 ns cambia el reloj, su periodo es de 10ns vamos a tener que esperar 10 ns para ver las transiciones

    initial begin

        // Generamos el archivo de ondas para GTKWave
        $dumpfile("ondas.vcd");
        $dumpvars(0, FSM_tb);

        // Inicializamos las señales
        clk = 0;
        rst = 1;
        brake = 0;
        lock = 0;

        // Reiniciamos la FSM 
        #10 rst = 0; // esperar 10ns y resetear

        // Transicion 1: S0 a S0 (brake = 0, lock = X)
        brake = 0;
        lock = 0;
        #10; //esperar 10 ns
        // Transicion 2: S0 a S1 (brake = 1, lock = X)
        brake = 1;
        #10;
        // Transicion 3: S1 a S0 (brake = 0, lock = X)
        brake = 0;
        #10;
        // Transicion intermedia: S0 a S1
        brake = 1;
        #10;
        // Transicion 4: S1 a S1 (brake = 1, lock = 0)
        lock = 0;
        #10;
        // Transicion 5: S1 a S2 (brake = 1, lock = 1)
        lock = 1;
        #10;
        // Transicion 6: S2 a S0 (brake = 0, lock = X)
        brake = 0;
        #10;
        // Transicion intermedia: S0 a S1 a S2
        brake = 1;
        #10;
        lock = 1;
        #10;
        // Transicion 7: S2 a S3 (brake = 1, lock = 0)
        lock = 0;
        #10;
        // Transicion intermedia: S3 a S0
        brake = 0;
        #10;
        // Transicion intermedia: S0 a S1 a S2
        brake = 1;
        #10;
        lock = 1;
        #10;
        // Transicion 8: S2 a S2 (brake = 1, lock = 1)
        lock = 1;
        #10;
        // Transicion intermedia: S2 a S0
        brake = 0;
        #10;
        // Transicion intermedia: S0 a S1 a S2 a S3
        brake = 1;
        #10;
        lock = 1;
        #10;
        lock = 0;
        #10;
        // Transicion 9: S3 a S0 (brake = 0, lock = X)
        brake = 0;
        #10;
        // Transicion intermedia: S0 a S1 a S2 a S3
        brake = 1;
        #10;
        lock = 1;
        #10;
        lock = 0;
        #10;
        // Transicion 10: S3 a S1 (brake = 1, lock = 0)
        brake = 1;
        lock = 0;
        #10;
        // Transicion intermedia: S1 a S2 a S3
        lock = 1;
        #10;
        lock = 0;
        #10;
        // Transicion 11: S3 a S2 (brake = 1, lock = 1)
        lock = 1;
        #10;
        // Fin
        $finish;
    end

endmodule

// Transiciones esperadas: S0 a S0, S0 a S1, S1 a S0, S1 a S1, S1 a S2, S2 a S0, S2 a S3, S2 a S2, S3 a S0, S3 a S1, S3 a S2
// Transiciones esperadas: 00 a 00, 00 a 01, 01 a 00, 01 a 01, 01 a 10, 10 a 00, 10 a 11, 10 a 10, 11 a 00, 11 a 01, 11 a 10