library verilog;
use verilog.vl_types.all;
entity is_zero_vlg_sample_tst is
    port(
        D               : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end is_zero_vlg_sample_tst;
