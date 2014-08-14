require "formula"

class Volatility < Formula
  homepage "https://github.com/volatilityfoundation/volatility"
  url "http://downloads.volatilityfoundation.org/releases/2.4/volatility-2.4.tar.gz"
  sha1 "77ae1443062a5103c63377aee6170d6e09ca6354"
  head "https://github.com/volatilityfoundation/volatility.git"

  depends_on :python
  depends_on 'yara'

  resource 'distorm3' do
    url "https://distorm.googlecode.com/files/distorm3.zip"
    sha1 "774acbb1d734bc83d4c487185dbe9acd51c61851"
  end

  resource 'pycrypto' do
    url "https://github.com/dlitz/pycrypto/archive/v2.6.1.tar.gz"
    sha1 "9b7fb7fd9c59624f2db7c1d98f62adde1b85f4c5"
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
    ENV["PYTHONPATH"] = lib+"python2.7/site-packages"
    ENV.prepend_create_path 'PYTHONPATH', libexec+'lib/python2.7/site-packages'

    res = %w(distorm3 pycrypto PIL openpyxl)

    res.each do |r|
      unless package_installed?(python, r)
        resource(r).stage do
          system "python", "setup.py", "build"
          system "python", "setup.py", "install", "--prefix=#{libexec}"
        end
      end
    end

    system "python", "setup.py", "install", "--prefix=#{prefix}",
               '--single-version-externally-managed', '--record=installed.txt'

    bin.env_script_all_files(libexec+'bin', :PYTHONPATH => ENV['PYTHONPATH'])
  end

  test do
    system "#{bin}/vol.py", "--info"
  end
end
