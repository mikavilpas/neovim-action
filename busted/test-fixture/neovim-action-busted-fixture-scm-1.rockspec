-- Minimal rockspec used only to exercise the `busted` action in CI.
-- `luarocks test` discovers this rockspec, installs the test dependencies, and
-- runs the busted suite under Neovim (via nlua, configured in .busted).
rockspec_format = "3.0"
package = "neovim-action-busted-fixture"
version = "scm-1"
source = {
  url = "git+https://github.com/mikavilpas/neovim-action.git",
}
description = {
  summary = "CI fixture exercising the busted action.",
}
dependencies = {
  "lua 5.1",
}
test_dependencies = {
  "busted",
  "nlua",
}
test = {
  type = "busted",
}
build = {
  type = "builtin",
  modules = {},
}
