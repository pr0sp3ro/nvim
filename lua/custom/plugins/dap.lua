return {
  "mfussenegger/nvim-dap",
  ft = "go",
  cmd = {
    "DapContinue",
    "DapToggleBreakpoint",
    "DapClearBreakpoints",
    "DapToggleRepl",
    "DapStepOver",
    "DapStepInto",
    "DapStepOut",
    "DapPause",
    "DapTerminate",
    "DapDisconnect",
    "DapNew",
    "DapEval",
  },
  config = function()
    local dap = require("dap")

    dap.adapters.go = {
      type = "server",
      port = "${port}",
      executable = {
        command = "dlv",
        args = { "dap", "--listen=127.0.0.1:${port}" },
      },
    }

    dap.configurations.go = {
      {
        name = "Debug package",
        type = "go",
        request = "launch",
        mode = "debug",
        program = "${fileDirname}",
        cwd = "${fileDirname}",
      },
      {
        name = "Debug package tests",
        type = "go",
        request = "launch",
        mode = "test",
        program = "${fileDirname}",
        cwd = "${fileDirname}",
      },
      {
        name = "Attach to process",
        type = "go",
        request = "attach",
        mode = "local",
        processId = require("dap.utils").pick_process,
      },
    }
  end,
}
