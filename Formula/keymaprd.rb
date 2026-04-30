class Keymaprd < Formula
  desc "Remap Logitech MX Master mouse buttons to keyboard shortcuts on macOS"
  homepage "https://github.com/choolake/KeyMaprd"
  url "https://github.com/choolake/KeyMaprd/archive/refs/tags/v0.3.0.tar.gz"
  # Update sha256 after tagging: `curl -sL <url> | shasum -a 256`
  #curl -sL https://github.com/choolake/KeyMaprd/archive/refs/tags/v0.2.0.tar.gz | shasum -a 256`
  sha256 "f27ca3b2c0ae048b870a9ad7129b29ed208698caf0b5cebeeea04f36c2e7c2f1"
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
      keymaprd requires Accessibility access to capture mouse buttons.
      Grant it in System Settings → Privacy & Security → Accessibility.

      Getting started:
        keymaprd        ← first run launches an interactive setup wizard
        keymaprd setup  ← re-run the wizard any time to change mappings
    EOS
  end

  test do
    assert_match "keymaprd v", shell_output("#{bin}/keymaprd --version")
  end
end
