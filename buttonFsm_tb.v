`timescale 1ns / 1ps

module buttonFsm_tb;

reg clk;
reg button;
wire stateful_button; 
localparam period = 2;
integer i, limit, file;

buttonFsm UUT(
    .clk(clk),
    .button(button),
    .stateful_button(stateful_button)
);

initial clk=0;
always #period clk=~clk;

always @(posedge clk) begin
    $display("Time %0t (posedge) current output %0d", $time, stateful_button);
    $fdisplay(file,"Time %0t (posedge) current output %0d", $time, stateful_button);
end
always @(negedge clk) begin
    $display("Time %0t (negedge) current output %0d", $time, stateful_button);
    $fdisplay(file,"Time %0t (negedge) current output %0d", $time, stateful_button);
end

initial 
begin
    limit = 100;
    $timeformat(-9, 0, " ns", 20);
    file = $fopen("buttonFsm.log","a");
    $display("Time %0t pre-initial output %0d", $time, stateful_button);
    $fdisplay(file,"Time %0t pre-initial output %0d", $time, stateful_button);
    #(period/2)
    $display("Time %0t initial output %0d\n", $time, stateful_button);
    $fdisplay(file, "Time %0t initial output %0d\n", $time, stateful_button);
    for (i = 0; i<limit; i=i+1) begin
        button = $random % 2;
        $display("Time %0t current output %0d input %0d", $time, stateful_button,button);
        $fdisplay(file, "Time %0t current output %0d input %0d", $time, stateful_button,button);
        #period
        #period
        $display("Time %0t next output %0d\n", $time, stateful_button);
        $fdisplay(file, "Time %0t next output %0d\n", $time, stateful_button);
    end;
    $fclose(file);
    $finish;
end

endmodule