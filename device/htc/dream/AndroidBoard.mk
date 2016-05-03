# Copyright (C) 2007 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := $(call my-dir)

$(call add-radio-file,recovery/images/firmware_install.565)

file := $(TARGET_OUT_KEYLAYOUT)/trout-keypad.kl
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/trout-keypad.kl | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT_KEYLAYOUT)/trout-keypad-v2.kl
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/trout-keypad-v2.kl | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT_KEYLAYOUT)/trout-keypad-v3.kl
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/trout-keypad-v3.kl | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT_KEYLAYOUT)/trout-keypad-qwertz.kl
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/trout-keypad-qwertz.kl | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_ROOT_OUT)/init.trout.rc
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/init.trout.rc | $(ACP)
	$(transform-prebuilt-to-target)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := trout-keypad.kcm
include $(BUILD_KEY_CHAR_MAP)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := trout-keypad-v2.kcm
include $(BUILD_KEY_CHAR_MAP)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := trout-keypad-v3.kcm
include $(BUILD_KEY_CHAR_MAP)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := trout-keypad-qwertz.kcm
include $(BUILD_KEY_CHAR_MAP)

include device/htc/dream-sapphire/AndroidBoardCommon.mk

-include vendor/htc/dream/AndroidBoardVendor.mk
