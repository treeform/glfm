rm ~/.cache/nim/main_d/*
/p/Nim/bin/nim c -f --cpu:arm --os:android --newruntime -c -d:androidNDK main.nim
cp ~/.cache/nim/main_d/*.c android_triangle/app/src/main/cpp/
cp ../glfm/include/glfm.h android_triangle/app/src/main/cpp/
cp ../glfm/src/glfm_platform.h android_triangle/app/src/main/cpp/
cp ../glfm/src/glfm_platform_android.c android_triangle/app/src/main/cpp/
cp -r assets/* android_triangle/app/src/main/assets