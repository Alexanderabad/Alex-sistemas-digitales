module controlador_leds (
    input wire clk,       // Clock input
    input wire rst,       // Reset input
    input wire avanzar,   // Input to move to the next LED
    input wire reiniciar, // Input to reset to the first LED
    output reg [7:0] led  // 8 LED outputs
);

    reg [2:0] estado_actual; // 3-bit register to hold the current state (0 to 7)

    // Estado actual logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            estado_actual <= 3'd0;
        end else if (reiniciar) begin
            estado_actual <= 3'd0;
        end else if (avanzar) begin
            if (estado_actual == 3'd7) begin
                estado_actual <= 3'd0;
            end else begin
                estado_actual <= estado_actual + 1;
            end
        end
    end

    // LED output logic
    always @(*) begin
        led = 8'b1111_1111; // Default all LEDs off
        case (estado_actual)
            3'd0: led = 8'b1111_1110;
            3'd1: led = 8'b1111_1101;
            3'd2: led = 8'b1111_1011;
            3'd3: led = 8'b1111_0111;
            3'd4: led = 8'b1110_1111;
            3'd5: led = 8'b1101_1111;
            3'd6: led = 8'b1011_1111;
            3'd7: led = 8'b0111_1111;
            default: led = 8'b1111_1111;
        endcase
    end

endmodule