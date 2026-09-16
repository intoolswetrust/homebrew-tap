class Jsignpdf < Formula
  desc "Add digital signatures to PDF documents (GUI and CLI)"
  homepage "https://github.com/intoolswetrust/jsignpdf"
  url "https://github.com/intoolswetrust/jsignpdf/releases/download/JSignPdf_3_2_0/jsignpdf-3.2.0-full.zip"
  sha256 "7384e29bbf730af120cb36281cee73c8aa8c8bd155526f0eb7b1c44b629635bd"
  license any_of: ["MPL-2.0", "LGPL-2.1-only"]

  livecheck do
    url :stable
    strategy :github_latest do |json|
      json["tag_name"]&.sub(/^JSignPdf_/, "")&.tr("_", ".")
    end
  end

  depends_on "openjdk@21"

  def install
    libexec.install Dir["*"]

    # The full ZIP ships every JavaFX classifier under lib/javafx/; Bootstrap
    # loads only the one matching the running platform, so drop the rest.
    fx_dir = libexec/"lib/javafx"
    if fx_dir.directory?
      classifier = if OS.mac?
        Hardware::CPU.arm? ? "mac-aarch64" : "mac"
      else
        Hardware::CPU.arm? ? "linux-aarch64" : "linux"
      end
      fx_dir.each_child do |jar|
        jar.unlink unless jar.basename.to_s.end_with?("-#{classifier}.jar")
      end
    end

    rm(libexec/"bin/jsignpdf.cmd")
    chmod 0755, libexec/"bin/jsignpdf.sh"

    (bin/"jsignpdf").write_env_script libexec/"bin/jsignpdf.sh",
                                      Language::Java.overridable_java_home_env("21")

    doc.install libexec/"docs/JSignPdf.pdf" if (libexec/"docs/JSignPdf.pdf").exist?
    pkgshare.install libexec/"demo" if (libexec/"demo").directory?
  end

  def caveats
    <<~EOS
      Run `jsignpdf` with no arguments to open the desktop UI, or with options
      for batch signing (`jsignpdf --help`).

      Sample keystore and PDF for trying it out:
        #{opt_pkgshare}/demo
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/jsignpdf --version")

    cp pkgshare/"demo/service-agreement.pdf", testpath/"in.pdf"
    system bin/"jsignpdf", "-kst", "PKCS12",
           "-ksf", pkgshare/"demo/jsmith.p12",
           "-ksp", "123456",
           testpath/"in.pdf"
    assert_path_exists testpath/"in_signed.pdf"
  end
end
