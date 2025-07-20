.PHONY: all update-submodules compile validate upload clean logs

all: compile

# Compile ESPHome firmware
compile:
	@echo "Compiling The firmware..."
	docker run --rm -v "${PWD}":/config -it ghcr.io/esphome/esphome compile finedog.yaml

# Validate ESPHome configuration
validate:
	@echo "Validating ESPHome configuration..."
	docker run --rm -v "${PWD}":/config -it ghcr.io/esphome/esphome config finedog.yaml

# Upload firmware to ESP32-C3 via USB or OTA
upload: compile
	@echo "Uploading firmware to ESP32-C3..."
	docker run --rm -v "${PWD}":/config --privileged -it ghcr.io/esphome/esphome upload finedog.yaml

# Clean ESPHome build artifacts
clean:
	@echo "Cleaning ESPHome build artifacts..."
	docker run --rm -v "${PWD}":/config -it ghcr.io/esphome/esphome clean finedog.yaml

# View ESPHome logs (useful for debugging)
logs:
	@echo "Streaming ESPHome logs..."
	docker run --rm -v "${PWD}":/config -it ghcr.io/esphome/esphome logs finedog.yaml

trigger:
	@echo "Triggering the dog..."
	curl -X POST http://finedog.lan/switch/trigger_the_dog/turn_on
