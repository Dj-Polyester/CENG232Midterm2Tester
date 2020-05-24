`timescale 1ns / 1ps

module hasher_tb;

reg clk;
reg [15:0] cur_time;
reg [15:0] student_id;
reg [15:0] modded_id;
wire [15:0] cur_hash;
integer file, i, tmp_id, limit;

localparam period = 2;
localparam MyStudentId = ;//write your student id

hasher UUT(
    .clk(clk),
    .cur_time(cur_time),
    .student_id(student_id),
    .cur_hash(cur_hash)
);
initial clk=0;
always #period clk=~clk;

//finds remainder (Please use positive numbers, begging!!!)
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

initial 
begin
    limit=100;
    
    $timeformat(-9, 0, " ns", 20);
    file = $fopen("hasher.log","a");
    cur_time=0;
    $display("Initial values:\nTime %0t cur_time  %0d student_id %0d cur_hash %0d",
    $time,cur_time,student_id,cur_hash);
    $fdisplay(file,"Initial values:\nTime %0t cur_time  %0d student_id %0d cur_hash %0d",
    $time,cur_time,student_id,cur_hash);
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
        
        $display("Current values:\nTime %0t cur_time %0d student_id %0d cur_hash %0d",
        $time,cur_time,student_id,cur_hash);
        $fdisplay(file,"Current values:\nTime %0t cur_time %0d student_id %0d cur_hash %0d",
        $time,cur_time,student_id,cur_hash);
        
        #period
        #period
        
        $display("Next values:\nTime %0t cur_time %0d student_id %0d cur_hash %0d\n",
        $time,cur_time,student_id,cur_hash);
        $fdisplay(file,"Next values:\nTime %0t cur_time %0d student_id %0d cur_hash %0d\n",
        $time,cur_time,student_id,cur_hash);

    end
    
    $fclose(file);
    $finish;
end

endmodule