-- Инициализация Packer (менеджер плагинов)
require('packer').startup(function()
  use 'wbthomason/packer.nvim'          -- Менеджер плагинов
  use 'nvim-treesitter/nvim-treesitter' -- Подсветка синтаксиса
  use 'neovim/nvim-lspconfig'           -- Настройка LSP
  use 'williamboman/mason.nvim'         -- Менеджер LSP, линтеров, форматтеров
  use 'williamboman/mason-lspconfig.nvim'
  use 'hrsh7th/nvim-cmp'                -- Автодополнение
  use 'hrsh7th/cmp-nvim-lsp'            -- Источник данных для nvim-cmp
  use 'hrsh7th/cmp-buffer'              -- Автодополнение для буфера
  use 'hrsh7th/cmp-path'                -- Автодополнение путей
  use 'L3MON4D3/LuaSnip'                -- Сниппеты
  use 'saadparwaiz1/cmp_luasnip'        -- Источник сниппетов для nvim-cmp
  use 'nvim-lualine/lualine.nvim'       -- Статусная строка
  use 'nvim-tree/nvim-tree.lua'         -- Файловый менеджер
  use 'mfussenegger/nvim-dap'           -- Отладка
  use 'puremourning/vimspector'
  use 'ellisonleao/gruvbox.nvim'   -- Пример для Gruvbox
  use 'folke/tokyonight.nvim'      -- Пример для TokyoNight
  use 'xiyaowong/transparent.nvim'
end)



vim.cmd[[colorscheme tokyonight]]
require('tokyonight').setup({
  style = "night",  -- Варианты: "storm", "night", "day"
  transparent = true,  -- Прозрачный фон
})


-- Настройка Treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = { "cpp", "c" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})

-- Настройка Mason и LSP (clangd для C++)
require('mason').setup()
require('mason-lspconfig').setup()
require('lspconfig').clangd.setup({
  cmd = { "clangd" },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- Настройка автодополнения (nvim-cmp)
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn['luasnip#expand_or_jumpable']() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn['luasnip#jumpable'](-1) == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Настройка статусной строки (Lualine)
require('lualine').setup({
  options = {
    theme = 'tokyonight',
  },
})

-- Настройка файлового менеджера (NvimTree)
require('nvim-tree').setup()
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')

-- Форматирование кода при сохранении
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.cpp", "*.h" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Настройка отладки (nvim-dap)
local dap = require('dap')
dap.adapters.cppdbg = {
  type = 'executable',
  command = '/path/to/OpenDebugAD7', -- Укажите путь к OpenDebugAD7
}

-- Автоматически открывать NvimTree при запуске без файлов

-- Автоматически открывать NvimTree при запуске без файлов
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if #vim.fn.argv() ~= 0 then
      require("nvim-tree.api").tree.open()
    end
  end,
})

dap.configurations.cpp = {
  {
    name = "Запуск программы",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'Enable pretty printing',
        ignoreFailures = false,
      },
    },
  },
}

-- Общие горячие клавиши
vim.keymap.set('n', '<leader>f', ':Telescope find_files<CR>') -- Быстрый поиск файлов
vim.keymap.set('n', '<leader>g', ':Telescope live_grep<CR>')  -- Поиск текста
vim.keymap.set('n', '<leader>w', ':w<CR>')                   -- Сохранить файл
vim.keymap.set('n', '<leader>q', ':q<CR>')                   -- Выйти из файла
vim.api.nvim_set_keymap(
  'n',
  '<A-e>',
  ':w<CR>:terminal g++ % -o %:r && kitty -e ./%:r 2>/dev/null<CR><C-\\><C-n><CR>:buffer #<CR>',
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  'n',
  '<A-d>',
  ':w<CR>:terminal g++ -g % -o %:r && kitty -e gdb ./%:r<CR><C-\\><C-n><CR>:buffer #<CR>',
  { noremap = true, silent = true }
)

vim.opt.relativenumber = true
vim.keymap.set("n", "<A-n>", function()
  if vim.opt.relativenumber:get() then
    -- Если включена относительная нумерация, переключиться на обычную
  vim.opt.relativenumber = false  
  vim.opt.number = true
  else
    -- Если включена только обычная нумерация, включить гибридную
    vim.opt.relativenumber = true
  end
end, { noremap = true, silent = true })

