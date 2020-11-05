//testbench for traffic light controller
`timescale 10 ns/ 1 ps

`define DELAY 1

//`include "counter_define.h"
module tb_traffic;
//Parameter definitions
parameter ENDTIME  = 400000;
//DUT Input regs
//integer count, count1, a;
reg clk;
reg rst_n;
reg sensor;
wire [2:0] light_farm;
//DUT Output wires
wire [2:0] light_highway;

//DUT Instantiation
traffic_light tb(light_highway, light_farm, sensor, clk, rst_n);

//Initial Conditions
initial
 begin
 clk = 1'b0;
 rst_n = 1'b0;
 sensor = 1'b0;
 // count = 0;
//// count1=0;
// a=0;
 end
//Generating Test Vectors
initial
 begin
 main;
 end
task main;
 fork
 clock_gen;
 reset_gen;
 operation_flow;
 debug_output;
 endsimulation;
 join
endtask
task clock_gen;
 begin
 forever #`DELAY clk = !clk;
 end
endtask

task reset_gen;
 begin
 rst_n = 0;
 # 20
 rst_n = 1;
 end
endtask

task operation_flow;
 begin
 sensor = 0;
 # 600
 sensor = 1;
 # 1200
 sensor = 0;
 # 1200
 sensor = 1;
 end
endtask
//Debug output
task debug_output;
 begin
 $display("----------------------------------------------");
        $display("------------------     -----------------------");
 $display("----------- SIMULATION RESULT ----------------");
 $display("--------------             -------------------");
 $display("----------------         ---------------------");
 $display("----------------------------------------------");
 $monitor("TIME = %d, reset = %b, sensor = %b, light of highway = %h, light of farm road = %h",$time,rst_n ,sensor,light_highway,light_farm );
 end
endtask

//Determines the simulation limit
task endsimulation;
 begin
 #ENDTIME
 $display("-------------- THE SIMUALTION END ------------");
 $finish;
 end
endtask
    
endmodule
