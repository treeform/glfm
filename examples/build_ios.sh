# force a build clean every time
rm ~/.cache/nim/main_d/*
rm ios_triangle/src/*

# build it for iOS
/p/Nim/bin/nim c -f --os:ios -c --noMain:on main.nim

# copy all support files into the ios project
cp ~/.cache/nim/main_d/*.c ios_triangle/src/
cp nimbase.h ios_triangle/src/
cp file_compat.h ios_triangle/src/
cp ../glfm/include/glfm.h ios_triangle/src/
cp ../glfm/src/glfm_platform.h ios_triangle/src/
cp ../glfm/src/glfm_platform_ios.m ios_triangle/src/
cp -r assets/* ios_triangle/