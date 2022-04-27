module JAM (
    input CLK,
    input RST,
    output [2:0] W,
    output [2:0] J,
    input [6:0] Cost,
    output [3:0] MatchCount,
    output [9:0] MinCost,
    output reg Valid 
);

parameter IDLE = 2'd0, CAL = 2'd1, FINISH = 2'd2;
reg [2-1:0] state, state_next;
reg [4-1:0] cnt, cnt_next;
reg [24-1:0] top_order, top_order_next;
reg Valid_next;
wire [24-1:0] new_order;

// set new order next
always @* begin
    if (cnt == 9) begin
        top_order_next = new_order;
    end
    else begin
        top_order_next = top_order;
    end
end

// FSM
always @* begin
    if (RST == 0) begin
        if (top_order == {3'd7, 3'd6, 3'd5, 3'd4, 3'd3, 3'd2, 3'd1, 3'd0} && cnt == 4'd8) begin
            state_next = FINISH;
        end
        else begin
            state_next = CAL;
        end
    end
end

// global counter
always @* begin
    if (state == CAL) begin
        if (cnt == 9) begin
            cnt_next = 0;
        end
        else begin
            cnt_next = cnt + 1;
        end
    end
    else begin
        cnt_next = cnt;
    end
end

// FF
always @(posedge CLK) begin
    if (RST == 1) begin
        state <= IDLE;
        cnt <= 0;
        top_order <= {3'd0, 3'd1, 3'd2, 3'd3, 3'd4, 3'd5, 3'd6, 3'd7};
        Valid <= 0;
    end
    else begin
        state <= state_next;
        cnt <= cnt_next;
        top_order <= top_order_next;
        Valid <= Valid_next;
    end
end

sum_update U0 (
    .clk(CLK),
    .rst_p(RST),
    .cnt(cnt),
    .order(top_order),
    .cost(Cost),
    .match_count(MatchCount),
    .min_cost(MinCost),
    .J(J),
    .W(W)
);

permutation U1 ( 
    .CLK(CLK),
    .RST(RST),
    .cnt(cnt),
    .top_order(top_order),
    .new_order(new_order)
);

always @* begin
    if (state == FINISH)
        Valid_next = 1;
    else 
        Valid_next = 0;
end


endmodule
