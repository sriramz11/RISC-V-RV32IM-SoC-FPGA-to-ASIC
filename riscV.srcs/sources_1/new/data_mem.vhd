----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.03.2026 11:29:53
-- Design Name: 
-- Module Name: data_mem - dmem_arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_mem is
  port (
        clk: in std_logic;
        memWrite_en: in std_logic;
        dmem_addr: in std_logic_vector(31 downto 0);
        write_data: in std_logic_vector(31 downto 0);
        data_out: out std_logic_vector(31 downto 0) 
        );
end data_mem;

architecture dmem_arch of data_mem is
type dmemory_array is array (0 to 1023) of std_logic_vector(7 downto 0);

signal data_memory: dmemory_array := (




0  => x"0A", 1  => x"00", 2  => x"00", 3  => x"00", -- 0x0000000A (10)
4  => x"14", 5  => x"00", 6  => x"00", 7  => x"00", -- 0x00000014 (20)
8  => x"1E", 9  => x"00", 10 => x"00", 11 => x"00", -- 0x0000001E (30)
12 => x"28", 13 => x"00", 14 => x"00", 15 => x"00", -- 0x00000028 (40)
16 => x"32", 17 => x"00", 18 => x"00", 19 => x"00", -- 0x00000032 (50)

20 => x"D6", 21 => x"FF", 22 => x"FF", 23 => x"FF", -- 0xFFFFFFD6 (-42)
24 => x"01", 25 => x"00", 26 => x"00", 27 => x"80", -- 0x80000001
28 => x"01", 29 => x"00", 30 => x"00", 31 => x"00", -- 0x00000001

32 => x"04", 33 => x"00", 34 => x"00", 35 => x"00", -- 0x00000004
36 => x"FF", 37 => x"00", 38 => x"00", 39 => x"00", -- 0x000000FF

40 => x"00", 41 => x"00", 42 => x"00", 43 => x"00", -- 0x00000000

others => (others => '0') -- 0x002C onward unused

                                      
                                      );
begin

process(clk)begin
    if rising_edge(clk) then
        if memWrite_en = '1' then
            data_memory(to_integer(((unsigned(dmem_addr))+3)mod 1024)) <= write_data(31 downto 24);
            data_memory(to_integer(((unsigned(dmem_addr))+2)mod 1024)) <= write_data(23 downto 16);
            data_memory(to_integer(((unsigned(dmem_addr))+1)mod 1024)) <= write_data(15 downto 8);
            data_memory(to_integer((unsigned(dmem_addr))mod 1024)) <= write_data(7 downto 0);
        end if;    
    end if;
end process;

process(dmem_addr) begin
    data_out <= data_memory(to_integer((unsigned(dmem_addr))+3) mod 1024)& data_memory(to_integer((unsigned(dmem_addr)+2) mod 1024))& data_memory((to_integer(unsigned(dmem_addr))+1) mod 1024)& data_memory((to_integer(unsigned(dmem_addr))) mod 1024);
end process;

end dmem_arch;
