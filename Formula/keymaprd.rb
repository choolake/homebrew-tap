class Keymaprd < Formula
  desc "Remap Logitech MX Master mouse buttons to keyboard shortcuts on macOS"
  homepage "https://github.com/choolake/KeyMaprd"
  url "https://github.com/choolake/KeyMaprd/archive/refs/tags/v0.2.0.tar.gz"
  # Update sha256 after tagging: `curl -sL <url> | shasum -a 256`
  #curl -sL https://github.com/choolake/KeyMaprd/archive/refs/tags/v0.2.0.tar.gz | shasum -a 256`
  sha256 "5ae290739e2a7c78c2adc2f419157db3b801b94505894a139ce44f961b8c9875"
  license "MIT"
  head "https://github.com/choolake/KeyMaprd.git", branch: "main"

  depends_on "go" => :build
  depends_on :macos

  def install
    system "go", "build", "-o", bin/"keymaprd", "./cmd/keymaprd/"
    # Install example config so users can copy it to get started.
    # Available at: #{HOMEBREW_PREFIX}/share/keymaprd/config.example.json
    (share/"keymaprd").install "config.example.json"
  end

  def caveats
    <<~EOS
      To start keymaprd automatically at login:
        keymaprd install

      keymaprd requires Accessibility access to capture mouse buttons.
      Grant it in System Settings → Privacy & Security → Accessibility.

      Config file location:
        ~/.config/keymaprd/config.json

      Copy the example config to get started:
        mkdir -p ~/.config/keymaprd
        cp #{HOMEBREW_PREFIX}/share/keymaprd/config.example.json ~/.config/keymaprd/config.json
    EOS
  end

  test do
    assert_match "keymaprd v", shell_output("#{bin}/keymaprd --version")
  end
end
