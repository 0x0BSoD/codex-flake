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
      linux = "26.1120.50957";
      darwin = "26.1120.50957";
    };
    sources = {
      x86_64-linux = {
        arch = "amd64";
        hash = "sha256-6Ks435bWBw/V1FgqYGSQY3coJDu1Kentrhmz8KbmZNI=";
      };
      aarch64-linux = {
        arch = "arm64";
        hash = "sha256-0RrbmhPSG8X1FIhZJCB68OhompeDKFUOOkOJWmlgPYk=";
      };
      aarch64-darwin = {
        hash = "sha256-LBZnH8qtUpGi9r4TXhKClh1TQmOcPbVVFKGvGogd3m8=";
      };
    };
  };
}
