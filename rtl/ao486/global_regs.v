/*   Copyright (C) 2026 Pedro Emanuel
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */
    
/*
 * Copyright (c) 2014, Aleksander Osman
 * All rights reserved.
 */

`include "defines.v"

module global_regs(
    input               clk,
    input               rst_n,
    
    // Entradas expandidas para 64-bits
    input               glob_param_1_set,
    input       [63:0]  glob_param_1_value,
    
    input               glob_param_2_set,
    input       [63:0]  glob_param_2_value,
    
    input               glob_param_3_set,
    input       [63:0]  glob_param_3_value,
    
    input               glob_param_4_set,
    input       [63:0]  glob_param_4_value,
    
    input               glob_param_5_set,
    input       [63:0]  glob_param_5_value,
    
    input               glob_descriptor_set,
    input       [63:0]  glob_descriptor_value,
    
    input               glob_descriptor_2_set,
    input       [63:0]  glob_descriptor_2_value,
    
    // Saídas de registradores expandidas para 64-bits
    output reg  [63:0]  glob_param_1,
    output reg  [63:0]  glob_param_2,
    output reg  [63:0]  glob_param_3,
    output reg  [63:0]  glob_param_4,
    output reg  [63:0]  glob_param_5,

    output reg  [63:0]  glob_descriptor,
    output reg  [63:0]  glob_descriptor_2,
    
    // Base de endereço expandida para 64-bits para suportar endereçamento x86_64
    output      [63:0]  glob_desc_base,
    output      [31:0]  glob_desc_limit,
    output      [31:0]  glob_desc_2_limit
);

//------------------------------------------------------------------------------

assign glob_desc_limit = glob_descriptor[`DESC_BIT_G]? { glob_descriptor[51:48], glob_descriptor[15:0], 12'hFFF } : { 12'd0, glob_descriptor[51:48], glob_descriptor[15:0] };

// Extensão zero-padded temporária para 64 bits da base do descritor herdado de 32-bits.
// Nota técnica de evolução: Conforme avançarmos para os descritores de sistema do Long Mode (128-bits), 
// este trecho absorverá a parte alta vinda de 'glob_descriptor_2'.
assign glob_desc_base  = { 32'd0, glob_descriptor[63:56], glob_descriptor[39:16] };

assign glob_desc_2_limit = glob_descriptor_2[`DESC_BIT_G]? { glob_descriptor_2[51:48], glob_descriptor_2[15:0], 12'hFFF } : { 12'd0, glob_descriptor_2[51:48], glob_descriptor_2[15:0] };

//------------------------------------------------------------------------------

always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)           glob_param_1 <= 64'd0;
    else if(glob_param_1_set)   glob_param_1 <= glob_param_1_value;
end

always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)           glob_param_2 <= 64'd0;
    else if(glob_param_2_set)   glob_param_2 <= glob_param_2_value;
end

always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)           glob_param_3 <= 64'd0;
    else if(glob_param_3_set)   glob_param_3 <= glob_param_3_value;
end

always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)           glob_param_4 <= 64'd0;
    else if(glob_param_4_set)   glob_param_4 <= glob_param_4_value;
end

always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)           glob_param_5 <= 64'd0;
    else if(glob_param_5_set)   glob_param_5 <= glob_param_5_value;
end

always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)               glob_descriptor <= 64'd0;
    else if(glob_descriptor_set)    glob_descriptor <= glob_descriptor_value;
end

always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)               glob_descriptor_2 <= 64'd0;
    else if(glob_descriptor_2_set)  glob_descriptor_2 <= glob_descriptor_2_value;
end

//------------------------------------------------------------------------------

endmodule
