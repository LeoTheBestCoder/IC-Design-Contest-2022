module permutation ( 
input CLK,
input RST,
input [4 - 1 : 0] cnt,
input [24 - 1 : 0] top_order,
output reg [24 - 1 : 0] new_order
);

reg write_order_en, sw_en, sw_en2, swap_en, rev_en, sw_not_yet, sw_done ;
reg [2 : 0] sw_pt, n_sw_pt, left_pt, right_pt, left_val, middle_val, right_val ;
reg [23 : 0] swap_order, rev_order, n_new_order ;

// judge whether right element > left element or not.

always@* begin
    sw_en2 = 0 ;
    n_sw_pt = right_pt ;
    if(middle_val < right_val) begin
        sw_en2 = 1 ;
    end
    else begin
        if(left_val < middle_val) begin
            sw_en2 = 1 ;
            n_sw_pt = left_pt ;
        end
    end
end

// swap the switch point & min{the num > the switch point}

always@* begin
    swap_order = new_order ;
    case(sw_pt)
        3'd1 : begin
            swap_order[2 : 0] = new_order[5 : 3] ;
            swap_order[5 : 3] = new_order[2 : 0] ;
        end 
        3'd2 : begin
            if(new_order[2 : 0] > new_order[8 : 6]) begin
                swap_order[2 : 0] = new_order[8 : 6] ;
                swap_order[8 : 6] = new_order[2 : 0] ;
            end
            else begin
                swap_order[5 : 3] = new_order[8 : 6] ;
                swap_order[8 : 6] = new_order[5 : 3] ;
            end
        end
        3'd3 : begin
            if(new_order[5 : 3] > new_order[11 : 9]) begin
                if(new_order[2 : 0] > new_order[11 : 9]) begin
                    swap_order[2 : 0] = new_order[11 : 9] ;
                    swap_order[11 : 9] = new_order[2 : 0] ;
                end
                else begin
                    swap_order[5 : 3] = new_order[11 : 9] ;
                    swap_order[11 : 9] = new_order[5 : 3] ;
                end
            end
            else begin
                swap_order[8 : 6] = new_order[11 : 9] ;
                swap_order[11 : 9] = new_order[8 : 6] ;
            end
        end
        3'd4 : begin
            if(new_order[8 : 6] > new_order[14 : 12]) begin
                if(new_order[5 : 3] > new_order[14 : 12]) begin
                    if(new_order[2 : 0] > new_order[14 : 12]) begin
                        swap_order[2 : 0] = new_order[14 : 12] ;
                        swap_order[14 : 12] = new_order[2 : 0] ;
                    end
                    else begin
                        swap_order[5 : 3] = new_order[14 : 12] ;
                        swap_order[14 : 12] = new_order[5 : 3] ;
                    end
                end
                else begin
                    swap_order[8 : 6] = new_order[14 : 12] ;
                    swap_order[14 : 12] = new_order[8 : 6] ;
                end
            end
            else begin
                swap_order[11 : 9] = new_order[14 : 12] ;
                swap_order[14 : 12] = new_order[11 : 9] ;
            end
        end
        3'd5 : begin
            if(new_order[11 : 9] > new_order[17 : 15]) begin
                if(new_order[8 : 6] > new_order[17 : 15]) begin
                    if(new_order[5 : 3] > new_order[17 : 15]) begin
                        if(new_order[2 : 0] > new_order[17 : 15]) begin
                            swap_order[2 : 0] = new_order[17 : 15] ;
                            swap_order[17 : 15] = new_order[2 : 0] ;                   
                        end
                        else begin
                            swap_order[5 : 3] = new_order[17 : 15] ;
                            swap_order[17 : 15] = new_order[5 : 3] ;      
                        end
                    end
                    else begin
                        swap_order[8 : 6] = new_order[17 : 15] ;
                        swap_order[17 : 15] = new_order[8 : 6] ;        
                    end
                end
                else begin
                    swap_order[11 : 9] = new_order[17 : 15] ;
                    swap_order[17 : 15] = new_order[11 : 9] ;      
                end
            end
            else begin
                swap_order[14 : 12] = new_order[17 : 15] ;
                swap_order[17 : 15] = new_order[14 : 12] ;   
            end
        end
        3'd6 : begin
            if(new_order[14 : 12] > new_order[20 : 18]) begin
                if(new_order[11 : 9] > new_order[20 : 18]) begin
                    if(new_order[8 : 6] > new_order[20 : 18]) begin
                        if(new_order[5 : 3] > new_order[20 : 18]) begin
                            if(new_order[2 : 0] > new_order[20 : 18]) begin
                                swap_order[2 : 0] = new_order[20 : 18] ;
                                swap_order[20 : 18] = new_order[2 : 0] ;                     
                            end
                            else begin
                                swap_order[5 : 3] = new_order[20 : 18] ;
                                swap_order[20 : 18] = new_order[5 : 3] ; 
                            end
                        end
                        else begin
                            swap_order[8 : 6] = new_order[20 : 18] ;
                            swap_order[20 : 18] = new_order[8 : 6] ;   
                        end
                    end
                    else begin
                        swap_order[11 : 9] = new_order[20 : 18] ;
                        swap_order[20 : 18] = new_order[11 : 9] ;   
                    end
                end
                else begin
                    swap_order[14 : 12] = new_order[20 : 18] ;
                    swap_order[20 : 18] = new_order[14 : 12] ;    
                end
            end
            else begin
                swap_order[17 : 15] = new_order[20 : 18] ;
                swap_order[20 : 18] = new_order[17 : 15] ;    
            end
        end
        3'd7 : begin
            if(new_order[17 : 15] > new_order[23 : 21]) begin
                if(new_order[14 : 12] > new_order[23 : 21]) begin
                    if(new_order[11 : 9] > new_order[23 : 21]) begin
                        if(new_order[8 : 6] > new_order[23 : 21]) begin
                            if(new_order[5 : 3] > new_order[23 : 21]) begin
                                if(new_order[2 : 0] > new_order[23 : 21]) begin
                                    swap_order[2 : 0] = new_order[23 : 21] ;
                                    swap_order[23 : 21] = new_order[2 : 0] ;                        
                                end
                                else begin
                                    swap_order[5 : 3] = new_order[23 : 21] ;
                                    swap_order[23 : 21] = new_order[5 : 3] ;  
                                end
                            end
                            else begin
                                swap_order[8 : 6] = new_order[23 : 21] ;
                                swap_order[23 : 21] = new_order[8 : 6] ;     
                            end
                        end
                        else begin
                            swap_order[11 : 9] = new_order[23 : 21] ;
                            swap_order[23 : 21] = new_order[11 : 9] ;     
                        end
                    end
                    else begin
                        swap_order[14 : 12] = new_order[23 : 21] ;
                        swap_order[23 : 21] = new_order[14 : 12] ;  
                    end
                end
                else begin
                    swap_order[17 : 15] = new_order[23 : 21] ;
                    swap_order[23 : 21] = new_order[17 : 15] ;  
                end
            end
            else begin
                swap_order[20 : 18] = new_order[23 : 21] ;
                swap_order[23 : 21] = new_order[20 : 18] ;  
            end
        end
    endcase
end

// reverse the order combinational logic

always@* begin
    rev_order = new_order ;
    case(sw_pt) 
        3'd2 : begin
            rev_order[2 : 0] = new_order[5 : 3] ;
            rev_order[5 : 3] = new_order[2 : 0] ;
        end
        3'd3 : begin
            rev_order[2 : 0] = new_order[8 : 6] ;
            rev_order[5 : 3] = new_order[5 : 3] ;
            rev_order[8 : 6] = new_order[2 : 0] ;
        end
        3'd4 : begin
            rev_order[2 : 0] = new_order[11 : 9] ;
            rev_order[5 : 3] = new_order[8 : 6] ;
            rev_order[8 : 6] = new_order[5 : 3] ;
            rev_order[11 : 9] = new_order[2 : 0] ;
        end
        3'd5 : begin
            rev_order[2 : 0] = new_order[14 : 12] ;
            rev_order[5 : 3] = new_order[11 : 9] ;
            rev_order[8 : 6] = new_order[8 : 6] ;
            rev_order[11 : 9] = new_order[5 : 3] ;
            rev_order[14 : 12] = new_order[2 : 0] ;
        end
        3'd6 : begin
            rev_order[2 : 0] = new_order[17 : 15] ;
            rev_order[5 : 3] = new_order[14 : 12] ;
            rev_order[8 : 6] = new_order[11 : 9] ;
            rev_order[11 : 9] = new_order[8 : 6] ;
            rev_order[14 : 12] = new_order[5 : 3] ;
            rev_order[17 : 15] = new_order[2 : 0] ;
        end
        3'd7 : begin
            rev_order[2 : 0] = new_order[20 : 18] ;
            rev_order[5 : 3] = new_order[17 : 15] ;
            rev_order[8 : 6] = new_order[14 : 12] ;
            rev_order[11 : 9] = new_order[11 : 9] ;
            rev_order[14 : 12] = new_order[8 : 6] ;
            rev_order[17 : 15] = new_order[5 : 3] ;
            rev_order[20 : 18] = new_order[2 : 0] ;
        end
        default : begin
            rev_order = new_order ;
        end
    endcase
end

always@* begin
    n_new_order = new_order ;
    write_order_en = 0 ;
    sw_not_yet = 0 ;
    sw_en = 0 ;
    swap_en = 0 ;
    rev_en = 0 ;
    right_pt = 1 ;
    left_pt = 2 ;
    right_val = new_order[2 : 0] ;
    middle_val = new_order[5 : 3] ;
    left_val = new_order[8 : 6] ;
    case(cnt)
        4'd0 : begin
            write_order_en = 1 ;
        end
        4'd1 : begin
            sw_en = 1 ;
            right_pt = 1 ;
            left_pt = 2 ;
            right_val = new_order[2 : 0] ;
            middle_val = new_order[5 : 3] ;
            left_val = new_order[8 : 6] ;
        end
        4'd2 : begin
            sw_en = 1 ;
            right_pt = 3 ;
            left_pt = 4 ;
            right_val = new_order[8 : 6] ;
            middle_val = new_order[11 : 9] ;
            left_val = new_order[14 : 12] ;
        end
        4'd3 : begin
            sw_en = 1 ;
            right_pt = 5 ;
            left_pt = 6 ;
            right_val = new_order[14 : 12] ;
            middle_val = new_order[17 : 15] ;
            left_val = new_order[20 : 18] ;
        end
        4'd4 : begin
            sw_en = 1 ;
            right_pt = 7 ;
            left_pt = 7 ;
            right_val = new_order[20 : 18] ;
            middle_val = new_order[23 : 21] ;
            left_val = new_order[23 : 21] ;
        end
        4'd5 : begin
            swap_en = 1 ;
        end
        4'd6 : begin
            rev_en = 1 ;
        end
        4'd7 : begin
            sw_not_yet = 1 ;
        end
        default : begin
            sw_not_yet = 0 ;
        end
    endcase
end

always@(posedge CLK) begin
    if(RST) begin
        sw_done <= 1'b0 ;
    end
    else begin
        if(write_order_en) begin 
            new_order <= top_order ;
        end
        else if(swap_en) begin
            new_order <= swap_order ;
        end
        else if(rev_en) begin
            new_order <= rev_order ;
        end
        else begin
            new_order <= n_new_order ;
        end
        if(sw_en & sw_en2 & (~sw_done)) begin
            sw_done <= 1'b1 ;
            sw_pt <= n_sw_pt ;
        end
        else if(sw_not_yet) begin
            sw_done <= 1'b0 ;
        end
    end
end

endmodule