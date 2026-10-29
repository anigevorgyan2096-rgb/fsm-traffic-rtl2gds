import klayout.db as pya
l = pya.Layout()
l.read("fsm_traffic.gds")
top = l.top_cell()
print("top:", top.name)
print("instances:", top.child_instances())
print("bbox (um):", top.dbbox())
for c in top.each_child_cell():
    print(l.cell(c).name, l.cell(c).bbox().area() > 0)python check_gds.py