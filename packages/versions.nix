{
  cli = {
    version = "0.164.0";
    sources = {
      x86_64-linux = {
        target = "x86_64-unknown-linux-musl";
        hash = "sha256-PsVQUxCWCNUDj35QdQ99Jfdo39dA/vBxqnEOJVm2Oqw=";
      };
      aarch64-linux = {
        target = "aarch64-unknown-linux-musl";
        hash = "sha256-WRit1sfpzx4Uqa8bTA9L8dJKQ5A/qsJt9dxMAZ6pG9U=";
      };
      aarch64-darwin = {
        target = "aarch64-apple-darwin";
        hash = "sha256-3ZnpCSJwaRpnvd574ErCg96p2o6Gy941bCzIUaeSBfo=";
      };
    };
  };

  desktop = {
    version = "26.1013.40934";
    sources = {
      x86_64-linux = {
        arch = "amd64";
        hash = "sha256-PKWef5pmQbni+5rWgGg3hLWrgCb/dBj7ISoOvl3zodc=";
      };
      aarch64-linux = {
        arch = "arm64";
        hash = "sha256-mrLLuvM86+qh4G61yreBKJNvknoNl78A5AaU5fMcYps=";
      };
      aarch64-darwin = {
        hash = "sha256-FDicnpvXhxox44AIn4vFTgfGJwUPZ27NqlZ7JpKfehs=";
      };
    };
  };
}
