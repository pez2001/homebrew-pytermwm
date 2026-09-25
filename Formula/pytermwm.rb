class Pytermwm < Formula
  include Language::Python::Virtualenv

  desc "Terminal window manager in pure Python, driven by keys, CLI, HTTP and MCP"
  homepage "https://github.com/pez2001/pytermwm"
  url "https://files.pythonhosted.org/packages/50/0a/c45d012673d6274dcca0c5c4d995f3820550b859dc365915dd989de8e7a4/pytermwm-1.0.1.tar.gz"
  sha256 "c546818e81f97e9cc67bf31c166cf435309395aad7035142b3471ecaf44efaca"
  license "LGPL-2.1-or-later"

  depends_on "libyaml"
  depends_on "python@3.13"

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "pytermwm #{version}", shell_output("#{bin}/pytermwm version")
    assert_match "pytermwm #{version}", shell_output("#{bin}/ptw version")
    # a real session: start it, run a command in a window, read it back, end it
    ENV["PYTERMWM_RUNTIME_DIR"] = testpath/"run"
    ENV["PYTERMWM_STATE_DIR"] = testpath/"state"
    ENV["HOME"] = testpath
    system bin/"pytermwm", "-s", "brewtest", "start"
    begin
      system bin/"pytermwm", "-s", "brewtest", "run", "--name", "t", "--", "sh", "-c", "echo brew-ok; sleep 30"
      system bin/"pytermwm", "-s", "brewtest", "wait", "-t", "t", "brew-ok", "--timeout", "10"
      assert_match "brew-ok", shell_output("#{bin}/pytermwm -s brewtest capture -t t")
    ensure
      system bin/"pytermwm", "-s", "brewtest", "kill"
    end
  end
end
