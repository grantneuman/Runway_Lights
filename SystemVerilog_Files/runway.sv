//module runway (clk, reset, SW, LEDR);
module runway (clk, SW, LEDR);
	//input logic clk, reset;
	input logic clk;
	input logic [1:0] SW;
	output logic [2:0] LEDR;
	
	logic [2:0] ps;
	logic [2:0] ns;
	logic [2:0] A, B, C, D, nothing;
	
	//localparam A = 3'b001;
	assign A = 3'b001;
	assign B = 3'b010;
	assign C = 3'b100;
	assign D = 3'b101;
	assign nothing = 3'bxxx;
	
	// Next State logic
	always @(*) 
		case (ps)
			A: if (~SW[0] & ~SW[1]) ns = D;
				else if (SW[0] & ~SW[1]) ns = B;
				else if (~SW[0] & SW[1]) ns = C;
				else ns = nothing;
			B: if (~SW[0] & ~SW[1]) ns = D;
				else if (SW[0] & ~SW[1]) ns = C;
				else if (~SW[0] & SW[1]) ns = A;
				else ns = nothing;
			C: if (~SW[0] & ~SW[1]) ns = D;
				else if (SW[0] & ~SW[1]) ns = A;
				else if (~SW[0] & SW[1]) ns = B;
				else ns = nothing;
			D: if (~SW[0] & ~SW[1]) ns = B;
				else if (SW[0] & ~SW[1]) ns = A;
				else if (~SW[0] & SW[1]) ns = C;
				else ns = nothing;
			default: ns = B;
		endcase


	assign LEDR = ps;

	// DFFs
	always_ff @(posedge clk) begin
			ps <= ns;
	end

endmodule 


module runway_testbench();
	logic clk;
	//logic reset;
	logic [1:0] SW;
	logic [2:0] LEDR;

	//runway dut (clk, reset, SW, LEDR);
	runway dut (clk, SW, LEDR);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
	@(posedge clk);
														@(posedge clk);
														@(posedge clk);
						SW[1] <= 0; SW[0] <=0;  @(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
						SW[1] <= 0; SW[0] <=1;  @(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
						SW[1] <= 1; SW[0] <=0;  @(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
						SW[1] <= 1; SW[0] <=1;  @(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
						
			$stop; // End the simulation.
	end
endmodule 
