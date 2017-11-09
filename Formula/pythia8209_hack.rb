class Pythia8209Hack < Formula
  desc "Monte Carlo event generator"
  homepage "https://github.com/jdoss1789"
  url "https://github.com/jdoss1789/homebrew-hack/raw/master/Packages/pythia8209_hack.tgz"
  version "8.209"
  sha256 "152c190bf9da22b438593ae7eb77a751547a5d0eb3e87d7cc09ec2ea04385e76"

  depends_on "hepmc"
  depends_on "fastjet"
  depends_on "lhapdf"
  depends_on "boost"

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-shared
      --with-hepmc2=#{Formula["hepmc"].opt_prefix}
      --with-fastjet3=#{Formula["fastjet"].opt_prefix}
      --with-lhapdf6=#{Formula["lhapdf"].opt_prefix}
      --with-boost=#{Formula["boost"].opt_prefix}
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    ENV["PYTHIA8DATA"] = share/"Pythia8/xmldoc"

    cp_r share/"Pythia8/examples/.", testpath
    system "make", "main01"
    system "./main01"
    system "make", "main41"
    system "./main41"
  end
end