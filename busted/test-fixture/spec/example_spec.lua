describe("the busted action", function()
  it("runs the suite inside Neovim via nlua", function()
    -- The `vim` global only exists when the interpreter is Neovim, so this
    -- proves the action wired nlua up to the nvim it found on PATH.
    assert.is_not_nil(vim)
    assert.is_not_nil(vim.fn)
    assert.is_function(vim.api.nvim_get_current_buf)
  end)

  it("can execute Vimscript through the running Neovim", function()
    assert.are.equal(3, vim.fn.eval("1 + 2"))
  end)
end)
