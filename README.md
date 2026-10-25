# FIR Filter on FPGA

31-tap Q1.15 low-pass FIR with a transposed multiply-accumulate datapath, 48-bit internal sums, saturating 16-bit output, SciPy coefficient/vector generation, and sample-by-sample HDL/reference comparison.

## Run

Install requirements.txt and GHDL, then `make test`. design.py designs a 5 kHz low-pass at 48 kHz, generates mixed 1 kHz/20 kHz input, and exports VHDL coefficients and fixed-point golden vectors.
