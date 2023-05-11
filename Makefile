RTEMS_API = 6
RTEMS_CPU = sparc
RTEMS_BSP = gr712rc-qual-only

RTEMS_ROOT = /opt/rtems-6-sparc-gr712rc-smp-4
PKG_CONFIG = $(RTEMS_ROOT)/lib/pkgconfig/$(RTEMS_CPU)-rtems$(RTEMS_API)-$(RTEMS_BSP).pc
BUILDDIR = b-$(RTEMS_BSP)

DEPFLAGS = -MT $@ -MD -MP -MF $(basename $@).d
WARNFLAGS = -Wall -Wextra
OPTFLAGS = -O2 -g -ffunction-sections -fdata-sections
EXEEXT = .exe

ABI_FLAGS = $(shell pkg-config --cflags $(PKG_CONFIG))
LDFLAGS = $(shell pkg-config --libs $(PKG_CONFIG))
CFLAGS = $(DEPFLAGS) $(WARNFLAGS) $(ABI_FLAGS) $(OPTFLAGS)
CXXFLAGS = $(DEPFLAGS) $(WARNFLAGS) $(ABI_FLAGS) $(OPTFLAGS) -fno-exceptions
ASFLAGS = $(ABI_FLAGS)

CCLINK = $(CC) $(CFLAGS) -Wl,-Map,$(basename $@).map
CXXLINK = $(CXX) $(CXXFLAGS) -Wl,-Map,$(basename $@).map

$(BUILDDIR)/%.o: %.c | $(BUILDDIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILDDIR)/%.o: %.S | $(BUILDDIR)
	$(CC) $(CPPFLAGS) -DASM $(CFLAGS) -c $< -o $@

$(BUILDDIR)/%.o: %.cc | $(BUILDDIR)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/%.o: %.cpp | $(BUILDDIR)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/%.o: %.s | $(BUILDDIR)
	$(AS) $(ASFLAGS) $< -o $@

export PATH := $(RTEMS_ROOT)/bin:$(PATH)

export AR = $(RTEMS_CPU)-rtems$(RTEMS_API)-ar
export AS = $(RTEMS_CPU)-rtems$(RTEMS_API)-as
export CC = $(RTEMS_CPU)-rtems$(RTEMS_API)-gcc
export CXX = $(RTEMS_CPU)-rtems$(RTEMS_API)-g++
export LD = $(RTEMS_CPU)-rtems$(RTEMS_API)-ld
export NM = $(RTEMS_CPU)-rtems$(RTEMS_API)-nm
export OBJCOPY = $(RTEMS_CPU)-rtems$(RTEMS_API)-objcopy
export RANLIB = $(RTEMS_CPU)-rtems$(RTEMS_API)-ranlib
export SIZE = $(RTEMS_CPU)-rtems$(RTEMS_API)-size
export STRIP = $(RTEMS_CPU)-rtems$(RTEMS_API)-strip

APP = $(BUILDDIR)/app

APP_C_FILES =
APP_OBJS = $(APP_C_FILES:%.c=$(BUILDDIR)/%.o)
APP_DEPS = $(APP_C_FILES:%.c=$(BUILDDIR)/%.d)

APP_CXX_FILES =
APP_CXX_FILES += init.cc
APP_OBJS += $(APP_CXX_FILES:%.cc=$(BUILDDIR)/%.o)
APP_DEPS += $(APP_CXX_FILES:%.cc=$(BUILDDIR)/%.d)

all: $(APP)$(EXEEXT)

$(BUILDDIR):
	mkdir $(BUILDDIR)

$(APP)$(EXEEXT): $(APP_OBJS)
	$(CXXLINK) $^ $(LDFLAGS) -o $@

run: $(APP)$(EXEEXT)
	sparc-rtems$(RTEMS_API)-sis -leon3 -dumbio -r s $<

clean:
	rm -rf $(BUILDDIR)

-include $(APP_DEPS)
