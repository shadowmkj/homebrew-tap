class Leetrs < Formula
  desc "A command-line tool to interact with LeetCode."
  homepage "https://github.com/shadowmkj/leetrs"
  version "1.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.2/leetrs-aarch64-apple-darwin.tar.xz"
      sha256 "5a736d5c45a65c2a572ba6459786586c1d2cba479f265e3f835394e36deb4195"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.2/leetrs-x86_64-apple-darwin.tar.xz"
      sha256 "e3d242d47d858658e69eac6e712d6ad252b92fcfe0e359e8ab91941c8b114a55"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.2/leetrs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6a38cd4675c1efbfa02b5d61a23658d085a598e7109d5873686aabe21aedccd3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.2/leetrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "15af7deab65e3797e0dbfdc9c957db428467b7f25a3b147b7d6db59e136a8f36"
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
