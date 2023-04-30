module trafikIsigi (
    input clk,
    output reg red,
    output reg green,
    output reg blue
);

reg [23:0] counter;
reg [1:0] state;

localparam [1:0] KIRMIZI = 2'b00;
localparam [1:0] MAVI = 2'b01;
localparam [1:0] YESIL = 2'b10;

always @(posedge clk) begin
    
    counter <= counter + 1;

    case (state)
        KIRMIZI: begin
            if (counter >= 24'd240_000_000) begin
                red <= 0;
                green <= 1;
                blue <= 1;
                state <= MAVI;
                counter <= 0;
            end
        end
        MAVI: begin
            if (counter >= 24'd48_000_000) begin
                red <= 1;
                green <= 1;
                blue <= 0;
                state <= YESIL;
                counter <= 0;
            end
        end
        YESIL: begin
            if (counter >= 24'd120_000_000) begin
                red <= 1;
                green <= 0;
                blue <= 1;
                state <= KIRMIZI;
                counter <= 0;
            end
        end
        default: begin
            red <= 1;
            green <= 1;
            blue <= 1;
            state <= KIRMIZI;
            counter <= 0;
        end
    
    endcase
end

endmodule