# typed: false
# frozen_string_literal: true

class MlxAgent < Formula
  include Language::Python::Virtualenv

  desc "Discover and serve local MLX models on Apple Silicon"
  homepage "https://github.com/cavi-ai/mlx-agent"
  url "https://files.pythonhosted.org/packages/2c/61/6effb857aab09212d9437d8c888b9065e5679c114084e2135b30a3817223/mlx_agent-0.15.0.tar.gz"
  sha256 "95308dcad2b836f4f6fda160a6c890b97dcbb265c4377fb78f10438feff2aa97"
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
