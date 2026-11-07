# typed: false
# frozen_string_literal: true

class MlxAgent < Formula
  include Language::Python::Virtualenv

  desc "Discover and serve local MLX models on Apple Silicon"
  homepage "https://github.com/cavi-ai/mlx-agent"
  url "https://files.pythonhosted.org/packages/e2/9a/1ef53594afcefc088dbf3e4e27d03439952cc5559c2f2a5c8201fdc36226/mlx_agent-0.12.0.tar.gz"
  sha256 "46607b40163792033039474e18845aa6e30206ccd147be085a450bc489f0e891"
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
