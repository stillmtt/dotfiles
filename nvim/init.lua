-- Theme 
--[[
• habamax (good)
• evening (good)
• morning
• delek
• desert
• elflord
• industry
• darkblue
• retrobox (good)
• sorbet (good)
]]

vim.cmd.colorscheme("habamax") -- Set theme 

vim.g.mapleader = " "

-- The "n" means these shortcuts work in normal mode
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })

vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- relative numbers and current line shows its absolute number
vim.opt.mouse = "a"            -- Enable mouse support
vim.opt.termguicolors = true   -- Use full terminal colors
vim.opt.clipboard = "unnamedplus" -- Use the system clipboard
vim.opt.spelllang = { "en", "it" }

-- Search settings
vim.opt.ignorecase = true      -- Ignore case when searching
vim.opt.smartcase = true       -- Unless the search includes capitals

-- Use spaces for indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4       -- A tab character displays as 4 spaces
vim.opt.shiftwidth = 4    -- Indent and unindent by 4 spaces
vim.opt.softtabstop = 4   -- Pressing Tab inserts 4 spaces
vim.opt.autoindent = true -- Carries the current line’s indentation onto the next line when you press Enter

-- Keep the cursor a few lines away from the screen edges
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Highlight the line containing the cursor
vim.opt.cursorline = true

-- Visual Settings
vim.opt.termguicolors = true -- Enable 24-bit colors
vim.opt.signcolumn = "yes"  
-- vim.opt.colorcolumn = "80"
vim.opt.showmatch = true  -- Highlight matching brackets

-- File handling
vim.opt.undofile = true -- Makes Neovim save undoo history to disk
vim.opt.autoread = true -- Auto-reload file if changed outside
vim.opt.autowrite = false -- Don't auto-save on some event
-- algorithm:histogram often produces more readable alignments;
-- linematch:60 tries to match changed lines within a nearby block
vim.opt.diffopt:append({
  "algorithm:histogram",
  "linematch:60",
})

-- Set undo directory and ensure it exists
local undodir = "~/.local/share/nvim/undodir" -- Undo directory path
vim.opt.undodir = vim.fn.expand(undodir) -- Expand to full path
local undodir_path = vim.fn.expand(undodir)
if vim.fn.isdirectory(undodir_path) == 0 then
	vim.fn.mkdir(undodir_path, "p") -- Create if not exists
end



vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "python" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "lisp" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 8
    vim.opt_local.tabstop = 8
  end,
})

-- PLUGINS

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
})

-- load languages support highlighting
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "c", "python", "javascript", "typescript", "go",
    "racket", "clojure", "scheme",
  },
  callback = function()
    vim.treesitter.start()
  end,
})


-- Auto Commands

-- Restore last cursor position when reopening a file
local last_cursor_group = vim.api.nvim_create_augroup("LastCursorGroup", {})
vim.api.nvim_create_autocmd("BufReadPost", {
	group = last_cursor_group,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Highlight the yanked text for 200ms
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})
