# This is fine

A fun experiment, nothing special.

An ESP32-C3 with a buzzer and a small SSD1306 OLED (128x64, I2C), running
[ESPHome](https://esphome.io). The screen shows a clock and, while a 3D print is
running, its progress and remaining time, read from Home Assistant. Pressing the
"Trigger The Dog" button (from Home Assistant, the device's web page or
`make trigger`) sounds the buzzer and plays a short fire animation.

## Wiring

| Part           | Pin              |
| -------------- | ---------------- |
| Buzzer         | GPIO2            |
| OLED SDA / SCL | GPIO21 / GPIO20  |

## Build

1. Copy `secrets.example.yaml` to `secrets.yaml` and fill it in. `secrets.yaml`
   is git-ignored.
2. Set the `substitutions` at the top of `finedog.yaml`:
   - `printer`: the entity prefix of your printer in Home Assistant. The
     config reads `<printer>_print_status`, `_print_progress`,
     `_remaining_time` and `_current_stage`, as created by the Bambu Lab
     integration.
   - `time_zone`: your time zone, e.g. `Europe/Amsterdam`.
   - `devicename` / `friendly_name` if you want a different name.
3. Build and flash with Docker:

   ```sh
   make compile   # build
   make upload    # flash
   make logs
   ```

4. Add the device in Home Assistant (ESPHome integration).

`client/` holds a small Go program that presses the button over HTTP.
