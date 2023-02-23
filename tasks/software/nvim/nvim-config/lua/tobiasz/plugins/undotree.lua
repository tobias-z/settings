return {
  "mbbill/undotree",
  config = function ()
    VMap.nmap("<leader>u", "<cmd>UndotreeShow | UndotreeFocus<CR>")
  end,
}
