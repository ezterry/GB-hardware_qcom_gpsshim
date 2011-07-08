#******************************************************************************
#* GPS HAL shim
#* load older GPS libraries on gingerbread (and above?)
#*
#* Note: this file has been modified for use in ezGingerbread by Terrence Ezrol
#* Modifications can be considered provided to the public domain *or* under
#* the original licence as follows
#*
#* Copyright 2010 - Ricardo Cerqueira
#*
#* Licensed under the Apache License, Version 2.0 (the "License");
#* you may not use this file except in compliance with the License.
#* You may obtain a copy of the License at
#*
#*      http://www.apache.org/licenses/LICENSE-2.0
#*
#* Unless required by applicable law or agreed to in writing, software
#* distributed under the License is distributed on an "AS IS" BASIS,
#* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#* See the License for the specific language governing permissions and
#* limitations under the License.
#*
#******************************************************************************/

ifeq ($(BOARD_USES_GPSSHIM),true)

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_MODULE := gps.$(TARGET_GPSSHIM_BOARD_NAME)

LOCAL_SHARED_LIBRARIES:= \
	liblog \
    $(BOARD_GPS_LIBRARIES) \

LOCAL_SRC_FILES += \
    gps.c

LOCAL_CFLAGS += \
    -fno-short-enums 

ifneq ($(BOARD_GPSSHIM_BAD_AGPS),)
LOCAL_CFLAGS += \
    -DNO_AGPS
endif

#ifneq ($(BOARD_GPS_NEEDS_XTRA),)
LOCAL_CFLAGS += \
    -DNEEDS_INITIAL_XTRA
#endif

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw

include $(BUILD_SHARED_LIBRARY)

#If ALT_GPSSHIM_BOARDNAME is set generate a second library
# (aka trout if the main board name was sapphire)
ifneq ($(ALT_GPSSHIM_BOARDNAME),)

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_MODULE := gps.$(ALT_GPSSHIM_BOARDNAME)

LOCAL_SHARED_LIBRARIES:= \
    liblog \
    $(BOARD_GPS_LIBRARIES) 

LOCAL_SRC_FILES += \
    gps.c

LOCAL_CFLAGS += \
    -fno-short-enums

ifneq ($(BOARD_GPSSHIM_BAD_AGPS),)
LOCAL_CFLAGS += \
    -DNO_AGPS
endif

LOCAL_CFLAGS += \
    -DNEEDS_INITIAL_XTRA

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw

include $(BUILD_SHARED_LIBRARY)

endif #ALT_GPSSHIM_BOARDNAME set

endif # BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE
