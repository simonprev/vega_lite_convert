defmodule VegaLiteConvert.MixProject do
  use Mix.Project

  @force_build? System.get_env("VEGA_LITE_CONVERT_BUILD") in ["1", "true"]

  @version "0.3.0"

  def project do
    [
      app: :vega_lite_convert,
      version: @version,
      package: package(),
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [extra_applications: []]
  end

  defp aliases do
    [
      "rust.lint": [
        "cmd cargo clippy --manifest-path=native/vega_lite_convert/Cargo.toml -- -Dwarnings"
      ],
      "rust.fmt": ["cmd cargo fmt --manifest-path=native/vega_lite_convert/Cargo.toml --all"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler, "~> 0.27", optional: not @force_build?},
      {:rustler_precompiled, "~> 0.5"},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Simon Prévost"],
      licenses: ["BSD-3-Clause"],
      links: %{github: "https://github.com/simonprev/vega_lite_convert"},
      files: [
        "dist",
        "lib",
        "mix.exs",
        "README.md",
        "native/vega_lite_convert/.cargo",
        "native/vega_lite_convert/Cargo*",
        "native/vega_lite_convert/src",
        "checksum-*.exs"
      ]
    ]
  end
end
