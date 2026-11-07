# cavi-ai/homebrew-tap

Homebrew tap for cavi-ai releases. Brew strips the `homebrew-` prefix, so this
repository is addressed as `cavi-ai/tap`.

```bash
brew tap cavi-ai/tap
brew install cavi-ai/tap/bobby-browser
brew install cavi-ai/tap/mlx-agent
```

## Formulae

| Formula | Installs | Upstream |
|---|---|---|
| `bobby-browser` | `bobby`, `mcp-gateway`, `acp-gateway` | [cavi-ai/bobby-browser](https://github.com/cavi-ai/bobby-browser) |
| `mcpeval` | `mcpeval`, `mcpeval-demo` | [cavi-ai/mcp-eval](https://github.com/cavi-ai/mcp-eval) |
| `mlx-agent` | `mlx-agent`, `mlx-agent-mcp` | [cavi-ai/mlx-agent](https://github.com/cavi-ai/mlx-agent) |

`bobby-browser` and `mcpeval` install checksummed binaries from GitHub Releases.
`mlx-agent` installs the CLI and MCP server from a checksummed PyPI source
distribution. Optional model runtimes are installed separately.

## Updating a formula

For `bobby-browser`, bump `version` and replace the four published-asset digests:

```bash
for a in macos-arm64 macos-x64 linux-arm64 linux-x64; do
  curl -fsSL "https://github.com/cavi-ai/bobby-browser/releases/download/v$VERSION/bobby-browser-$VERSION-$a.tar.gz" \
    | shasum -a 256
done
```

The upstream repository keeps `Formula/bobby-browser.rb` as the source of
truth; this tap carries a copy of the released version.

For `mlx-agent`, update the PyPI source URL and SHA-256 for the published version.
