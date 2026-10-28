class Leetrs < Formula
  desc "A command-line tool to interact with LeetCode."
  homepage "https://github.com/shadowmkj/leetrs"
  version "1.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.2.1/leetrs-aarch64-apple-darwin.tar.xz"
      sha256 "62b97c253658b06ae6ea3ecf514d581dd9c37b675e2e34e6bbec894f31eafb62"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.2.1/leetrs-x86_64-apple-darwin.tar.xz"
      sha256 "919d644da76b2c5a1cd4a969088bc6a23b33c60b9634489e58825a5899d91abd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.2.1/leetrs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c4427a363b718d80c937f611bab534d0447f898d3e3ce2ae065bd45523dfe087"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.2.1/leetrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dbc431707ed552ae6064d5a91d74b4b2dab2ec9f1932bf5269401804aa26b0df"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "leetrs"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "leetrs"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "leetrs"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "leetrs"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
