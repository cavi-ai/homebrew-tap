# typed: false
# frozen_string_literal: true

class MlxAgent < Formula
  include Language::Python::Virtualenv

  desc "Discover and serve local MLX models on Apple Silicon"
  homepage "https://github.com/cavi-ai/mlx-agent"
  url "https://files.pythonhosted.org/packages/a4/1d/77c07fb1d249b050453491d2b590dc17b8c1417337a67fa1dfd14d6d7b99/mlx_agent-0.16.0.tar.gz"
  sha256 "686ac353a1ec0c676ef99342f5e88db2022592a7fc3657c12f65a4724af9ecad"
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
