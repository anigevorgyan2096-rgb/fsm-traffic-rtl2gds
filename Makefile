TOP = fsm_traffic
LIB = sky130_fd_sc_hd__tt_025C_1v80.lib

.PHONY: all synth pnr gds sim clean

all: sim gds

synth:
	yosys -p "read_verilog $(TOP).v; \
	synth -top $(TOP) -flatten; \
	dfflibmap -liberty $(LIB) -dont_use *lpflow*; \
	abc -liberty $(LIB) -dont_use *lpflow* -dont_use *probe* -dont_use *clkdlybuf*; \
	opt_clean -purge; \
	write_verilog -noattr -noexpr $(TOP)_synth.v; \
	stat -liberty $(LIB)" > synth.log

pnr: synth
	openroad -exit -log pnr.log pnr.tcl

gds: pnr
	.venv/bin/python def2gds.py

sim: synth
	iverilog -o rtl_sim $(TOP).v $(TOP)_tb.v && vvp rtl_sim | grep -v VCD > rtl.txt
	iverilog -o gl_sim cells_sim.v $(TOP)_synth.v $(TOP)_tb.v && vvp gl_sim | grep -v VCD > gl.txt
	diff rtl.txt gl.txt && echo "RTL == GATE-LEVEL"

clean:
	rm -f $(TOP)_synth.v $(TOP).def $(TOP).odb $(TOP).gds
	rm -f rtl_sim gl_sim rtl.txt gl.txt *.vcd *.log
