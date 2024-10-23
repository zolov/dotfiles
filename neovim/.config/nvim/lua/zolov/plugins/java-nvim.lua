return {
  "nvim-java/nvim-java",
  config = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          jdtls = {
            settings = {
              java = {
                configuration = {
                  runtimes = {
                    {
                      name = "Java-23",
                      path = "~/.sdkman/candidates/java/21.0.4-tem",
                    },
                    {
                      name = "Java-17",
                      path = "~/.sdkman/candidates/java/17.0.12-oracle",
                    },
                  },
                },
              },
            },
          },
        },
        setup = {
          jdtls = function()
            require("java").setup({
              root_markers = {
                "settings.gradle",
                "settings.gradle.kts",
                "pom.xml",
                "build.gradle",
                "mvnw",
                "gradlew",
                "build.gradle",
                "build.gradle.kts",
              },
            })
          end,
        },
      },
    },
  },
}

