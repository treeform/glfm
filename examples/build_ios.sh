rm ~/.cache/nim/main_d/*
/p/Nim/bin/nim c -f --os:ios --noMain:on --newruntime -c main.nim
cp ~/.cache/nim/main_d/*.c ios_triangle/src/
cp ../glfm/include/glfm.h ios_triangle/src/
cp ../glfm/src/glfm_platform.h ios_triangle/src/
cp ../glfm/src/glfm_platform_ios.m ios_triangle/src/
cp -r assets/* ios_triangle/assets