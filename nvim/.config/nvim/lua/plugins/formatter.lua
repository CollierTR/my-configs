return { -- Autoformat
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true, dotenv = true }
      local name = vim.api.nvim_buf_get_name(bufnr)
      -- .env values often contain `;`/`=`/spaces; formatters mangle them
      if name:match("%.env") or disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      javascript = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      --typescript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
      astro = { "prettierd", "prettier" },
      html = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      json = { "prettierd", "prettier" },
    },
    formatters = {
      prettier = {
        prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
      },
      prettierd = {
        prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
      },
    },
  },
}
