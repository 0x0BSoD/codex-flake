{
  cli = {
    version = "0.163.0";
    sources = {
      x86_64-linux = {
        target = "x86_64-unknown-linux-musl";
        hash = "sha256-WCZGxr8FYesN5UD3/IW5EhsAkagmvG6Wgwt/FyISIYI=";
      };
      aarch64-linux = {
        target = "aarch64-unknown-linux-musl";
        hash = "sha256-nY7PLRnT4YSHeYOQLWyF3kiziI3LcsOCqKDJdYRZJ/s=";
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
    };
  };
}
