class Leetrs < Formula
  desc "A command-line tool to interact with LeetCode."
  homepage "https://github.com/shadowmkj/leetrs"
  version "1.0.18"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.18/leetrs-aarch64-apple-darwin.tar.xz"
      sha256 "16be8154e57636072ea959ffcbe84d5df69116f5dd7d096c81c74ef20caccd09"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.18/leetrs-x86_64-apple-darwin.tar.xz"
      sha256 "c56fe968200a7e530baf6219acad02c3cc7a8c1109c452029a5ade52ceca6c7b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.18/leetrs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0fe0ae89e2a1e2c1612bb22e6b21e0d9c824a097b5a0b18ce6a434ba24f45623"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.18/leetrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "adccc4f3b3a46c5c5de888f41019ded2302e2ae7969745639adf0e370c359271"
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
