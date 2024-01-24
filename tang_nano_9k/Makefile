.PHONY: all load clean
.SECONDARY:

all: counter.fs

load: counter.fs
	openFPGALoader -b tangnano9k $<

%.fs: %.pnr.json
	gowin_pack -d GW1N-9C -o $@ $<

%.pnr.json: %.synth.json
	nextpnr-gowin --json $< --write $@ --device GW1NR-LV9QN88PC6/I5 --family GW1N-9C --cst tangnano9k.cst

%.synth.json: %.v
	yosys -p "read_verilog $<; synth_gowin -json $@"

clean:
	rm -f *.json *.fs abc.history


