# chatllm.lua
lua api wrapper for llm-inference chatllm.cpp

All credits go to original repo: https://github.com/foldl/chatllm.cpp and Qwen 2.5 32b Coder Instruct which made 99% of work. I only guided it with prompts.

To launch you need install https://github.com/ScriptTiger/LuaJIT-For-Windows/releases/download/1APR2023/LuaJIT-For-Windows.exe

Then put main.lua, libchtllm.dll, ggml.dll and .bin llm file to that folder where you installed luajit-for-windows. Run LuaJIT-For-Windows.cmd and type in console:

luajit -b main.lua main.luac

luajit main.luac -m qwen2.5-1.5b.bin

Original libchatllm.dll, ggml.dll and libchatllm.lib can be found in original repo already mentioned above.

Links for quantatized models:

QWen-2.5 1.5B - https://modelscope.cn/api/v1/models/judd2024/chatllm_quantized_qwen2.5/repo?Revision=master&FilePath=qwen2.5-1.5b.bin

Gemma-2 2B - https://modelscope.cn/api/v1/models/judd2024/chatllm_quantized_gemma2_2b/repo?Revision=master&FilePath=gemma2-2b.bin

If you need more quantatized models use this python model downloader: https://github.com/foldl/chatllm.cpp/blob/master/scripts/model_downloader.py

You can convert custom safetensors model to inner chatllm.cpp format by using this script: https://github.com/foldl/chatllm.cpp/blob/master/convert.py

Converting tutorial: https://github.com/foldl/chatllm.cpp?tab=readme-ov-file#quantize-model

List of supported llm architecture types suitable for conversion: https://github.com/foldl/chatllm.cpp/blob/master/docs/models.md
