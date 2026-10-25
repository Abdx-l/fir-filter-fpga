from pathlib import Path
import numpy as np
from scipy.signal import firwin
coeff=np.rint(firwin(31,5000,fs=48000)*32768).astype(np.int64)
package="library ieee;use ieee.std_logic_1164.all;use ieee.numeric_std.all;\npackage coefficients is\ntype taps is array(0 to 30) of integer;constant C:taps:=("+",".join(map(str,coeff))+");\nend;\n"
Path("coefficients.vhd").write_text(package)
t=np.arange(512)/48000;x=np.rint((.4*np.sin(2*np.pi*1000*t)+.3*np.sin(2*np.pi*20000*t))*32767).astype(np.int64)
golden=np.clip(np.convolve(x,coeff)[:len(x)]//32768,-32768,32767)
Path("input.txt").write_text("\n".join(map(str,x))+"\n");Path("expected.txt").write_text("\n".join(map(str,golden))+"\n")
