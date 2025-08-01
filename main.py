from machine import Pin
import time

# ESP32 pin assignments (match FPGA side)
gpio_numbers = [4, 5, 16, 17, 18, 19, 21, 22]  # GPIO data input
valid_pin_num = 23                            # VALID strobe

gpio_pins = [Pin(i, Pin.IN) for i in gpio_numbers]
valid_pin = Pin(valid_pin_num, Pin.IN)

# Print current mapping
print("📌 ESP32 is using these GPIOs for input:")
for i, pin_num in enumerate(gpio_numbers):
    print(f"  📥 gpio[{i}] ← Pin({pin_num})")
print(f"  ✅ valid_pin ← Pin({valid_pin_num})\n")

def read_byte():
    value = 0
    for i, pin in enumerate(gpio_pins):
        if pin.value():
            value |= (1 << i)
    return value

while True:
    if valid_pin.value():
        byte = read_byte()
        print("📦 Received from FPGA:", hex(byte))
    else:
        print("⏳ Waiting for valid...")
    time.sleep(0.5)
