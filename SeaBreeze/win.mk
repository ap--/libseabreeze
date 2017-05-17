# Note this assumes you have MSBuild.exe in your %PATH%, e.g.
#   /cygdrive/c/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe

SEABREEZE_SLN=SeaBreeze.sln
SEABREEZE_DLL=SeaBreeze.dll
SEABREEZE_LIB=SeaBreeze.lib
LIB_DIR=../../../lib

MSBUILD_BIN = MSBuild.exe
MSBUILD_OPTS ?= /property:Configuration=Release /property:Platform=Win32
ifeq ($(SB_ARCH), 32)
MSBUILD_OUTPUT_DIR = Release
else
MSBUILD_OUTPUT_DIR = x64/Release
endif

all:
	$(MSBUILD_BIN) $(MSBUILD_OPTS) $(SEABREEZE_SLN)
	cp -v $(MSBUILD_OUTPUT_DIR)/$(SEABREEZE_DLL) $(MSBUILD_OUTPUT_DIR)/$(SEABREEZE_LIB) $(LIB_DIR)

clean:
	@if which MSBuild.exe 1>/dev/null 2>&1 ; then \
	    $(MSBUILD_BIN) $(SEABREEZE_SLN) /t:Clean ; \
     fi
	@rm -rf Debug VSProj/Debug VSProj/x64
	@rm -f  $(LIB_DIR)/$(SEABREEZE_DLL) \
	        $(LIB_DIR)/$(SEABREEZE_LIB)
