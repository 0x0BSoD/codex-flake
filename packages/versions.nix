{
  cli = {
    version = "0.172.0";
    sources = {
      x86_64-linux = {
        target = "x86_64-unknown-linux-musl";
        hash = "sha256-Y+OwAGXtf2IWbQUi4X9mPLhmox2A0D5jNlSC7TSh2ZE=";
      };
      aarch64-linux = {
        target = "aarch64-unknown-linux-musl";
        hash = "sha256-+vF7gHGSfzM0aoBdyMtF3k4IwNdc8OXmjOzdyii4hh4=";
      };
      aarch64-darwin = {
        target = "aarch64-apple-darwin";
        hash = "sha256-CXABbUggmgnEA5E5Yp7Xm0oxxePYZOeSwENBnZj6ZGY=";
      };
    };
  };

  desktop = {
    versions = {
      linux = "26.1120.41243";
      darwin = "26.1120.41243";
    };
    sources = {
      x86_64-linux = {
        arch = "amd64";
        hash = "sha256-O6oedFpaP1n5F+kvJbnt8ShKAwa3Xx8uNgp2bfOLiyM=";
      };
      aarch64-linux = {
        arch = "arm64";
        hash = "sha256-cri5/y2qe8dQ+yFJzsdT9coGyu8hV1knd6RUdfQpLyc=";
      };
      aarch64-darwin = {
        hash = "sha256-74qtMUCeLuOZOp50DPPpTnni1yGeUPSK3qIhfUrPedQ=";
      };
    };
  };
}
