{
  cli = {
    version = "0.165.0";
    sources = {
      x86_64-linux = {
        target = "x86_64-unknown-linux-musl";
        hash = "sha256-6XxEY9fxRmkqlV17DhyM9I+XzU1hbNRcXcqy6Nl0MxY=";
      };
      aarch64-linux = {
        target = "aarch64-unknown-linux-musl";
        hash = "sha256-yLKET971dJhXLblgNErujINs6fdcIDN52gqcOjNPw7c=";
      };
      aarch64-darwin = {
        target = "aarch64-apple-darwin";
        hash = "sha256-NNEjhNkPjgmwuauqvyoKwCpSCTsTFQSuryghB/VKRLI=";
      };
    };
  };

  desktop = {
    versions = {
      linux = "26.1023.51421";
      darwin = "26.1023.51421";
    };
    sources = {
      x86_64-linux = {
        arch = "amd64";
        hash = "sha256-RITcK1T8CXi+sjuNjXF0lOTgtPvqsKh2c5EF5QtE3lo=";
      };
      aarch64-linux = {
        arch = "arm64";
        hash = "sha256-50eNhPKTjdNz+mHFKw8gCwfWEOSJRwUr2K10dpt/0/s=";
      };
      aarch64-darwin = {
        hash = "sha256-dkKyrCp6B0L5oYAKu6Fe74P3fmnYk7551kZ88h5eERA=";
      };
    };
  };
}
