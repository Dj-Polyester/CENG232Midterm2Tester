`timescale 1ns / 1ps
//`include "hasher_tb.v"

module top_tb;

reg sysclk;
reg button_in;
reg [15:0] student_id;
reg [15:0] modded_id;
wire [3:0] D5_out;
wire [3:0] D4_out;
wire [3:0] D3_out;
wire [3:0] D2_out;
wire [3:0] D1_out;
wire clk_500Hz, clk_5s;
integer i, limit, file, tmp_id;

localparam period = 500;
localparam MyStudentId = 2310191;//write your student id

top UUT (
	.sysclk(sysclk),
	.button_in(button_in),
	.student_id(student_id),
	.D5_out(D5_out),
	.D4_out(D4_out),
	.D3_out(D3_out),
	.D2_out(D2_out),
	.D1_out(D1_out)	
);

function integer mod;
    input integer N;
    input integer M;
    begin
        while (N>=0) begin
            
            N=N-M;
        end
        mod=N+M;
    end   
endfunction

function integer change0s25s;
    input integer id;
    input integer sum;
    begin
        for (i = 4; i>=0; i=i-1) begin
            sum=sum+( (mod(id,10**i) === id) ? 10**i: 0);
        end
        change0s25s=sum*5+id;
    end 
endfunction

initial sysclk=0;
always #period sysclk=~sysclk;
//Please copy commented lines into your top module and modify KEYCHANGE_PERIOD in your rtcClkDivider Module (preferably 0.5)
// always @(sysclk) begin
// 	file=$fopen("top.log","a");
// 	$fdisplay(file,"cur_time %0d sysclk %0d button_in %0d enable %0d button_out %0d student_id %0d cur_hash %0d BCD %0d %0d %0d %0d %0d",cur_time,sysclk,button_in,enable,button_out,student_id,cur_hash,D5_out,D4_out,D3_out,D2_out,D1_out);
// 	$fclose(file);
// end
initial begin

    limit = 2**18;
    $timeformat(0, 9, " s", 20);
    file = $fopen("top.log","a");

    $display("Initial values: \nTime %0d button_in %0d student_id %0d BCD %0d %0d %0d %0d %0d ", $time, button_in, student_id, D5_out, D4_out, D3_out, D2_out, D1_out);
    $fdisplay(file,"Initial values: \nTime %0d button_in %0d student_id %0d BCD %0d %0d %0d %0d %0d ", $time, button_in, student_id, D5_out, D4_out, D3_out, D2_out, D1_out);
    $display("Your id: %0d",MyStudentId);
    $fdisplay(file,"Your id: %0d",MyStudentId);
    tmp_id = MyStudentId % 2**16;
    $display("(your_id) mod (2**16) = %0d",tmp_id);
    $fdisplay(file,"(your_id) mod (2**16) = %0d",tmp_id);
    modded_id = change0s25s(tmp_id,0);
    $display("Your modified id: %0d\n",modded_id);
    $fdisplay(file,"Your modified id: %0d\n",modded_id);
    student_id=modded_id;
    #(period/2)
    for (i = 0; i<limit; i=i+1) begin
        //button_in=$random % 2;
        if (!i) begin
            button_in=0;
        end
        else if (!(i%10000)) begin
            button_in=~button_in;
        end
        
        #period;
    end
    $fclose(file);
    $display("\033[1;36mOutput may be huge. Please check the log file. You may revert back your files.\033[0m");
    $finish;
end

endmodule // top_tb