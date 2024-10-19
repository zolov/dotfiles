return {
  "artemave/workspace-diagnostics.nvim",
  setup = function(_, opts)
    require("zolov.config.utils").on_attach(function(client, buf)
      require("workspace-diagnostics").populate_workspace_diagnostics(client, buf)
      print("workspace!!!")
    end, nil)
  end,
}
