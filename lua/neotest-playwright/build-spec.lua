--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
-- Lua Library inline imports
local function __TS__ObjectAssign(target, ...)
    local sources = {...}
    for i = 1, #sources do
        local source = sources[i]
        for key in pairs(source) do
            target[key] = source[key]
        end
    end
    return target
end
-- End of Lua Library inline imports
local ____exports = {}
local getExtraArgs
local ____build_2Dcommand = require('neotest-playwright.build-command')
local buildCommand = ____build_2Dcommand.buildCommand
local async = require("neotest.async")
local logger = require("neotest.logging")
local ____adapter_2Doptions = require('neotest-playwright.adapter-options')
local options = ____adapter_2Doptions.options
local ____preset_2Doptions = require('neotest-playwright.preset-options')
local COMMAND_PRESETS = ____preset_2Doptions.COMMAND_PRESETS
____exports.buildSpec = function(args)
    if not args then
        logger.error("No args")
        return
    end
    if not args.tree then
        logger.error("No args.tree")
        return
    end
    local pos = args.tree:data()
    local testFilter = (pos.type == "test" or pos.type == "namespace") and (pos.path .. ":") .. tostring(pos.range[1] + 1) or pos.path
    local commandOptions = __TS__ObjectAssign(
        {},
        COMMAND_PRESETS[options.preset],
        {
            bin = options.get_playwright_command(pos.path),
            config = options.get_playwright_config(pos.path),
            projects = options.projects,
            testFilter = testFilter
        }
    )
    local resultsPath = async.fn.tempname() .. ".json"
    local extraArgs = getExtraArgs(args.extra_args, options.extra_args)
    return {
        command = buildCommand(commandOptions, extraArgs),
        cwd = type(options.get_cwd) == "function" and options.get_cwd(pos.path) or nil,
        context = {results_path = resultsPath, file = pos.path},
        env = __TS__ObjectAssign({PLAYWRIGHT_JSON_OUTPUT_NAME = resultsPath}, options.env)
    }
end
getExtraArgs = function(...)
    local argArrays = {...}
    local args = {}
    for ____, argArray in ipairs(argArrays) do
        for ____, arg in ipairs(argArray or ({})) do
            if type(arg) == "string" and #arg > 0 then
                args[#args + 1] = arg
            end
        end
    end
    return args
end
return ____exports
