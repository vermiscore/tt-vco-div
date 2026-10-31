v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {d_bar} 5230 -4870 0 0 0.4 0.4 {}
T {q_bar} 5910 -5040 0 0 0.4 0.4 {}
T {q} 5220 -5060 0 0 0.4 0.4 {}
T {d} 5930 -4860 0 0 0.4 0.4 {}
T {d_bar} 5180 -3620 0 0 0.4 0.4 {}
T {q_bar} 5860 -3790 0 0 0.4 0.4 {}
T {q} 5170 -3810 0 0 0.4 0.4 {}
T {d} 5880 -3610 0 0 0.4 0.4 {}
T {d_bar} 5170 -2410 0 0 0.4 0.4 {}
T {q_bar} 5850 -2580 0 0 0.4 0.4 {}
T {q} 5160 -2600 0 0 0.4 0.4 {}
T {d} 5870 -2400 0 0 0.4 0.4 {}
T {name=s2 only_toplevel=false value="
.param mc_mm_switch=0
.lib '/home/user/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.tech/ngspice/sky130.lib.spice' tt 

*==========================================================
.param mc_pr_switch=0
.include /home/user/Desktop/myfolder/project/rf/rf_transmitter/layout/align_work/5ghz/tt_top/pex_c/tt_pex_c_L.spice

X1 clk ena rst_n buff_out3 buff_out4 vcont ua3 ua4 ua5 ua6 ua7
+ ui0 ui1 ui2 ui3 ui4 ui5 ui6 ui7
+ uio0 uio1 uio2 uio3 uio4 uio5 uio6 uio7
+ vdd GND tt_flat

*==========================================================

*im using only nmos so dont need sf fs
*ss->worst case for the lowest ampl
*ff->worst case for the highest ampl



*.temp -40

*VDD VDD GND 1.8

* Supply source (pin side)
VDD vsup GND 1.8

* PDN resistance. not sure if it is 5 ohms
RPDN vsup vdd 5



*if vdd decreases because of comsumption power

*VDD1 VDD1 GND 1.4

Vvcont vcont GND 0.4

*Vvcont vcont GND SIN(0.4 0.02 1000000)

.nodeset v(q)=1.5 v(q_bar)=1.9 v(net2)=1.9 v(net3)=1.5


*Vclk     clk     GND SIN(0.9 0.5 5.6e9 0 0 90)
*Vclk_bar clk_bar GND SIN(0.9 0.5 5.6e9 0 0 270)
*Vclk     clk     GND DC 1.2
*Vclk_bar clk_bar GND DC 0.6


.control


op
print v(q) v(q_bar) v(net2) v(net3) v(d) v(d_bar)
write divider.raw


tran 10p 2u
wrdata w50_wave.txt v(buff_out1) v(q3)




*power consumption
let vds1 = v(out1) - v(iout_vco)
let vgs2 = v(out2) - v(iout_vco)
meas tran vds_max MAX vds1 from=1u to=2u
meas tran vgs_max MAX vgs2 from=1u to=2u
print idd vds_max vgs_max

let vgv = v(out1) - v(vcont)
let vgb = v(out1) - v(iout_10m)
meas tran vgv_max MAX vgv from=1u to=2u
meas tran vgb_max MAX vgb from=1u to=2u

meas tran vdd_avg AVG v(vdd) from=1u to=2u
meas tran idd_avg AVG i(vsup) from=1u to=2u


*plot

plot v(buff_out1) v(buff_out2) xlimit 1u 1.0005u
plot v(out1) v(out2) xlimit 1u 1.0005u



plot  v(q) xlimit 1e-9 1.5e-9

plot v(q) v(q2) xlimit 1e-9 2.5e-9
plot  v(q2) xlimit 1e-9 2.5e-9
plot  v(q3) v(q2) xlimit 1e-9 4e-9
plot  v(buff_out3) v(q3) xlimit 1e-9 4e-9
plot  v(buff_out3) xlimit 1e-9 4e-9

plot  v(buff_out3) xlimit 10e-9 20e-9

*wrdata final_waveform_out1out2.txt v(q) v(q_bar)

*meas tran clk_period trig v(clk) val=0.9 rise=1 targ v(clk) val=0.9 rise=2
*meas tran q_period trig v(q) val=1.5 rise=1 targ v(q) val=1.5 rise=2
*print clk_period
*print q_period

linearize  q q2 q3 buff_out3  out1 buff_out1
fft  q q2 q3 buff_out3 out1 buff_out1
wrdata fft_result.txt mag(q)
*plot mag(clk) xlimit 1e9 8e9
plot mag(q) xlimit 1e9 8e9
plot mag(q2) xlimit 1e9 8e9
plot mag(q3) xlimit 0.3e9 5e9
plot mag(q3) xlimit 0.6e9 1e9
plot mag(buff_out3) xlimit 0e9 8e9
plot mag(buff_out3) xlimit 0.6e9 1e9
plot mag(out1) xlimit 4e9 7e9
plot mag(buff_out1) xlimit 4e9 7e9




.endc"} 3650 -10150 0 0 0.4 0.4 {}
N 2390 -3490 2390 -3450 {
lab=iout_vco}
N 2510 -3450 2630 -3450 {
lab=iout_vco}
N 2630 -3490 2630 -3450 {
lab=iout_vco}
N 2190 -3740 2190 -3690 {
lab=out2}
N 2270 -3690 2360 -3690 {
lab=out2}
N 2360 -3740 2360 -3690 {
lab=out2}
N 2270 -3740 2270 -3690 {
lab=out2}
N 2190 -3830 2190 -3800 {
lab=VDPWR}
N 2270 -3830 2360 -3830 {
lab=VDPWR}
N 2360 -3830 2360 -3800 {
lab=VDPWR}
N 2270 -3830 2270 -3800 {
lab=VDPWR}
N 2670 -3740 2670 -3690 {
lab=out1}
N 2750 -3690 2840 -3690 {
lab=out1}
N 2840 -3740 2840 -3690 {
lab=out1}
N 2750 -3740 2750 -3690 {
lab=out1}
N 2670 -3830 2670 -3800 {
lab=VDPWR}
N 2750 -3830 2840 -3830 {
lab=VDPWR}
N 2840 -3830 2840 -3800 {
lab=VDPWR}
N 2750 -3830 2750 -3800 {
lab=VDPWR}
N 2270 -3630 2270 -3580 {
lab=out2}
N 2270 -3580 2390 -3580 {
lab=out2}
N 2390 -3580 2390 -3550 {
lab=out2}
N 2750 -3610 2750 -3580 {
lab=out1}
N 2630 -3580 2750 -3580 {
lab=out1}
N 2630 -3580 2630 -3550 {
lab=out1}
N 2430 -3520 2480 -3520 {
lab=out1}
N 2480 -3610 2480 -3520 {
lab=out1}
N 2480 -3610 2750 -3610 {
lab=out1}
N 2540 -3520 2590 -3520 {
lab=out2}
N 2540 -3630 2540 -3520 {
lab=out2}
N 2750 -3610 2840 -3610 {
lab=out1}
N 2840 -3610 2840 -3570 {
lab=out1}
N 2810 -3540 2810 -3500 {
lab=ua[2]}
N 2850 -3500 2870 -3500 {
lab=ua[2]}
N 2870 -3540 2870 -3500 {
lab=ua[2]}
N 2510 -3450 2510 -3380 {
lab=iout_vco}
N 2160 -3630 2160 -3590 {
lab=out2}
N 2130 -3550 2130 -3500 {
lab=ua[2]}
N 2160 -3500 2190 -3500 {
lab=ua[2]}
N 2190 -3550 2190 -3500 {
lab=ua[2]}
N 2160 -3500 2160 -3430 {
lab=ua[2]}
N 2160 -3430 2850 -3430 {
lab=ua[2]}
N 2850 -3500 2850 -3430 {
lab=ua[2]}
N 2360 -3830 2670 -3830 {
lab=VDPWR}
N 2160 -3630 2270 -3630 {
lab=out2}
N 2270 -3630 2540 -3630 {
lab=out2}
N 2190 -3690 2270 -3690 {
lab=out2}
N 2190 -3830 2270 -3830 {
lab=VDPWR}
N 2670 -3690 2750 -3690 {
lab=out1}
N 2670 -3830 2750 -3830 {
lab=VDPWR}
N 2750 -3690 2750 -3610 {
lab=out1}
N 2390 -3450 2510 -3450 {
lab=iout_vco}
N 2130 -3500 2160 -3500 {
lab=ua[2]}
N 2810 -3500 2850 -3500 {
lab=ua[2]}
N 2270 -3690 2270 -3630 {
lab=out2}
N 2480 -4110 2520 -4110 {lab=GND}
N 2480 -4110 2480 -4080 {lab=GND}
N 2480 -4080 2480 -4050 {lab=GND}
N 2480 -4050 2520 -4050 {lab=GND}
N 3130 -3770 3130 -3730 {
lab=VDPWR}
N 3130 -3770 3400 -3770 {
lab=VDPWR}
N 3400 -3770 3400 -3730 {
lab=VDPWR}
N 3130 -3670 3130 -3580 {
lab=buff_out2}
N 3400 -3670 3400 -3580 {
lab=buff_out1}
N 3130 -3520 3130 -3480 {
lab=iout_10m}
N 3270 -3480 3400 -3480 {
lab=iout_10m}
N 3400 -3520 3400 -3480 {
lab=iout_10m}
N 3270 -3480 3270 -3420 {
lab=iout_10m}
N 3130 -3480 3270 -3480 {
lab=iout_10m}
N 3270 -3920 3270 -3890 {lab=GND}
N 3230 -3890 3270 -3890 {lab=GND}
N 3230 -3950 3230 -3890 {lab=GND}
N 3230 -3990 3230 -3950 {lab=GND}
N 3230 -3990 3270 -3990 {lab=GND}
N 3270 -3990 3270 -3980 {lab=GND}
N 4410 -4850 4410 -4810 {
lab=#net1}
N 4620 -4810 4650 -4810 {
lab=#net1}
N 4650 -4850 4650 -4810 {
lab=#net1}
N 4180 -5100 4180 -5020 {
lab=q_bar}
N 4180 -5190 4180 -5160 {
lab=VDPWR}
N 4860 -5070 4860 -4970 {
lab=q}
N 4860 -5190 4860 -5160 {
lab=VDPWR}
N 4450 -4880 4500 -4880 {
lab=q}
N 4500 -4970 4500 -4880 {
lab=q}
N 4650 -4970 4860 -4970 {
lab=q}
N 4560 -4880 4610 -4880 {
lab=q_bar}
N 4560 -4990 4560 -4880 {
lab=q_bar}
N 4860 -4970 4860 -4930 {
lab=q}
N 4180 -4990 4180 -4950 {
lab=q_bar}
N 4180 -4990 4410 -4990 {
lab=q_bar}
N 4410 -4990 4560 -4990 {
lab=q_bar}
N 4410 -4810 4620 -4810 {
lab=#net1}
N 4180 -5020 4180 -4990 {
lab=q_bar}
N 4650 -4970 4650 -4910 {
lab=q}
N 4410 -4990 4410 -4910 {
lab=q_bar}
N 4180 -4890 4180 -4720 {
lab=#net2}
N 4460 -4720 4860 -4720 {
lab=#net2}
N 4860 -4870 4860 -4720 {
lab=#net2}
N 4460 -4720 4460 -4660 {
lab=#net2}
N 4620 -4810 4620 -4660 {
lab=#net1}
N 4460 -4600 4460 -4550 {
lab=iout_10m_q11}
N 4460 -4550 4620 -4550 {
lab=iout_10m_q11}
N 4620 -4600 4620 -4550 {
lab=iout_10m_q11}
N 4180 -5190 4860 -5190 {
lab=VDPWR}
N 5430 -4850 5430 -4810 {
lab=#net3}
N 5640 -4810 5670 -4810 {
lab=#net3}
N 5670 -4850 5670 -4810 {
lab=#net3}
N 5200 -5100 5200 -5010 {
lab=d_bar}
N 5200 -5190 5200 -5160 {
lab=VDPWR}
N 5880 -5100 5880 -5020 {
lab=d}
N 5880 -5190 5880 -5160 {
lab=VDPWR}
N 5470 -4880 5520 -4880 {
lab=d}
N 5520 -4970 5520 -4880 {
lab=d}
N 5670 -4970 5880 -4970 {
lab=d}
N 5580 -4880 5630 -4880 {
lab=d_bar}
N 5580 -4990 5580 -4880 {
lab=d_bar}
N 5880 -4970 5880 -4930 {
lab=d}
N 5200 -4990 5200 -4950 {
lab=d_bar}
N 5200 -4990 5430 -4990 {
lab=d_bar}
N 5430 -4990 5580 -4990 {
lab=d_bar}
N 5880 -5020 5880 -4970 {
lab=d}
N 5430 -4810 5640 -4810 {
lab=#net3}
N 5200 -5010 5200 -4990 {
lab=d_bar}
N 5670 -4970 5670 -4910 {
lab=d}
N 5430 -4990 5430 -4910 {
lab=d_bar}
N 5200 -4890 5200 -4720 {
lab=#net4}
N 5480 -4720 5880 -4720 {
lab=#net4}
N 5880 -4870 5880 -4720 {
lab=#net4}
N 5480 -4720 5480 -4660 {
lab=#net4}
N 5640 -4810 5640 -4660 {
lab=#net3}
N 5480 -4600 5480 -4550 {
lab=iout_10m_q12}
N 5480 -4550 5640 -4550 {
lab=iout_10m_q12}
N 5640 -4600 5640 -4550 {
lab=iout_10m_q12}
N 5200 -5190 5880 -5190 {
lab=VDPWR}
N 4990 -4920 5160 -4920 {
lab=q_bar}
N 4990 -5020 4990 -4920 {
lab=q_bar}
N 4180 -5020 4990 -5020 {
lab=q_bar}
N 4860 -5070 6020 -5070 {
lab=q}
N 5920 -4900 6020 -4900 {
lab=q}
N 6020 -5070 6020 -4900 {
lab=q}
N 4090 -4920 4140 -4920 {lab=d}
N 4090 -4920 4090 -4370 {lab=d}
N 4090 -4370 5330 -4370 {lab=d}
N 5100 -5010 5200 -5010 {lab=d_bar}
N 4900 -4900 4950 -4900 {lab=d_bar}
N 4950 -4900 4950 -4790 {lab=d_bar}
N 5330 -5020 5330 -4370 {lab=d}
N 5330 -5020 5880 -5020 {lab=d}
N 4950 -4790 5100 -4790 {lab=d_bar}
N 5100 -5010 5100 -4790 {lab=d_bar}
N 4500 -4970 4650 -4970 {
lab=q}
N 4180 -4720 4460 -4720 {
lab=#net2}
N 5520 -4970 5670 -4970 {
lab=d}
N 5200 -4720 5480 -4720 {
lab=#net4}
N 4860 -5100 4860 -5070 {
lab=q}
N 4840 -5490 4880 -5490 {lab=GND}
N 4840 -5490 4840 -5430 {lab=GND}
N 4840 -5430 4920 -5430 {lab=GND}
N 4920 -5460 4920 -5430 {lab=GND}
N 4920 -5550 4920 -5520 {lab=GND}
N 4840 -5550 4920 -5550 {lab=GND}
N 4840 -5550 4840 -5490 {lab=GND}
N 4360 -3600 4360 -3560 {
lab=#net5}
N 4570 -3560 4600 -3560 {
lab=#net5}
N 4600 -3600 4600 -3560 {
lab=#net5}
N 4130 -3850 4130 -3770 {
lab=q2_bar}
N 4130 -3940 4130 -3910 {
lab=VDPWR}
N 4810 -3820 4810 -3720 {
lab=q2}
N 4810 -3940 4810 -3910 {
lab=VDPWR}
N 4400 -3630 4450 -3630 {
lab=q2}
N 4450 -3720 4450 -3630 {
lab=q2}
N 4600 -3720 4810 -3720 {
lab=q2}
N 4510 -3630 4560 -3630 {
lab=q2_bar}
N 4510 -3740 4510 -3630 {
lab=q2_bar}
N 4810 -3720 4810 -3680 {
lab=q2}
N 4130 -3740 4130 -3700 {
lab=q2_bar}
N 4130 -3740 4360 -3740 {
lab=q2_bar}
N 4360 -3740 4510 -3740 {
lab=q2_bar}
N 4360 -3560 4570 -3560 {
lab=#net5}
N 4130 -3770 4130 -3740 {
lab=q2_bar}
N 4600 -3720 4600 -3660 {
lab=q2}
N 4360 -3740 4360 -3660 {
lab=q2_bar}
N 4130 -3640 4130 -3470 {
lab=#net6}
N 4410 -3470 4810 -3470 {
lab=#net6}
N 4810 -3620 4810 -3470 {
lab=#net6}
N 4410 -3470 4410 -3410 {
lab=#net6}
N 4570 -3560 4570 -3410 {
lab=#net5}
N 4410 -3350 4410 -3300 {
lab=iout_10m_q21}
N 4410 -3300 4570 -3300 {
lab=iout_10m_q21}
N 4570 -3350 4570 -3300 {
lab=iout_10m_q21}
N 4130 -3940 4810 -3940 {
lab=VDPWR}
N 5380 -3600 5380 -3560 {
lab=#net7}
N 5590 -3560 5620 -3560 {
lab=#net7}
N 5620 -3600 5620 -3560 {
lab=#net7}
N 5150 -3850 5150 -3760 {
lab=d2_bar}
N 5150 -3940 5150 -3910 {
lab=VDPWR}
N 5830 -3850 5830 -3770 {
lab=d2}
N 5830 -3940 5830 -3910 {
lab=VDPWR}
N 5420 -3630 5470 -3630 {
lab=d2}
N 5470 -3720 5470 -3630 {
lab=d2}
N 5620 -3720 5830 -3720 {
lab=d2}
N 5530 -3630 5580 -3630 {
lab=d2_bar}
N 5530 -3740 5530 -3630 {
lab=d2_bar}
N 5830 -3720 5830 -3680 {
lab=d2}
N 5150 -3740 5150 -3700 {
lab=d2_bar}
N 5150 -3740 5380 -3740 {
lab=d2_bar}
N 5380 -3740 5530 -3740 {
lab=d2_bar}
N 5830 -3770 5830 -3720 {
lab=d2}
N 5380 -3560 5590 -3560 {
lab=#net7}
N 5150 -3760 5150 -3740 {
lab=d2_bar}
N 5620 -3720 5620 -3660 {
lab=d2}
N 5380 -3740 5380 -3660 {
lab=d2_bar}
N 5150 -3640 5150 -3470 {
lab=#net8}
N 5430 -3470 5830 -3470 {
lab=#net8}
N 5830 -3620 5830 -3470 {
lab=#net8}
N 5430 -3470 5430 -3410 {
lab=#net8}
N 5590 -3560 5590 -3410 {
lab=#net7}
N 5430 -3350 5430 -3300 {
lab=iout_10m_q22}
N 5430 -3300 5590 -3300 {
lab=iout_10m_q22}
N 5590 -3350 5590 -3300 {
lab=iout_10m_q22}
N 5150 -3940 5830 -3940 {
lab=VDPWR}
N 4940 -3670 5110 -3670 {
lab=q2_bar}
N 4940 -3770 4940 -3670 {
lab=q2_bar}
N 4130 -3770 4940 -3770 {
lab=q2_bar}
N 4810 -3820 5970 -3820 {
lab=q2}
N 5870 -3650 5970 -3650 {
lab=q2}
N 5970 -3820 5970 -3650 {
lab=q2}
N 4040 -3670 4090 -3670 {lab=d2}
N 4040 -3670 4040 -3120 {lab=d2}
N 4040 -3120 5280 -3120 {lab=d2}
N 5050 -3760 5150 -3760 {lab=d2_bar}
N 4850 -3650 4900 -3650 {lab=d2_bar}
N 4900 -3650 4900 -3540 {lab=d2_bar}
N 5280 -3770 5280 -3120 {lab=d2}
N 5280 -3770 5830 -3770 {lab=d2}
N 4900 -3540 5050 -3540 {lab=d2_bar}
N 5050 -3760 5050 -3540 {lab=d2_bar}
N 4450 -3720 4600 -3720 {
lab=q2}
N 4130 -3470 4410 -3470 {
lab=#net6}
N 5470 -3720 5620 -3720 {
lab=d2}
N 5150 -3470 5430 -3470 {
lab=#net8}
N 4810 -3850 4810 -3820 {
lab=q2}
N 4350 -2390 4350 -2350 {
lab=#net9}
N 4560 -2350 4590 -2350 {
lab=#net9}
N 4590 -2390 4590 -2350 {
lab=#net9}
N 4120 -2640 4120 -2560 {
lab=q3_bar}
N 4120 -2730 4120 -2700 {
lab=VDPWR}
N 4800 -2610 4800 -2510 {
lab=q3}
N 4800 -2730 4800 -2700 {
lab=VDPWR}
N 4390 -2420 4440 -2420 {
lab=q3}
N 4440 -2510 4440 -2420 {
lab=q3}
N 4590 -2510 4800 -2510 {
lab=q3}
N 4500 -2420 4550 -2420 {
lab=q3_bar}
N 4500 -2530 4500 -2420 {
lab=q3_bar}
N 4800 -2510 4800 -2470 {
lab=q3}
N 4120 -2530 4120 -2490 {
lab=q3_bar}
N 4120 -2530 4350 -2530 {
lab=q3_bar}
N 4350 -2530 4500 -2530 {
lab=q3_bar}
N 4350 -2350 4560 -2350 {
lab=#net9}
N 4120 -2560 4120 -2530 {
lab=q3_bar}
N 4590 -2510 4590 -2450 {
lab=q3}
N 4350 -2530 4350 -2450 {
lab=q3_bar}
N 4120 -2430 4120 -2260 {
lab=#net10}
N 4400 -2260 4800 -2260 {
lab=#net10}
N 4800 -2410 4800 -2260 {
lab=#net10}
N 4400 -2260 4400 -2200 {
lab=#net10}
N 4560 -2350 4560 -2200 {
lab=#net9}
N 4400 -2140 4400 -2090 {
lab=iout_10m_q31}
N 4400 -2090 4560 -2090 {
lab=iout_10m_q31}
N 4560 -2140 4560 -2090 {
lab=iout_10m_q31}
N 4120 -2730 4800 -2730 {
lab=VDPWR}
N 5370 -2390 5370 -2350 {
lab=#net11}
N 5580 -2350 5610 -2350 {
lab=#net11}
N 5610 -2390 5610 -2350 {
lab=#net11}
N 5140 -2640 5140 -2550 {
lab=d3_bar}
N 5140 -2730 5140 -2700 {
lab=VDPWR}
N 5820 -2640 5820 -2560 {
lab=d3}
N 5820 -2730 5820 -2700 {
lab=VDPWR}
N 5410 -2420 5460 -2420 {
lab=d3}
N 5460 -2510 5460 -2420 {
lab=d3}
N 5610 -2510 5820 -2510 {
lab=d3}
N 5520 -2420 5570 -2420 {
lab=d3_bar}
N 5520 -2530 5520 -2420 {
lab=d3_bar}
N 5820 -2510 5820 -2470 {
lab=d3}
N 5140 -2530 5140 -2490 {
lab=d3_bar}
N 5140 -2530 5370 -2530 {
lab=d3_bar}
N 5370 -2530 5520 -2530 {
lab=d3_bar}
N 5820 -2560 5820 -2510 {
lab=d3}
N 5370 -2350 5580 -2350 {
lab=#net11}
N 5140 -2550 5140 -2530 {
lab=d3_bar}
N 5610 -2510 5610 -2450 {
lab=d3}
N 5370 -2530 5370 -2450 {
lab=d3_bar}
N 5140 -2430 5140 -2260 {
lab=#net12}
N 5420 -2260 5820 -2260 {
lab=#net12}
N 5820 -2410 5820 -2260 {
lab=#net12}
N 5420 -2260 5420 -2200 {
lab=#net12}
N 5580 -2350 5580 -2200 {
lab=#net11}
N 5420 -2140 5420 -2090 {
lab=iout_10m_q32}
N 5420 -2090 5580 -2090 {
lab=iout_10m_q32}
N 5580 -2140 5580 -2090 {
lab=iout_10m_q32}
N 5140 -2730 5820 -2730 {
lab=VDPWR}
N 4930 -2460 5100 -2460 {
lab=q3_bar}
N 4930 -2560 4930 -2460 {
lab=q3_bar}
N 4120 -2560 4930 -2560 {
lab=q3_bar}
N 4800 -2610 5960 -2610 {
lab=q3}
N 5860 -2440 5960 -2440 {
lab=q3}
N 5960 -2610 5960 -2440 {
lab=q3}
N 4030 -2460 4080 -2460 {lab=d3}
N 4030 -2460 4030 -1910 {lab=d3}
N 4030 -1910 5270 -1910 {lab=d3}
N 5040 -2550 5140 -2550 {lab=d3_bar}
N 4840 -2440 4890 -2440 {lab=d3_bar}
N 4890 -2440 4890 -2330 {lab=d3_bar}
N 5270 -2560 5270 -1910 {lab=d3}
N 5270 -2560 5820 -2560 {lab=d3}
N 4890 -2330 5040 -2330 {lab=d3_bar}
N 5040 -2550 5040 -2330 {lab=d3_bar}
N 4440 -2510 4590 -2510 {
lab=q3}
N 4120 -2260 4400 -2260 {
lab=#net10}
N 5460 -2510 5610 -2510 {
lab=d3}
N 5140 -2260 5420 -2260 {
lab=#net12}
N 4800 -2640 4800 -2610 {
lab=q3}
N 6470 -3690 6470 -3650 {
lab=VDPWR}
N 6470 -3690 6740 -3690 {
lab=VDPWR}
N 6740 -3690 6740 -3650 {
lab=VDPWR}
N 6470 -3590 6470 -3500 {
lab=ua[1]}
N 6740 -3590 6740 -3500 {
lab=ua[0]}
N 6470 -3440 6470 -3400 {
lab=iout_10m_b2}
N 6610 -3400 6740 -3400 {
lab=iout_10m_b2}
N 6740 -3440 6740 -3400 {
lab=iout_10m_b2}
N 6610 -3400 6610 -3340 {
lab=iout_10m_b2}
N 6470 -3400 6610 -3400 {
lab=iout_10m_b2}
N 6610 -3840 6610 -3810 {lab=GND}
N 6570 -3810 6610 -3810 {lab=GND}
N 6570 -3870 6570 -3810 {lab=GND}
N 6570 -3910 6570 -3870 {lab=GND}
N 6570 -3910 6610 -3910 {lab=GND}
N 6610 -3910 6610 -3900 {lab=GND}
N 2390 -5020 2390 -4970 {
lab=cm}
N 2430 -4940 2520 -4940 {
lab=cm}
N 2390 -4910 2390 -4880 {
lab=GND}
N 2660 -4910 2660 -4880 {
lab=GND}
N 2390 -5020 2520 -5020 {
lab=cm}
N 2520 -5020 2520 -4940 {
lab=cm}
N 2660 -5040 2660 -4970 {
lab=iout_vco}
N 2390 -5070 2390 -5020 {
lab=cm}
N 2520 -4940 2780 -4940 {
lab=cm}
N 2820 -4910 2820 -4880 {
lab=GND}
N 2820 -5040 2820 -4970 {
lab=iout_10m}
N 2960 -4910 2960 -4880 {
lab=GND}
N 2960 -5040 2960 -4970 {
lab=iout_10m_b2}
N 2780 -4940 2920 -4940 {lab=cm}
N 2920 -4940 3060 -4940 {lab=cm}
N 2350 -4520 2350 -4490 {
lab=GND}
N 2350 -4650 2350 -4580 {
lab=iout_10m_q11}
N 3060 -4940 3190 -4940 {lab=cm}
N 2550 -4520 2550 -4490 {
lab=GND}
N 2550 -4650 2550 -4580 {
lab=iout_10m_q12}
N 2740 -4520 2740 -4490 {
lab=GND}
N 2740 -4650 2740 -4580 {
lab=iout_10m_q21}
N 2920 -4520 2920 -4490 {
lab=GND}
N 2920 -4650 2920 -4580 {
lab=iout_10m_q22}
N 3060 -4520 3060 -4490 {
lab=GND}
N 3060 -4650 3060 -4580 {
lab=iout_10m_q31}
N 3210 -4520 3210 -4490 {
lab=GND}
N 3210 -4650 3210 -4580 {
lab=iout_10m_q32}
N 2310 -4550 2510 -4550 {lab=cm}
N 2510 -4550 2700 -4550 {lab=cm}
N 3020 -4550 3170 -4550 {lab=cm}
N 2700 -4550 2880 -4550 {lab=cm}
N 2880 -4550 3020 -4550 {lab=cm}
N 2070 -4940 2110 -4940 {lab=GND}
N 2070 -4940 2070 -4910 {lab=GND}
N 2070 -4910 2070 -4880 {lab=GND}
N 2070 -4880 2120 -4880 {lab=GND}
C {sky130_fd_pr/doc/nfet3_03v3_nvt.svg} 2610 -3670 0 0 {}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 2610 -3520 0 0 {name=M10
W=10
L=0.15
nf=1
mult=50
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 2410 -3520 0 1 {name=M11
W=10
L=0.15
nf=1
mult=50
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 2840 -3560 3 1 {name=M12
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 2160 -3570 3 1 {name=M13
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {ind.sym} 2360 -3770 2 0 {name=L3
m=1
value=0.5n
footprint=1206
device=inductor}
C {ind.sym} 2840 -3770 0 0 {name=L4
m=1
value=0.5n
footprint=1206
device=inductor}
C {iopin.sym} 2520 -3830 3 0 {name=p2 lab=VDPWR
}
C {iopin.sym} 2270 -3660 2 0 {name=p3 lab=out2}
C {iopin.sym} 2750 -3660 0 0 {name=p4 lab=out1
}
C {iopin.sym} 2160 -3430 2 0 {name=p5 lab=ua[2]}
C {sky130_fd_pr/cap_mim_m3_1.sym} 2190 -3770 2 0 {name=C3 model=cap_mim_m3_1 W=9.8 L=9.8 MF=1 spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_1.sym} 2670 -3770 2 0 {name=C4 model=cap_mim_m3_1 W=9.8 L=9.8 MF=1 spiceprefix=X}
C {iopin.sym} 2490 -4110 3 0 {name=p1 lab=GND
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 2500 -4080 0 0 {name=M1
W=10
L=0.15
nf=1
mult=6
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 3110 -3550 0 0 {name=M14
W=10
L=0.15
nf=1
mult=4
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 3420 -3550 0 1 {name=M15
W=10
L=0.15
nf=1
mult=4
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/res_generic_po.sym} 3130 -3700 0 0 {name=R8
W=0.8
L=1.66
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} 3400 -3700 0 0 {name=R9
W=0.8
L=1.66
model=res_generic_po
spiceprefix=X
mult=1}
C {iopin.sym} 3400 -3620 0 0 {name=p7 lab=buff_out1}
C {iopin.sym} 3130 -3630 2 0 {name=p11 lab=buff_out2}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 3250 -3950 0 0 {name=M2
W=10
L=0.15
nf=1
mult=4
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {lab_pin.sym} 3250 -3990 1 0 {name=p12 sig_type=std_logic lab=GND}
C {lab_pin.sym} 3090 -3550 0 0 {name=p13 sig_type=std_logic lab=out2}
C {lab_pin.sym} 3440 -3550 2 0 {name=p8 sig_type=std_logic lab=out1}
C {sky130_fd_pr/doc/nfet3_03v3_nvt.svg} 4630 -5030 0 0 {}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4630 -4880 0 0 {name=M28
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4430 -4880 0 1 {name=M29
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4880 -4900 0 1 {name=M30
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4160 -4920 0 0 {name=M31
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {lab_pin.sym} 5440 -4630 0 0 {name=p42 sig_type=std_logic lab=buff_out2

}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4440 -4630 0 0 {name=M32
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4640 -4630 0 1 {name=M57
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/doc/nfet3_03v3_nvt.svg} 5650 -5030 0 0 {}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5650 -4880 0 0 {name=M58
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5450 -4880 0 1 {name=M59
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5900 -4900 0 1 {name=M60
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5180 -4920 0 0 {name=M61
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5460 -4630 0 0 {name=M62
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5660 -4630 0 1 {name=M63
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {ngspice_get_value.sym} 4620 -4690 0 0 {name=r30 node=clk
descr="I="}
C {lab_pin.sym} 4420 -4670 0 0 {name=p10 sig_type=std_logic lab=clk

}
C {lab_pin.sym} 4660 -4650 2 0 {name=p15 sig_type=std_logic lab=clk_bar}
C {lab_pin.sym} 5440 -4660 0 0 {name=p16 sig_type=std_logic lab=clk_bar}
C {lab_pin.sym} 5680 -4660 2 0 {name=p17 sig_type=std_logic lab=clk

}
C {sky130_fd_pr/res_generic_po.sym} 4180 -5130 0 0 {name=R20
W=0.8
L=1.66
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} 4860 -5130 0 0 {name=R27
W=0.8
L=1.66
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} 5200 -5130 0 0 {name=R28
W=0.8
L=1.66
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} 5880 -5130 0 0 {name=R29
W=0.8
L=1.66
model=res_generic_po
spiceprefix=X
mult=1}
C {iopin.sym} 4090 -4820 2 0 {name=p18 lab=d}
C {iopin.sym} 5120 -5070 3 0 {name=p21 lab=q}
C {iopin.sym} 4990 -5020 0 0 {name=p22 lab=q_bar}
C {iopin.sym} 4950 -4900 0 0 {name=p23 lab=d_bar}
C {lab_pin.sym} 5680 -4630 2 0 {name=p27 sig_type=std_logic lab=buff_out1

}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4900 -5490 0 0 {name=M3
W=10
L=0.15
nf=1
mult=36
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/doc/nfet3_03v3_nvt.svg} 4580 -3780 0 0 {}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4580 -3630 0 0 {name=M4
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4380 -3630 0 1 {name=M5
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4830 -3650 0 1 {name=M6
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4110 -3670 0 0 {name=M7
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {lab_pin.sym} 5390 -3380 0 0 {name=p29 sig_type=std_logic lab=q_bar

}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4390 -3380 0 0 {name=M8
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4590 -3380 0 1 {name=M9
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/doc/nfet3_03v3_nvt.svg} 5600 -3780 0 0 {}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5600 -3630 0 0 {name=M16
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5400 -3630 0 1 {name=M17
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5850 -3650 0 1 {name=M18
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5130 -3670 0 0 {name=M19
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5410 -3380 0 0 {name=M20
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5610 -3380 0 1 {name=M21
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {ngspice_get_value.sym} 4570 -3440 0 0 {name=r1 node=clk
descr="I="}
C {lab_pin.sym} 4370 -3380 0 0 {name=p31 sig_type=std_logic lab=q

}
C {lab_pin.sym} 4610 -3380 2 0 {name=p32 sig_type=std_logic lab=q_bar}
C {lab_pin.sym} 5390 -3410 0 0 {name=p33 sig_type=std_logic lab=clk_bar}
C {lab_pin.sym} 5630 -3410 2 0 {name=p34 sig_type=std_logic lab=clk

}
C {sky130_fd_pr/res_generic_po.sym} 4130 -3880 0 0 {name=R2
W=0.8
L=1.66
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} 4810 -3880 0 0 {name=R3
W=0.8
L=1.66
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} 5150 -3880 0 0 {name=R4
W=0.8
L=1.66
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} 5830 -3880 0 0 {name=R5
W=0.8
L=1.66
model=res_generic_po
spiceprefix=X
mult=1}
C {iopin.sym} 4040 -3570 2 0 {name=p35 lab=d2}
C {iopin.sym} 5070 -3820 3 0 {name=p36 lab=q2}
C {iopin.sym} 4940 -3770 0 0 {name=p37 lab=q2_bar}
C {iopin.sym} 4900 -3650 0 0 {name=p38 lab=d2_bar}
C {lab_pin.sym} 5630 -3380 2 0 {name=p41 sig_type=std_logic lab=q

}
C {sky130_fd_pr/doc/nfet3_03v3_nvt.svg} 4570 -2570 0 0 {}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4570 -2420 0 0 {name=M22
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4370 -2420 0 1 {name=M23
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4820 -2440 0 1 {name=M24
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4100 -2460 0 0 {name=M25
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {lab_pin.sym} 5380 -2170 0 0 {name=p43 sig_type=std_logic lab=q2_bar

}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4380 -2170 0 0 {name=M26
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 4580 -2170 0 1 {name=M27
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/doc/nfet3_03v3_nvt.svg} 5590 -2570 0 0 {}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5590 -2420 0 0 {name=M33
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5390 -2420 0 1 {name=M34
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5840 -2440 0 1 {name=M35
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5120 -2460 0 0 {name=M36
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5400 -2170 0 0 {name=M37
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 5600 -2170 0 1 {name=M38
W=10
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {ngspice_get_value.sym} 4560 -2230 0 0 {name=r6 node=clk
descr="I="}
C {lab_pin.sym} 4360 -2210 0 0 {name=p45 sig_type=std_logic lab=clk

}
C {lab_pin.sym} 4600 -2190 2 0 {name=p46 sig_type=std_logic lab=clk_bar}
C {lab_pin.sym} 5380 -2200 0 0 {name=p47 sig_type=std_logic lab=clk_bar}
C {lab_pin.sym} 5620 -2200 2 0 {name=p48 sig_type=std_logic lab=clk

}
C {sky130_fd_pr/res_generic_po.sym} 4120 -2670 0 0 {name=R7
W=0.8
L=1.66
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} 4800 -2670 0 0 {name=R10
W=0.8
L=1.66
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} 5140 -2670 0 0 {name=R11
W=0.8
L=1.66
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} 5820 -2670 0 0 {name=R12
W=0.8
L=1.66
model=res_generic_po
spiceprefix=X
mult=1}
C {iopin.sym} 4030 -2360 2 0 {name=p49 lab=d3}
C {iopin.sym} 5060 -2610 3 0 {name=p50 lab=q3}
C {iopin.sym} 4930 -2560 0 0 {name=p51 lab=q3_bar}
C {iopin.sym} 4890 -2440 0 0 {name=p52 lab=d3_bar}
C {lab_pin.sym} 5620 -2170 2 0 {name=p55 sig_type=std_logic lab=q2

}
C {lab_pin.sym} 4600 -2170 2 0 {name=p58 sig_type=std_logic lab=q2_bar

}
C {lab_pin.sym} 4360 -2170 0 0 {name=p59 sig_type=std_logic lab=q2

}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 6450 -3470 0 0 {name=M39
W=10
L=0.15
nf=1
mult=4
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 6760 -3470 0 1 {name=M40
W=10
L=0.15
nf=1
mult=4
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/res_generic_po.sym} 6470 -3620 0 0 {name=R13
W=0.8
L=1.66
model=res_generic_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_generic_po.sym} 6740 -3620 0 0 {name=R14
W=0.8
L=1.66
model=res_generic_po
spiceprefix=X
mult=1}
C {iopin.sym} 6740 -3540 0 0 {name=p60 lab=ua[0]}
C {iopin.sym} 6470 -3550 2 0 {name=p62 lab=ua[1]}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 6590 -3870 0 0 {name=M41
W=10
L=0.15
nf=1
mult=4
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {lab_pin.sym} 6590 -3910 1 0 {name=p64 sig_type=std_logic lab=GND}
C {lab_pin.sym} 6430 -3470 0 0 {name=p65 sig_type=std_logic lab=q3_bar}
C {lab_pin.sym} 6780 -3470 2 0 {name=p66 sig_type=std_logic lab=q3}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 2410 -4940 0 1 {name=M42
W=50
L=0.15
nf=1
mult=1
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {gnd.sym} 2390 -4880 0 0 {name=l1 lab=GND}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 2640 -4940 0 0 {name=M43
W=50
L=0.15
nf=1
mult=7
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {gnd.sym} 2660 -4880 0 1 {name=l2 lab=GND}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 2800 -4940 0 0 {name=M44
W=50
L=0.15
nf=1
mult=8
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {gnd.sym} 2820 -4880 0 1 {name=l6 lab=GND}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 2940 -4940 0 0 {name=M45
W=50
L=0.15
nf=1
mult=5
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
lab=iout_10m_b2}
C {gnd.sym} 2960 -4880 0 1 {name=l8 lab=GND}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 2330 -4550 0 0 {name=M46
W=50
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
lab=iout_10m_b3}
C {gnd.sym} 2350 -4490 0 1 {name=l5 lab=GND}
C {lab_pin.sym} 3190 -4940 2 0 {name=p67 sig_type=std_logic lab=cm

}
C {lab_pin.sym} 2310 -4550 0 0 {name=p69 sig_type=std_logic lab=cm

}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 2530 -4550 0 0 {name=M47
W=50
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
lab=iout_10m_b3}
C {gnd.sym} 2550 -4490 0 1 {name=l7 lab=GND}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 2720 -4550 0 0 {name=M48
W=50
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
lab=iout_10m_b3}
C {gnd.sym} 2740 -4490 0 1 {name=l9 lab=GND}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 2900 -4550 0 0 {name=M49
W=50
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
lab=iout_10m_b3}
C {gnd.sym} 2920 -4490 0 1 {name=l10 lab=GND}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 3040 -4550 0 0 {name=M50
W=50
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
lab=iout_10m_b3}
C {gnd.sym} 3060 -4490 0 1 {name=l11 lab=GND}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 3190 -4550 0 0 {name=M51
W=50
L=0.15
nf=1
mult=10
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
lab=iout_10m_b3}
C {gnd.sym} 3210 -4490 0 1 {name=l12 lab=GND}
C {sky130_fd_pr/res_generic_po.sym} 2390 -5100 0 0 {name=R15
W=0.8
L=19.09
model=res_generic_po
spiceprefix=X
mult=1}
C {iopin.sym} 2660 -5040 3 0 {name=p71 lab=iout_vco}
C {iopin.sym} 2820 -5040 3 0 {name=p72 lab=iout_10m}
C {iopin.sym} 2960 -5040 3 0 {name=p73 lab=iout_10m_b2}
C {iopin.sym} 2350 -4650 3 0 {name=p74 lab=iout_10m_q11}
C {iopin.sym} 2550 -4650 3 0 {name=p75 lab=iout_10m_q12}
C {iopin.sym} 2740 -4650 3 0 {name=p76 lab=iout_10m_q21}
C {iopin.sym} 2920 -4650 3 0 {name=p77 lab=iout_10m_q22}
C {iopin.sym} 3060 -4650 3 0 {name=p78 lab=iout_10m_q31}
C {iopin.sym} 3210 -4650 3 0 {name=p79 lab=iout_10m_q32}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 2090 -4910 0 0 {name=M52
W=50
L=0.15
nf=1
mult=2
body=GND
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {lab_pin.sym} 4840 -5490 0 0 {name=p28 sig_type=std_logic lab=GND

}
C {lab_pin.sym} 6610 -3340 3 0 {name=p81 sig_type=std_logic lab=iout_10m_b2
}
C {lab_pin.sym} 5560 -4550 3 0 {name=p61 sig_type=std_logic lab=iout_10m_q12

}
C {lab_pin.sym} 4540 -4550 3 0 {name=p25 sig_type=std_logic lab=iout_10m_q11
}
C {lab_pin.sym} 4490 -3300 3 0 {name=p24 sig_type=std_logic lab=iout_10m_q21}
C {lab_pin.sym} 5510 -3300 3 0 {name=p40 sig_type=std_logic lab=iout_10m_q22}
C {lab_pin.sym} 4480 -2090 3 0 {name=p39 sig_type=std_logic lab=iout_10m_q31}
C {lab_pin.sym} 5500 -2090 3 0 {name=p54 sig_type=std_logic lab=iout_10m_q32}
C {lab_pin.sym} 2390 -5130 1 0 {name=p53 sig_type=std_logic lab=VDPWR}
C {lab_pin.sym} 2080 -4940 1 0 {name=p70 sig_type=std_logic lab=GND}
C {lab_pin.sym} 4660 -4630 2 0 {name=p80 sig_type=std_logic lab=buff_out2

}
C {lab_pin.sym} 4420 -4630 0 0 {name=p20 sig_type=std_logic lab=buff_out1

}
C {lab_pin.sym} 3270 -3420 3 0 {name=p19 sig_type=std_logic lab=iout_10m}
C {lab_pin.sym} 2510 -3380 3 0 {name=p9 sig_type=std_logic lab=iout_vco}
C {sky130_fd_pr/cap_mim_m3_1.sym} 2160 -3400 0 0 {name=C1 model=cap_mim_m3_1 W=92 L=18 MF=1 spiceprefix=X}
C {gnd.sym} 2160 -3370 0 1 {name=l13 lab=GND}
C {lab_pin.sym} 3260 -3770 1 0 {name=p6 sig_type=std_logic lab=VDPWR}
C {lab_pin.sym} 4470 -3940 1 0 {name=p14 sig_type=std_logic lab=VDPWR}
C {lab_pin.sym} 5550 -3940 1 0 {name=p56 sig_type=std_logic lab=VDPWR}
C {lab_pin.sym} 4510 -5190 1 0 {name=p30 sig_type=std_logic lab=VDPWR}
C {lab_pin.sym} 5560 -5190 1 0 {name=p26 sig_type=std_logic lab=VDPWR}
C {lab_pin.sym} 6600 -3690 1 0 {name=p68 sig_type=std_logic lab=VDPWR}
C {lab_pin.sym} 4440 -2730 1 0 {name=p63 sig_type=std_logic lab=VDPWR}
C {lab_pin.sym} 5490 -2730 1 0 {name=p44 sig_type=std_logic lab=VDPWR}
