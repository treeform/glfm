rm ~/.cache/nim/main_d/*
/p/Nim/bin/nim c -f --cpu:arm --os:android --newruntime -c -d:androidNDK main.nim
cp ~/.cache/nim/main_d/*.c android_triangle/app/src/main/cpp/
