TOP = gpio_safe_bridge
DEVICE = LFE5U-85F
PACKAGE = CABGA381
LPF = gpio_safe_bridge.lpf
FREQ = 25

all: $(TOP).bit

$(TOP).json: $(TOP).v
	yosys -p "synth_ecp5 -top $(TOP) -json $(TOP).json" $(TOP).v

$(TOP).config: $(TOP).json $(LPF)
	nextpnr-ecp5 --json $(TOP).json --textcfg $(TOP).config --lpf $(LPF) --85k --package $(PACKAGE) --freq $(FREQ) --lpf-allow-unconstrained

$(TOP).bit: $(TOP).config
	ecppack $(TOP).config $(TOP).bit

prog: $(TOP).bit
	openFPGALoader -b ulx3s $(TOP).bit

clean:
	rm -f *.json *.config *.bit
