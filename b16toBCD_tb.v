`timescale 1ns / 1ps

module b16toBCD_tb;

reg [15:0] to_display;
reg enable;
wire [3:0] D5;	
wire [3:0] D4;	
wire [3:0] D3;	
wire [3:0] D2;	
wire [3:0] D1;

integer file, i, j, limit;
localparam period = 20;

b16toBCD UUT(
    .to_display(to_display),
    .enable(enable),
    .D5(D5),	
    .D4(D4),	
    .D3(D3),	
    .D2(D2),	
    .D1(D1)
);

initial 
begin
    limit=100;
    file = $fopen("b16toBCD.log","a");
    $display("Pre-initial values:\nTime %0d enable %0d binary %0d BCD %0d %0d %0d %0d %0d ", $time, enable, to_display, D5, D4, D3, D2, D1);
    $fdisplay(file,"Pre-initial values:\nTime %0d enable %0d binary %0d BCD %0d %0d %0d %0d %0d ", $time, enable, to_display, D5, D4, D3, D2, D1);
    #(period/2)
    $display("Initial values:\nTime %0d enable %0d binary %0d BCD %0d %0d %0d %0d %0d ", $time, enable, to_display, D5, D4, D3, D2, D1);
    $fdisplay(file, "Initial values:\nTime %0d enable %0d binary %0d BCD %0d %0d %0d %0d %0d ", $time, enable, to_display, D5, D4, D3, D2, D1);
    for (i = 0; i<limit; i=i+1) 
    begin
        to_display=(i ? $random % 2**16 : 0);
        enable=(i ? $random % 2 : 1);
        #period;
        $display("Time %0d enable %0d binary %0d BCD %0d %0d %0d %0d %0d ", $time, enable, to_display, D5, D4, D3, D2, D1);
        $fdisplay(file,"Time %0d enable %0d binary %0d BCD %0d %0d %0d %0d %0d ", $time, enable, to_display, D5, D4, D3, D2, D1);
    end
    $fclose(file);
end

endmodule