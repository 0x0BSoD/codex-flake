{
  cli = {
    version = "0.167.1";
    sources = {
      x86_64-linux = {
        target = "x86_64-unknown-linux-musl";
        hash = "sha256-qUXfPfg+hJ3Xt0eH4n+KRZwZRrDjr+Pcju+KjRhF/U8=";
      };
      aarch64-linux = {
        target = "aarch64-unknown-linux-musl";
        hash = "sha256-7z4UQ6d5XVlvFgGlM9ciWhAwSI1gyWWvHwYQq5WIkDE=";
      };
      aarch64-darwin = {
        target = "aarch64-apple-darwin";
        hash = "sha256-W8vFhmy8oZ+SmfeITps5ucy1RplpwXCx8tLNb8Sx7nI=";
      };
    };
  };

  desktop = {
    versions = {
      linux = "26.1103.60933";
      darwin = "26.1103.60933";
    };
    sources = {
      x86_64-linux = {
        arch = "amd64";
        hash = "sha256-B0bpuldRgvXb4yYXuCpkXrk61XyliOWpNYaVprZa7nE=";
      };
      aarch64-linux = {
        arch = "arm64";
        hash = "sha256-bbGahFWR1QnpuDywqOC0oi3uJ0SNIRwdH6ik+5LtzF0=";
      };
      aarch64-darwin = {
        hash = "sha256-HWced4Tg43n3KT68/qyCbCopdSTqgGzVXplAaNAZ44g=";
      };
    };
  };
}
