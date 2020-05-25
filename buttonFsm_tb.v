`timescale 1ns / 1ps

module buttonFsm_tb;

reg clk;
reg button;
wire stateful_button; 
localparam period = 2;
integer i, j, limit, file, rand, randindex;
integer randlist [7:0];

buttonFsm UUT(
    .clk(clk),
    .button(button),
    .stateful_button(stateful_button)
);

initial clk=0;
always #period clk=~clk;

always @(posedge clk) begin
    $display("CLOCK CYCLE %0d\nTime %0t (posedge) current output %0d", i, $time, stateful_button);
    $fdisplay(file,"CLOCK CYCLE %0d\nTime %0t (posedge) current output %0d", i, $time, stateful_button);
    #(period/2)
    $display("Time %0t (hi-level) current output %0d", $time, stateful_button);
    $fdisplay(file,"Time %0t (hi-level) current output %0d", $time, stateful_button);
end
always @(negedge clk) begin
    $display("Time %0t (negedge) current output %0d", $time, stateful_button);
    $fdisplay(file,"Time %0t (negedge) current output %0d", $time, stateful_button);
    #(period/2)
    $display("Time %0t (lo-level) current output %0d\n\n\n", $time, stateful_button);
    $fdisplay(file,"Time %0t (lo-level) current output %0d\n\n\n", $time, stateful_button);
end

initial 
begin
    //initialize list
    randlist[7]=4;
    randlist[6]=3;
    randlist[5]=2;
    randlist[4]=1;
    randlist[3]=1;
    randlist[2]=1;
    randlist[1]=1;
    randlist[0]=1;

    limit = 100;
    $timeformat(-9, 0, " ns", 20);
    file = $fopen("buttonFsm.log","a");
    $display("Time %0t pre-initial output %0d", $time, stateful_button);
    $fdisplay(file,"Time %0t pre-initial output %0d", $time, stateful_button);
    #(period/2)
    $display("Time %0t initial output %0d\n\n\n", $time, stateful_button);
    $fdisplay(file, "Time %0t initial output %0d\n\n\n", $time, stateful_button);
    for (i = 0; i<limit; i=i+1) begin
        randindex=$random % 8;
        randindex = randindex < 0? -randindex: randindex;
        rand=randlist[randindex];
        if (rand !== 1) begin
            $display("%0d times random bouncing", rand);
            $fdisplay(file, "%0d times random bouncing", rand);
        end
        for (j = 0; j<rand; j=j+1) begin
            button = $random % 2;
            if (button) begin
                $display("pressed");
                $fdisplay(file, "pressed");
            end else begin
                $display("NOT-pressed");
                $fdisplay(file, "NOT-pressed");
            end
            #(period/16.0);
        end
        
        #period;
        #period;
    end
    $fclose(file);
    $finish;
end

endmodule