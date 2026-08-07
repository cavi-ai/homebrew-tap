# cavi-ai/homebrew-tap

Homebrew tap for cavi-ai releases. Brew strips the `homebrew-` prefix, so this
repository is addressed as `cavi-ai/tap`.

```bash
brew tap cavi-ai/tap
brew install cavi-ai/tap/bobby-browser
```

## Formulae

| Formula | Installs | Upstream |
|---|---|---|
| `bobby-browser` | `bobby`, `mcp-gateway`, `acp-gateway` | [cavi-ai/bobby-browser](https://github.com/cavi-ai/bobby-browser) |

Formulae here pull prebuilt binaries from the upstream GitHub Release and carry
the sha256 of each platform tarball, so brew verifies every download.

## Updating a formula

Bump `version`, then replace all four digests with the published assets':

```bash
for a in macos-arm64 macos-x64 linux-arm64 linux-x64; do
  curl -fsSL "https://github.com/cavi-ai/bobby-browser/releases/download/v$VERSION/bobby-browser-$VERSION-$a.tar.gz" \
    | shasum -a 256
done
```

The upstream repository keeps `Formula/bobby-browser.rb` as the source of
truth; this tap carries a copy of the released version.
