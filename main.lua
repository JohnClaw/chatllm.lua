local ffi = require("ffi")

-- Define the PrintType enum
ffi.cdef[[
enum PrintType {
    PRINT_CHAT_CHUNK = 0,
    PRINTLN_META = 1,
    PRINTLN_ERROR = 2,
    PRINTLN_REF = 3,
    PRINTLN_REWRITTEN_QUERY = 4,
    PRINTLN_HISTORY_USER = 5,
    PRINTLN_HISTORY_AI = 6,
    PRINTLN_TOOL_CALLING = 7,
    PRINTLN_EMBEDDING = 8,
    PRINTLN_RANKING = 9,
    PRINTLN_TOKEN_IDS = 10
};
]]

-- Define the ChatllmObj type
ffi.cdef[[
typedef struct ChatllmObj ChatllmObj;
]]

-- Define the function pointers
ffi.cdef[[
typedef void (*ChatllmPrintProc)(void* user_data, enum PrintType print_type, const char* utf8_str);
typedef void (*ChatllmEndProc)(void* user_data);
]]

-- Load the shared library
local libchatllm = ffi.load("libchatllm.dll")

-- Define the functions from the shared library
ffi.cdef[[
ChatllmObj* chatllm_create();
void chatllm_append_param(ChatllmObj* obj, const char* utf8_str);
int chatllm_start(ChatllmObj* obj, ChatllmPrintProc f_print, ChatllmEndProc f_end, void* user_data);
void chatllm_set_gen_max_tokens(ChatllmObj* obj, int gen_max_tokens);
void chatllm_restart(ChatllmObj* obj, const char* utf8_sys_prompt);
int chatllm_user_input(ChatllmObj* obj, const char* utf8_str);
int chatllm_set_ai_prefix(ChatllmObj* obj, const char* utf8_str);
int chatllm_tool_input(ChatllmObj* obj, const char* utf8_str);
int chatllm_tool_completion(ChatllmObj* obj, const char* utf8_str);
int chatllm_text_tokenize(ChatllmObj* obj, const char* utf8_str);
int chatllm_text_embedding(ChatllmObj* obj, const char* utf8_str);
int chatllm_qa_rank(ChatllmObj* obj, const char* utf8_str_q, const char* utf8_str_a);
int chatllm_rag_select_store(ChatllmObj* obj, const char* name);
void chatllm_abort_generation(ChatllmObj* obj);
void chatllm_show_statistics(ChatllmObj* obj);
int chatllm_save_session(ChatllmObj* obj, const char* utf8_str);
int chatllm_load_session(ChatllmObj* obj, const char* utf8_str);
]]

-- Define the callback functions
local function chatllm_print(user_data, print_type, utf8_str)
    if print_type == 0 then
        io.write(ffi.string(utf8_str))
    else
        print(ffi.string(utf8_str))
    end
    io.stdout:flush()
end

local function chatllm_end(user_data)
    print("")
end

-- Create the C function pointers for callbacks
local chatllm_print_c = ffi.cast("ChatllmPrintProc", chatllm_print)
local chatllm_end_c = ffi.cast("ChatllmEndProc", chatllm_end)

-- Main function
local function main()
    local chat = libchatllm.chatllm_create()
    for i = 1, #arg do
        libchatllm.chatllm_append_param(chat, arg[i])
    end

    local r = libchatllm.chatllm_start(chat, chatllm_print_c, chatllm_end_c, nil)
    if r ~= 0 then
        print(">>> chatllm_start error: " .. r)
        os.exit(r)
    end

    while true do
        io.write("You  > ")
        local input = io.read()
        if input == nil or input:match("^%s*$") then
            -- Skip to the next iteration if input is empty or only whitespace
        else
            io.write("A.I. > ")
            r = libchatllm.chatllm_user_input(chat, input)
            if r ~= 0 then
                print(">>> chatllm_user_input error: " .. r)
                break
            end
        end
    end
end

-- Run the main function
main()