module sum_update(
    input clk,
    input rst_p,
    input [4-1:0] cnt,
    input [24-1:0] order,
    input [7-1:0] cost,
    output reg [4-1:0] match_count,
    output reg [10-1:0] min_cost,
    output reg [3-1:0] J,
    output reg [3-1:0] W
);

reg [4-1:0] match_count_next;
reg [10-1:0] min_cost_next;
reg [10-1:0] sum, sum_next;
reg [7-1:0] prev, prev_next;

// set W-th worker
always @* begin
    W = cnt[2:0];
end

// set J-th job
always @* begin
    case (cnt)
        // cycle 0: order[2:0], cycle 1: order[5:3], ..., cycle 7: order[23:21]
        4'd0: J = order[2:0];
        4'd1: J = order[5:3];
        4'd2: J = order[8:6];
        4'd3: J = order[11:9];
        4'd4: J = order[14:12];
        4'd5: J = order[17:15];
        4'd6: J = order[20:18];
        4'd7: J = order[23:21];
        default: J = order[2:0];
    endcase
end

// store the previous work cost
always @* begin
    prev_next = cost;
end

// sum the job cost up
always @* begin
    if (cnt == 0) begin
        sum_next = 0;
    end
    else if (cnt >= 1 && cnt <= 8) begin
        sum_next = sum + prev;
    end
    else begin
        sum_next = sum;
    end
end

// update
always @* begin
    if (cnt == 9) begin
        if (min_cost == 0) begin
            // min_cost will be zero only when the circuit has just been reset
            // thus, this block will only be executed at the very beginning
            min_cost_next = sum;
            match_count_next = 1;
        end
        else if (sum == min_cost) begin
            // fair, so just update match_count
            min_cost_next = min_cost;
            match_count_next = match_count + 1;
        end
        else if (sum < min_cost) begin
            // a better solution is found oh yeah
            min_cost_next = sum;
            match_count_next = 1;
        end
        else begin
            min_cost_next = min_cost;
            match_count_next = match_count;
        end
    end
    else begin
        min_cost_next = min_cost;
        match_count_next = match_count;
    end
end


// FF
always @(posedge clk) begin
    if (rst_p) begin    // high active reset
        match_count <= 0;
        min_cost <= 0;
        prev <= 0;
        sum <= 0;
    end
    else begin
        match_count <= match_count_next;
        min_cost <= min_cost_next;
        prev <= prev_next;
        sum <= sum_next;
    end
end

endmodule
