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

  it(
    "can load a rockspec runtime dependency installed by the action",
    function()
      -- `inspect` is declared in the rockspec's `dependencies` and is not a
      -- busted dependency, so loading and using it proves the action installed
      -- the project's own dependencies before running the tests.
      local inspect = require("inspect")
      assert.is_not_nil(inspect)
      assert.are.equal("string", type(inspect({ 1, 2, 3 })))
    end
  )
end)
