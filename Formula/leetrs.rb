class Leetrs < Formula
  desc "A command-line tool to interact with LeetCode."
  homepage "https://github.com/shadowmkj/leetrs"
  version "1.0.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.6/leetrs-aarch64-apple-darwin.tar.xz"
      sha256 "057e1dfbf48fff09fd48399ebb1d3ef2cbbc920e7dd0386216a30b797c64a368"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.6/leetrs-x86_64-apple-darwin.tar.xz"
      sha256 "6ede47d0ab440071021c8b685eab3eaf62c82b9a8d135347bc9f043dd767b43c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.6/leetrs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "55af0845e40b5936b23216152a069523ffbf962f77537e73f355eca9df4d4a45"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.6/leetrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "67f466789fd6e2de13044889c0cb76a8a9ab0533088e9d595f86fc0ec82f6bd6"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "leetrs" if OS.mac? && Hardware::CPU.arm?
    bin.install "leetrs" if OS.mac? && Hardware::CPU.intel?
    bin.install "leetrs" if OS.linux? && Hardware::CPU.arm?
    bin.install "leetrs" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
