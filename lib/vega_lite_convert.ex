defmodule VegaLiteConvert do
  @moduledoc false

  mix_config = Mix.Project.config()
  version = mix_config[:version]
  github_url = mix_config[:package][:links][:github]
  mode = if Mix.env() in [:dev, :test], do: :debug, else: :release

  use RustlerPrecompiled,
    otp_app: :vega_lite_convert,
    crate: :vega_lite_convert,
    version: version,
    base_url: "#{github_url}/releases/download/v#{version}",
    mode: mode,
    force_build: System.get_env("VEGA_LITE_CONVERT_BUILD") in ["1", "true"],
    targets: ~w(
        aarch64-apple-darwin
        aarch64-unknown-linux-gnu
        x86_64-apple-darwin
        x86_64-pc-windows-msvc
        x86_64-unknown-linux-gnu
      )

  def to_svg(_spec), do: :erlang.nif_error(:nif_not_loaded)
end
