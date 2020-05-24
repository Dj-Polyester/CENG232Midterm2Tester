`timescale 1ns / 1ps

module rtcClkDivider_tb;

reg sys_clk;    // 1 MHz
wire clk_500Hz; // 500 Hz
wire clk_5s;  // 0.2 Hz
integer file, i, j, limit;
localparam period = 500;
defparam UUT.KEYCHANGE_PERIOD = 0.5;

rtcClkDivider UUT(
    .sys_clk(sys_clk),
    .clk_500Hz(clk_500Hz),
    .clk_5s(clk_5s)
);
initial sys_clk=0;
always #period sys_clk=~sys_clk;
always @( UUT.clk_5s ) begin
	$display("Time %0t sys_clk %0d clk_5s %0d",$time,sys_clk,UUT.clk_5s);
	$fdisplay(file,"Time %0t sys_clk %0d clk_5s %0d",$time,sys_clk,UUT.clk_5s);
end
always @( UUT.clk_500Hz ) begin
	$display("Time %0t sys_clk %0d clk_500Hz %0d",$time,sys_clk,UUT.clk_500Hz);
	$fdisplay(file,"Time %0t sys_clk %0d clk_500Hz %0d",$time,sys_clk,UUT.clk_500Hz);
end
// always @( sys_clk ) begin
// 	$display("Time %0t sys_clk %0d KEYCHANGE_PERIOD %f clk_500Hz %0d clk_5s %0d", $time, sys_clk, UUT.KEYCHANGE_PERIOD, UUT.clk_500Hz, UUT.clk_5s);
//     $fdisplay(file,"Time %0t sys_clk %0d KEYCHANGE_PERIOD %f clk_500Hz %0d clk_5s %0d", $time, sys_clk, UUT.KEYCHANGE_PERIOD, UUT.clk_500Hz, UUT.clk_5s);
// end
initial 
begin
    $timeformat(0, 9, " s", 20);
    j=3;
    limit = j*1000000*UUT.KEYCHANGE_PERIOD;
    file = $fopen("rtcClkDivider.log","a");
    
    $display("Initial values:\nTime %0t sys_clk %0d KEYCHANGE_PERIOD %f clk_500Hz %0d clk_5s %0d\n", $time, sys_clk, UUT.KEYCHANGE_PERIOD, clk_500Hz, clk_5s);
    $fdisplay(file,"Initial values:\nTime %0t sys_clk %0d KEYCHANGE_PERIOD %f clk_500Hz %0d clk_5s %0d\n", $time, sys_clk, UUT.KEYCHANGE_PERIOD, clk_500Hz, clk_5s);
    for (i = 0; i<limit; i=i+1) #period;
    $fclose(file);
    $finish;
end

endmodule