# typed: false
# frozen_string_literal: true

class MlxAgent < Formula
  include Language::Python::Virtualenv

  desc "Discover and serve local MLX models on Apple Silicon"
  homepage "https://github.com/cavi-ai/mlx-agent"
  url "https://files.pythonhosted.org/packages/6a/38/1018a2a4e8eead678a8296acb2aa65bcbeb6b8e064163fbc51d0a4759f87/mlx_agent-0.14.0.tar.gz"
  sha256 "2aa9da619f3a7815d639645f8ec0c700d40475c906a9c103e38d71bd241a571c"
  license "MIT"

  depends_on "python@3.15"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_equal "mlx-agent #{version}\n", shell_output("#{bin}/mlx-agent --version")
    request = {
      jsonrpc: "2.0",
      id:      1,
      method:  "initialize",
      params:  {
        protocolVersion: "2024-11-05",
        capabilities:    {},
        clientInfo:      { name: "homebrew-test", version: "1" },
      },
    }
    response = JSON.parse(pipe_output(bin/"mlx-agent-mcp", "#{request.to_json}\n", 0))
    assert_equal "mlx-agent", response.dig("result", "serverInfo", "name")
    assert_equal version.to_s, response.dig("result", "serverInfo", "version")
  end
end
