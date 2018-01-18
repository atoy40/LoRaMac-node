###############################################################################
# Boiler-plate

# cross-platform directory manipulation
ifeq ($(shell echo $$OS),$$OS)
    MAKEDIR = if not exist "$(1)" mkdir "$(1)"
    RM = rmdir /S /Q "$(1)"
else
    MAKEDIR = '$(SHELL)' -c "mkdir -p \"$(1)\""
    RM = '$(SHELL)' -c "rm -rf \"$(1)\""
endif

OBJDIR := BUILD
# Move to the build directory
ifeq (,$(filter $(OBJDIR),$(notdir $(CURDIR))))
.SUFFIXES:
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
MAKETARGET = '$(MAKE)' --no-print-directory -C $(OBJDIR) -f '$(mkfile_path)' \
		'SRCDIR=$(CURDIR)' $(MAKECMDGOALS)
.PHONY: $(OBJDIR) clean
all:
	+@$(call MAKEDIR,$(OBJDIR))
	+@$(MAKETARGET)
$(OBJDIR): all
Makefile : ;
% :: $(OBJDIR) ; :
clean :
	$(call RM,$(OBJDIR))

else

# trick rules into thinking we are in the root, when we are in the bulid dir
VPATH = ..

# Boiler-plate
###############################################################################
# Project settings

PROJECT := NucleoL073RZ

# Project settings
###############################################################################
# Objects and Paths

OBJECTS += ./src/apps/LoRaMac/classA/$(PROJECT)/main.o
#OBJECTS += ./src/apps/test/$(PROJECT)/main.o
OBJECTS += ./src/boards/mcu/stm32/utilities.o
OBJECTS += ./src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal.o
#OBJECTS += ./src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_adc.o
#OBJECTS += ./src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_adc_ex.o
OBJECTS += ./src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_cortex.o
#OBJECTS += ./src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_i2c.o
#OBJECTS += ./src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_i2c_ex.o
OBJECTS += ./src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_gpio.o
OBJECTS += ./src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_pwr.o
OBJECTS += ./src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_pwr_ex.o
OBJECTS += ./src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_rcc.o
OBJECTS += ./src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_rcc_ex.o
OBJECTS += ./src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_rtc.o
OBJECTS += ./src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_rtc_ex.o
OBJECTS += ./src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_spi.o
OBJECTS += ./src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_uart.o
OBJECTS += ./src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_uart_ex.o
#OBJECTS += ./src/boards/$(PROJECT)/adc-board.o
OBJECTS += ./src/boards/$(PROJECT)/board.o
#OBJECTS += ./src/boards/$(PROJECT)/eeprom-board.o
OBJECTS += ./src/boards/$(PROJECT)/gpio-board.o
#OBJECTS += ./src/boards/$(PROJECT)/gps-board.o
#OBJECTS += ./src/boards/$(PROJECT)/i2c-board.o
OBJECTS += ./src/boards/$(PROJECT)/rtc-board.o
OBJECTS += ./src/boards/$(PROJECT)/spi-board.o
OBJECTS += ./src/boards/$(PROJECT)/sx1272-board.o
OBJECTS += ./src/boards/$(PROJECT)/uart-board.o
#OBJECTS += ./src/boards/$(PROJECT)/uart-usb-board.o
OBJECTS += ./src/boards/$(PROJECT)/cmsis/system_stm32l0xx.o
OBJECTS += ./src/boards/$(PROJECT)/cmsis/arm-gcc/startup_stm32l073xx.o
OBJECTS += ./src/boards/$(PROJECT)/cmsis/arm-gcc/syscalls.o
OBJECTS += ./src/mac/LoRaMac.o
OBJECTS += ./src/mac/LoRaMacCrypto.o
OBJECTS += ./src/mac/region/Region.o
OBJECTS += ./src/mac/region/RegionCommon.o
OBJECTS += ./src/mac/region/RegionEU868.o
#OBJECTS += ./src/peripherals/gpio-ioe.o
#OBJECTS += ./src/peripherals/mma8451.o
#OBJECTS += ./src/peripherals/mpl3115.o
#OBJECTS += ./src/peripherals/pam7q.o
#OBJECTS += ./src/peripherals/sx1509.o
OBJECTS += ./src/radio/sx1272/sx1272.o
#OBJECTS += ./src/system/adc.o
OBJECTS += ./src/system/delay.o
OBJECTS += ./src/system/fifo.o
OBJECTS += ./src/system/gpio.o
#OBJECTS += ./src/system/gps.o
#OBJECTS += ./src/system/i2c.o
OBJECTS += ./src/system/timer.o
OBJECTS += ./src/system/uart.o
OBJECTS += ./src/system/crypto/aes.o
OBJECTS += ./src/system/crypto/cmac.o

INCLUDE_PATHS += -I../src/boards/$(PROJECT)
INCLUDE_PATHS += -I../src/boards/$(PROJECT)/cmsis
INCLUDE_PATHS += -I../src/boards/mcu/stm32
INCLUDE_PATHS += -I../src/boards/mcu/stm32/cmsis
INCLUDE_PATHS += -I../src/boards/mcu/stm32/STM32L0xx_HAL_Driver/Inc
INCLUDE_PATHS += -I../src/boards/mcu/stm32/STM32_USB_Device_Library/Core/Inc
INCLUDE_PATHS += -I../src/mac
INCLUDE_PATHS += -I../src/mac/region
INCLUDE_PATHS += -I../src/peripherals
INCLUDE_PATHS += -I../src/radio
INCLUDE_PATHS += -I../src/system
INCLUDE_PATHS += -I../src/system/crypto

LIBRARY_PATHS :=
LIBRARIES :=
LINKER_SCRIPT ?= ../src/boards/$(PROJECT)/cmsis/arm-gcc/stm32l073xx_flash.ld

# Objects and Paths
###############################################################################
# Tools and Flags

AS      = 'arm-none-eabi-gcc' '-x' 'assembler-with-cpp' '-c' '--specs=nano.specs' '-Wall' '-Wextra' '-Wno-unused-parameter' '-Wno-missing-field-initializers' '-fmessage-length=0' '-fno-exceptions' '-fno-builtin' '-ffunction-sections' '-fdata-sections' '-funsigned-char' '-MMD' '-fno-delete-null-pointer-checks' '-fomit-frame-pointer' '-Os' '-DMBED_DEBUG' '-DMBED_TRAP_ERRORS_ENABLED=1' '-mcpu=cortex-m0plus' '-mthumb'
CC      = 'arm-none-eabi-gcc' '-std=gnu99' '-c' '--specs=nano.specs' '-Wall' '-Wextra' '-Wno-unused-parameter' '-Wno-missing-field-initializers' '-fmessage-length=0' '-fno-exceptions' '-fno-builtin' '-ffunction-sections' '-fdata-sections' '-funsigned-char' '-MMD' '-fno-delete-null-pointer-checks' '-fomit-frame-pointer' '-Os' '-DMBED_DEBUG' '-DMBED_TRAP_ERRORS_ENABLED=1' '-mcpu=cortex-m0plus' '-mthumb'
CPP     = 'arm-none-eabi-g++' '-std=gnu++98' '-fno-rtti' '-Wvla' '-c' '-Wall' '-Wextra' '-Wno-unused-parameter' '-Wno-missing-field-initializers' '-fmessage-length=0' '-fno-exceptions' '-fno-builtin' '-ffunction-sections' '-fdata-sections' '-funsigned-char' '-MMD' '-fno-delete-null-pointer-checks' '-fomit-frame-pointer' '-Os' '-DMBED_DEBUG' '-DMBED_TRAP_ERRORS_ENABLED=1' '-mcpu=cortex-m0plus' '-mthumb'
LD      = 'arm-none-eabi-gcc'
ELF2BIN = 'arm-none-eabi-objcopy'
PREPROC = 'arm-none-eabi-cpp' '-E' '-P' '-Wl,--gc-sections' '-Wl,-n' '-mcpu=cortex-m0plus' '-mthumb'


C_FLAGS += -std=gnu99
#C_FLAGS += -flto
C_FLAGS += -DREGION_EU868
C_FLAGS += -DUSE_HAL_DRIVER
C_FLAGS += -DSTM32L073xx

CXX_FLAGS += -std=gnu++98
CXX_FLAGS += -fno-rtti
#CXX_FLAGS += -flto
CXX_FLAGS += -Wvla
CXX_FLAGS += -DREGION_EU868
CXX_FLAGS += -DUSE_HAL_DRIVER
CXX_FLAGS += -DSTM32L073xx

ASM_FLAGS += -x
ASM_FLAGS += assembler-with-cpp
ASM_FLAGS += -I.


#LD_FLAGS :=-Wl,--gc-sections -Wl,--wrap,main -Wl,--wrap,_malloc_r -Wl,--wrap,_free_r -Wl,--wrap,_realloc_r -Wl,--wrap,_memalign_r -Wl,--wrap,_calloc_r -Wl,--wrap,exit -Wl,--wrap,atexit -Wl,-n -mcpu=cortex-m0plus -mthumb 
LD_FLAGS :=-Wl,--gc-sections -Wl,-n -mcpu=cortex-m0plus -mthumb -specs=nano.specs #-flto

LD_SYS_LIBS :=-Wl,--start-group -lstdc++ -lsupc++ -lm -lc -lgcc -lnosys  -Wl,--end-group

# Tools and Flags
###############################################################################
# Rules

.PHONY: all lst size


all: $(PROJECT).bin $(PROJECT).hex size


.s.o:
	+@$(call MAKEDIR,$(dir $@))
	+@echo "Assemble: $(notdir $<)"
  
	@$(AS) -c $(ASM_FLAGS) -o $@ $<
  


.S.o:
	+@$(call MAKEDIR,$(dir $@))
	+@echo "Assemble: $(notdir $<)"
  
	@$(AS) -c $(ASM_FLAGS) -o $@ $<
  

.c.o:
	+@$(call MAKEDIR,$(dir $@))
	+@echo "Compile: $(notdir $<)"
	@$(CC) $(C_FLAGS) $(INCLUDE_PATHS) -o $@ $<

.cpp.o:
	+@$(call MAKEDIR,$(dir $@))
	+@echo "Compile: $(notdir $<)"
	@$(CPP) $(CXX_FLAGS) $(INCLUDE_PATHS) -o $@ $<


$(PROJECT).link_script.ld: $(LINKER_SCRIPT)
	@$(PREPROC) $< -o $@



$(PROJECT).elf: $(OBJECTS) $(SYS_OBJECTS) $(PROJECT).link_script.ld 
	+@echo "link: $(notdir $@)"
	@$(LD) $(LD_FLAGS) -T $(filter-out %.o, $^) $(LIBRARY_PATHS) --output $@ $(filter %.o, $^) $(LIBRARIES) $(LD_SYS_LIBS)


$(PROJECT).bin: $(PROJECT).elf
	$(ELF2BIN) -O binary $< $@
	+@echo "===== bin file ready to flash: $(OBJDIR)/$@ =====" 

$(PROJECT).hex: $(PROJECT).elf
	$(ELF2BIN) -O ihex $< $@


# Rules
###############################################################################
# Dependencies

DEPS = $(OBJECTS:.o=.d) $(SYS_OBJECTS:.o=.d)
-include $(DEPS)
endif

# Dependencies
###############################################################################
