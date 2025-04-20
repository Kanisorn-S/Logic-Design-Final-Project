library verilog;
use verilog.vl_types.all;
entity is_zero is
    port(
        D               : in     vl_logic_vector(3 downto 0);
        ISZERO          : out    vl_logic
    );
end is_zero;
