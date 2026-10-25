test:
	python design.py
	ghdl -a --std=08 coefficients.vhd fir.vhd tb.vhd
	ghdl -e --std=08 tb
	ghdl -r --std=08 tb --assert-level=error
