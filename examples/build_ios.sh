rm ~/.cache/nim/main_d/*
/p/Nim/bin/nim c -f --os:ios --newruntime -c main.nim
cp ~/.cache/nim/main_d/*.c ios_triangle/example/src/
