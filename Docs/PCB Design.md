
# Vending Machine PCB

The PCB has three parts which connect together over I2C. The inter-board connectors run at 5V, including the I2C bus, and use the same pinout at Qwiic, however use JST_XH connectors with a 2.5mm pin pitch, rather than SH connectors with 1.0mm pin pitch.

Each sub-board runs at 3v3, and has an AMS1117[^2] 3v3 LDO regulator and TCA9406DC[^3] i2c level switcher for independent VCC supply. Alternately the bus can be run at 3v3 and have an LDO only installed in one location, for this option solder jumpers can be closed and the LDO and level switcher does not get installed.

If using the default configuration with the bus running at 5V, one end of the bus will need to have the I2C pullup resistors installed, otherwise the internal pull-ups on the PLC are used.

## Relay Board

The main function of the board is to switch solid state relays in order to control the eight motors for the vending machine, plus two extra circuits. Mains power supply and the switched circuits are plugged via Phoenix style connectors along the top of the board. The 120V section of the board is demarcated from 5V and 3v3 sections.

The secondary function is as the power supply for the rest of the system. 120V DC is regulated to 5V with the HLK-PM01 regulator, and 5V is regulated down to 3v3 by the AMS1117. The 5V supply is used by default for VExt to supply the connected boards, while the 3v3 remains local and named VCC.

The relays are low-side switched through the sx1509[^1] i2c multiplexer. Remaining unused pins from the multiplexer are available on J11, these may be used in a 3x3 mesh to sense or switch up to 9 LEDs or buttons. The I2C address the sx1509 responds on can be set using J11 and J12, as detailed on the silk screen for the board.

The OSC, <SPAN STYLE="text-decoration:overline">RST</span>, and <SPAN STYLE="text-decoration:overline">INT</span> pins from the multiplexer are broken out to J12.

The JST_XH connectors are paired allowing daisy-chaining other sub-boards. Configuration of the I2C bus is done on the back of the board. If desired the I2C bus can be run at 3v3 by closing and switching the jumpers on the back of the board, and not installing the level switcher. Ensure that the total drain on the LDO does not exceed its rated 1A. The I2C pullups also need to be installed at some location on the bus if running at the default 5V, if running at 3v3 the internal pull-ups on the ESP32 will manage this.

## ESP32 Breakout

The ESP32 breakout board connects to the other boards through the pair of JST connectors. This is the default power supply for the board, however if needed a power supply can be directly connected to the appropriate pins. It is reccommended to use the ESP32-WROOM-32UE[^4] MCU. This uses an external antenna which will need to be connected.

While the ESP32-WROOM-32E module with the on-board antenna does use the same pin-out this may not work well. The J36 connector for the screen is under the antenna and may interfere with placement, plus J31 GPIO output is witin the clearance zone for the antenna so may interfere with signals to the board.

All the available ESP32 pins are broken out in the same layout as is used in most devboards, plus the pins are grouped into 2x 4pin, 1x 5 pin, and 1x 8 pin connectors. These have a consistent pin-out, with GND, 3v3, and then various GPIO pins. A status LED is connected to GPIO 32, and an LED indicating power on is available.

On the reverse of the board, the appropriate pinout to connect to a [2.4" OLED screen module](https://www.aliexpress.com/item/1005006100836064.html) is provided. This is in the reverse direction to the other pins given it's connecting from the reverse side. The size and shape of the board is ideal to mount back-to-back with the screen module.

## Multiplexer

The I2C multiplexer breakout that uses the same SX1509 core IC as the relay board. This contains two I2C JST connectors for daisy-chaining, a connector for the OSC, <SPAN STYLE="text-decoration:overline">RST</span>, and <SPAN STYLE="text-decoration:overline">INT</span> pins, and 2x2 connector for the multiplexer pins. The multiplexer can be used in a 8x8 matrix, allowing 64 possible input buttons or LEDs to be controlled.

# References

[^1]: SX1509:  [Datasheet](https://cdn.sparkfun.com/datasheets/BreakoutBoards/sx1509.pdf)  [ESPHome](https://esphome.io/components/sx1509.html)
[^2]: AMS1117-3.3: [Datasheet](http://www.advanced-monolithic.com/pdf/ds1117.pdf)
[^3]: TCA9406DC: [Datasheet](https://www.ti.com/lit/ds/symlink/tca9406.pdf)
[^4]: ESP32-WROOM-32UE: [Datasheet](https://www.espressif.com/sites/default/files/documentation/esp32-wroom-32e_esp32-wroom-32ue_datasheet_en.pdf)
