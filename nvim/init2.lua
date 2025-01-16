-- Инициализация Packer
require('packer').startup(function()
  -- Менеджер плагинов
  use 'wbthomason/packer.nvim'

  -- Пример плагинов:
  use 'nvim-treesitter/nvim-treesitter' -- Улучшенный синтаксис
  use 'nvim-lualine/lualine.nvim' -- Статусная линия
  use 'nvim-telescope/telescope.nvim' -- Поиск файлов и текста
  use 'neovim/nvim-lspconfig' -- Настройка LSP
  use 'hrsh7th/nvim-cmp' -- Автодополнение
  use 'nvim-tree/nvim-tree.lua' -- Файловый менеджер
  use 'neovim/nvim-lspconfig'            -- Настройка LSP
use 'williamboman/mason.nvim'          -- Менеджер LSP, линтеров, форматтеров
use 'williamboman/mason-lspconfig.nvim'
use 'hrsh7th/nvim-cmp'                 -- Автодополнение
use 'hrsh7th/cmp-nvim-lsp'             -- Источник данных для nvim-cmp
use 'hrsh7th/cmp-buffer'               -- Автодополнение для буфера
use 'hrsh7th/cmp-path'                 -- Автодополнение путей
use 'L3MON4D3/LuaSnip'                 -- Сниппеты
use 'saadparwaiz1/cmp_luasnip'         -- Источник сниппетов для nvim-cmp
use 'nvim-treesitter/nvim-treesitter'  -- Подсветка синтаксиса
use 'nvim-lualine/lualine.nvim'        -- Статусная строка
use 'nvim-tree/nvim-tree.lua'          -- Файловый менеджер
use 'mfussenegger/nvim-dap'            -- Отладка

  require('lualine').setup()
  require('nvim-tree').setup()
  vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>') -- Горячая клавиша
  use 'folke/tokyonight.nvim'  -- Добавьте в Packer
  vim.cmd[[colorscheme tokyonight]]
  -- Быстрое сохранение файла
  vim.keymap.set('n', '<leader>w', ':w<CR>')
  -- Закрыть файл
  vim.keymap.set('n', '<leader>q', ':q<CR>')
  -- Автоматически открывать NvimTree при запуске без файлов
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if #vim.fn.argv() == 0 then
      require("nvim-tree.api").tree.open()
    end
  end,
})
require('lualine').setup {
  options = {
    theme = 'tokyonight'
  }
}

end)

