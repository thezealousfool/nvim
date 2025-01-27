return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"stevearc/overseer.nvim",
	},
	keys = {
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<leader>ds",
			function()
				require("dap").continue()
			end,
			desc = "Start/Continue",
		},
		{
			"<leader>dc",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to cursor",
		},
		{
			"<leader>dJ",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<leader>dd",
			function()
				require("dap").down()
			end,
			desc = "Down",
		},
		{
			"<leader>du",
			function()
				require("dap").up()
			end,
			desc = "Up",
		},
		{
			"<leader>dh",
			function()
				require("dap").run_last()
			end,
			desc = "Run Last",
		},
		{
			"<leader>dK",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<leader>dj",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>dk",
			function()
				require("dap").step_back()
			end,
			desc = "Step Over",
		},
		{
			"<leader>dr",
			function()
				require("overseer").run_template()
			end,
			desc = "Restart",
		},
		{
			"<leader>dR",
			function()
				require("dap").restart()
			end,
			desc = "Restart",
		},
		{
			"<leader>dq",
			function()
				require("dap").terminate()
			end,
			desc = "Quit",
		},
		{
			"<leader>di",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Widgets",
		},
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

		require("overseer").setup()
		dapui.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		dap.adapters.lldb = {
			type = "executable",
			command = "lldb-dap",
			name = "lldb",
		}
	end,
}
