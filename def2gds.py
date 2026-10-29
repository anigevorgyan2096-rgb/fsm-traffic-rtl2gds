import klayout.db as pya

cells = [
    "clkbuf/sky130_fd_sc_hd__clkbuf_4",
    "clkinv/sky130_fd_sc_hd__clkinv_1",
    "dfrtp/sky130_fd_sc_hd__dfrtp_1",
    "nor2/sky130_fd_sc_hd__nor2_1",
    "nor2b/sky130_fd_sc_hd__nor2b_1",
]
BASE = "/Users/anigevorgyan/Desktop/sky130_hd/cells"

layout = pya.Layout()

# 1. Սկզբում բջիջների geometry-ն
for c in cells:
    layout.read(f"{BASE}/{c}.gds")
    print("OK:", c)

# 2. Հետո DEF-ը՝ կապվելու արդեն բեռնված բջիջներին
opt = pya.LoadLayoutOptions()
opt.lefdef_config.lef_files = ["sky130hd.tlef", "sky130_fd_sc_hd_merged.lef"]
opt.lefdef_config.macro_resolution_mode = 1
layout.read("fsm_traffic.def", opt)

layout.write("fsm_traffic.gds")
print("Գրվեց fsm_traffic.gds")