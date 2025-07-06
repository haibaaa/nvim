--[[
return {
	"kawre/leetcode.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},

	opts = {
		---@type string
		arg = "leetcode.nvim",

		---@type lc.lang
		lang = "cpp",

		cn = {
			enabled = false,           ---@type boolean
			translator = true,         ---@type boolean
			translate_problems = true, ---@type boolean
		},

		---@type lc.storage
		storage = {
			home = vim.fn.stdpath("data") .. "/leetcode",
			cache = vim.fn.stdpath("cache") .. "/leetcode",
		},

		---@type table<string, boolean>
		plugins = {
			non_standalone = false,
		},

		logging = true, ---@type boolean

		injector = {}, ---@type table<lc.lang, lc.inject>

		cache = {
			update_interval = 60 * 60 * 24 * 7, ---@type integer (7 days)
		},

		editor = {
			reset_previous_code = true, ---@type boolean
			fold_imports = true,        ---@type boolean
		},

		console = {
			open_on_runcode = true, ---@type boolean
			dir = "row",            ---@type lc.direction

			size = {                ---@type lc.size
				width = "90%",
				height = "75%",
			},

			result = {
				size = "60%", ---@type lc.size
			},

			testcase = {
				virt_text = true, ---@type boolean
				size = "40%",     ---@type lc.size
			},
		},

		description = {
			position = "left",  ---@type lc.position
			width = "30%",      ---@type lc.size
			show_stats = true,  ---@type boolean
		},

		---@type lc.picker
		picker = {
			provider = nil,
		},

		hooks = {
			enter = {},            ---@type fun()[]
			question_enter = {},  ---@type fun(question: lc.ui.Question)[]
			leave = {},           ---@type fun()[]
		},

		keys = {
			toggle = { "q" },          ---@type string|string[]
			confirm = { "<CR>" },      ---@type string|string[]
			reset_testcases = "r",     ---@type string
			use_testcase = "U",        ---@type string
			focus_testcases = "H",     ---@type string
			focus_result = "L",        ---@type string
		},

		---@type lc.highlights
		theme = {},

		image_support = false, ---@type boolean
	},
}
]]--
return {
  "kawre/leetcode.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },

  opts = {
    arg = "leetcode.nvim",
    lang = "cpp",

    cn = {
      enabled = false,
      translator = true,
      translate_problems = true,
    },

    storage = {
      home = vim.fn.stdpath("data") .. "/leetcode",
      cache = vim.fn.stdpath("cache") .. "/leetcode",
    },

    plugins = {
      non_standalone = false,
    },

    logging = true,
    injector = {},

    cache = {
      update_interval = 60 * 60 * 24 * 7,
    },

    editor = {
      reset_previous_code = true,
      fold_imports = true,
    },

    console = {
      open_on_runcode = true,
      dir = "row",
      size = {
        width = "90%",
        height = "75%",
      },
      result = {
        size = "60%",
      },
      testcase = {
        virt_text = true,
        size = "40%",
      },
    },

    description = {
      position = "left",
      width = "30%",
      show_stats = true,
    },

    picker = {
      provider = nil,
    },

    hooks = {
      enter = {},
      question_enter = {
        function(question)
          -- Disable LSP diagnostics for LeetCode buffers
          vim.schedule(function()
            vim.diagnostic.disable(0)
            -- Optional: Detach LSP clients too
            -- for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            --   vim.lsp.buf_detach_client(0, client.id)
            -- end
          end)
        end,
      },
      leave = {},
    },

    keys = {
      toggle = { "q" },
      confirm = { "<CR>" },
      reset_testcases = "r",
      use_testcase = "U",
      focus_testcases = "H",
      focus_result = "L",
    },

    theme = {},
    image_support = false,
  },
}


