{
  cli = {
    version = "0.162.1";
    sources = {
      x86_64-linux = {
        target = "x86_64-unknown-linux-musl";
        hash = "sha256-pnb1ciquDYbL43ZDMvCOqx/didwKMAs61P+/SGEfo+M=";
      };
      aarch64-linux = {
        target = "aarch64-unknown-linux-musl";
        hash = "sha256-U6nOC5S+snpj/esvdwTZUZnheziYqjO2BGGhqTrA2Is=";
      };
    };
  };

  desktop = {
    version = "26.1007.71326";
    sources = {
      x86_64-linux = {
        arch = "amd64";
        hash = "sha256-DgBrSTFxL1qQ1M0ElyxuC1M87c39srUZRtW5NnRx9VY=";
      };
      aarch64-linux = {
        arch = "arm64";
        hash = "sha256-2fvYVKFSLtsrU8dVo+pez6Z7P4wDUxNAW1CWckLvugo=";
      };
    };
  };
}
