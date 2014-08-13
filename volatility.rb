require "formula"

class Volatility < Formula
  homepage "https://github.com/volatilityfoundation/volatility"
  url "http://downloads.volatilityfoundation.org/releases/2.4/volatility-2.4.tar.gz"
  sha1 "77ae1443062a5103c63377aee6170d6e09ca6354"
  head "https://github.com/volatilityfoundation/volatility.git"

  # depends_on :python
  depends_on 'yara'
  # depends_on 'pillow'

  resource 'distorm3' do
    url "https://distorm.googlecode.com/files/distorm3.zip"
    sha1 "774acbb1d734bc83d4c487185dbe9acd51c61851"
  end

  resource 'pycrypto' do
    url "https://github.com/dlitz/pycrypto/archive/v2.7a1.tar.gz"
    sha1 "077feba65e9018df81d11e1a9f703a8b03fc8ec5"
  end

  resource 'PIL' do
    url "http://effbot.org/downloads/Imaging-1.1.7.tar.gz"
    sha1 "76c37504251171fda8da8e63ecb8bc42a69a5c81"
  end

  resource 'openpyxl' do
    url "https://pypi.python.org/packages/source/o/openpyxl/openpyxl-2.0.5.tar.gz"
    sha1 "8a2c7de46719edfcd2d551ea29fe0409dc3c2763"
  end

  def package_installed? python, module_name
    quiet_system python, "-c", "import #{module_name}"
  end

  def install
    ENV['PYTHON_PATH'] = which 'python'
    system "python setup.py install --prefix=#{prefix}"

    # Language::Python.each_python(build) do |python, version|
    #
    #   resource("distorm3").stage do
    #     system python, "setup.py", "build", "--prefix=#{prefix}"
    #     system python, "setup.py", "install", "--prefix=#{prefix}"
    #   end unless package_installed? python, "distorm3"
    #
    #   resource("pycrypto").stage do
    #     system python, "setup.py", "install", "--prefix=#{prefix}"
    #   end unless package_installed? python, "pycrypto"
    #
    #   resource("PIL").stage do
    #     system python, "setup.py", "install", "--prefix=#{prefix}"
    #   end unless package_installed? python, "PIL"
    #
    #   resource("openpyxl").stage do
    #     system python, "setup.py", "install", "--prefix=#{prefix}"
    #   end unless package_installed? python, "openpyxl"
    #
    #   #system python, "setup.py", "build"
    #   system python, "setup.py", "install", "--prefix=#{prefix}"
    # end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test volatility`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "true"
  end
end
