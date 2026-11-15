{
  cli = {
    version = "0.169.0";
    sources = {
      x86_64-linux = {
        target = "x86_64-unknown-linux-musl";
        hash = "sha256-O47QkRScxjpZBGufCUvPohzbTdoV7eRBzjabzuSnG6A=";
      };
      aarch64-linux = {
        target = "aarch64-unknown-linux-musl";
        hash = "sha256-yNC0qyqXxZW3CxBBLTbQ1UZNzvHh0yRrBz1IAXzfWk8=";
      };
      aarch64-darwin = {
        target = "aarch64-apple-darwin";
        hash = "sha256-iiMiYN96EsXoPgtLdlnhyNklm0GUJRe8AGjYq1XDZGE=";
      };
    };
  };

  desktop = {
    versions = {
      linux = "26.1111.21308";
      darwin = "26.1111.21308";
    };
    sources = {
      x86_64-linux = {
        arch = "amd64";
        hash = "sha256-S0Q7xVc1ChsZO8LxuuIHyeo8n7XZT3yUpdPbqotVI1I=";
      };
      aarch64-linux = {
        arch = "arm64";
        hash = "sha256-xcWqCQlo73oosnyu09AzdIidfIJQdogU60yuXZudmiU=";
      };
      aarch64-darwin = {
        hash = "sha256-gYbjm7FmGZ9kiXnH4mwUiRkIkF2j9FS45vwsI6c5uuc=";
      };
    };
  };
}
