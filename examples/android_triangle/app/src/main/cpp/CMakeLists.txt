#
# Copyright (C) The Android Open Source Project
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
#

cmake_minimum_required(VERSION 3.4.1)

# build native_app_glue as a static lib
set(${CMAKE_C_FLAGS}, "${CMAKE_C_FLAGS}")
add_library(native_app_glue STATIC
    ${ANDROID_NDK}/sources/android/native_app_glue/android_native_app_glue.c)

# now build app's shared lib
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11 -Wall -Werror")

# Export ANativeActivity_onCreate(),
# Refer to: https://github.com/android-ndk/ndk/issues/381.
set(CMAKE_SHARED_LINKER_FLAGS
    "${CMAKE_SHARED_LINKER_FLAGS} -v -u ANativeActivity_onCreate")

add_library(native-activity SHARED
        main.c
        glfm_platform_android.c
        _7_7_7_7_7_7_7Users7andre.vonhouck7.nimble7pkgs7opengl-1.2.07opengl.nim.c
        #stdlib_dynlib.nim.c
        #stdlib_posix.nim.c
        stdlib_io.nim.c
        stdlib_system.nim.c
        )

target_include_directories(native-activity PRIVATE
    ${ANDROID_NDK}/sources/android/native_app_glue)


#add_library(glfm SHARED glfm_platform_android.c)
#
#target_include_directories(glfm PRIVATE
#        ${ANDROID_NDK}/sources/android/native_app_glue
#        )




# add lib dependencies
target_link_libraries(native-activity
    android
    native_app_glue
    EGL
    GLESv2
    log
    )



