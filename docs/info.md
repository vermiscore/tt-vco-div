## How it works

An NMOS cross-coupled LC VCO oscillates at about 5.2 GHz. A CML divide-by-8 brings this down to about 650 MHz, and an output buffer drives it off chip.

- **ua[0]**: RF output (+), about 640–700 MHz
- **ua[1]**: RF output (−), complementary to ua[0]
- **ua[2]**: vcont, the VCO tuning input (0.1–0.8 V, nominal 0.4 V). It has an on-chip MIM filter capacitor.

The output frequency changes with vcont (Kvco ≈ 4 MHz/V at 0.4 V, measured at the output), so an audio signal on vcont gives FM. For example, a ±0.1 V signal gives about ±430 kHz of deviation.

## How to test

1. Power VDPWR from a clean, low-noise LDO. The VCO is sensitive to supply noise, about −58 MHz/V at the output.
2. Bias ua[2] at about 0.4 V through a resistor (around 500 Ω) and add the audio signal on top, for example a guitar through a preamp.
3. Connect ua[0] (or ua[0]/ua[1] through a balun) to an SDR and tune it to about 650 MHz in WFM/NFM mode.

## External hardware

- Low-noise LDO for the supply
- Guitar preamp or audio source that biases vcont at 0.4 V
- SDR receiver that covers 600–700 MHz (e.g. RTL-SDR, HackRF)
