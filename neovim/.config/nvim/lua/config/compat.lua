if vim.lsp.get_clients and vim.lsp.buf_get_clients then
    vim.lsp.buf_get_clients = function(bufnr)
        return vim.lsp.get_clients({ bufnr = bufnr or 0 })
    end
end
