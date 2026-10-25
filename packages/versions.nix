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
    versions = {
      linux = "26.1021.22027";
      darwin = "26.1021.31345";
    };
    sources = {
      x86_64-linux = {
        arch = "amd64";
        hash = "sha256-6wgxxzTxVPk/jrzw4X0RjaDep9wXN9xhoecURDdb8ZA=";
      };
      aarch64-linux = {
        arch = "arm64";
        hash = "sha256-aN4exEBmhx5Bd7ocp5Pr7muiODl/E8eU5FsUlBwSYfs=";
      };
      aarch64-darwin = {
        hash = "sha256-KvzVjgSEp2R5zKIxdOCFEnqdnmNGa3VznraCWl/2E/Q=";
      };
    };
  };
}
