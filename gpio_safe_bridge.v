module gpio_safe_bridge (
    input wire clk_25mhz,
    output wire dummy_out  // required to keep module "alive"
);

assign dummy_out = clk_25mhz;  // Just loop clock to an unused output

endmodule
