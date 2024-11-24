# chatllm.lua
lua api wrapper for llm-inference chatllm.cpp

All credits go to original repo: https://github.com/foldl/chatllm.cpp and Qwen 2.5 32b Coder Instruct which made 99% of work. I only guided it with prompts.

To launch you need install https://github.com/ScriptTiger/LuaJIT-For-Windows/releases/download/1APR2023/LuaJIT-For-Windows.exe
Then put main.lua, libchtllm.dll, ggml.dll and .bin llm file to that folder where you installed luajit-for-windows. Run LuaJIT-For-Windows.cmd and type in console:

luajit -b main.lua main.luac

luajit main.luac -m llm.bin
