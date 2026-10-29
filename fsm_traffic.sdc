# 1. Սահմանում ենք հիմնական ժամացույցը (Clock)
# Օրինակ՝ 10 նանովայրկյան պարբերությամբ (100 ՄՀց հաճախականություն)
create_clock -name clk -period 10.0 [get_ports clk]



# 2. Սահմանում ենք մուտքերի և ելքերի ուշացումները (Input/Output Delays)
# Սա օգնում է ստուգել, թե արդյոք տվյալները հասցնում են տեղ հասնել ժամանակին
set_input_delay  2.0 -clock clk [get_ports rst]
set_output_delay 2.0 -clock clk [all_outputs]
# 3. Սահմանում ենք բեռնվածությունը (Load) ելքերի վրա և հաղորդալարերի հզորությունը
set_load 0.03 [all_outputs]