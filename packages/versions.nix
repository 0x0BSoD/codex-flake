{
  cli = {
    version = "0.170.0";
    sources = {
      x86_64-linux = {
        target = "x86_64-unknown-linux-musl";
        hash = "sha256-p3/4e+e6gJ1xVygnCnj1zjUn3AdSlBbR74kpuQuEdes=";
      };
      aarch64-linux = {
        target = "aarch64-unknown-linux-musl";
        hash = "sha256-P34a44xP4nMi4IK4VejuyTbQj6U41itxwH4qU/NOiEc=";
      };
      aarch64-darwin = {
        target = "aarch64-apple-darwin";
        hash = "sha256-l1UkvxOu3RsSLY0OAMCe5nCRuPaIwLN0lD27PPIseJM=";
      };
    };
  };

  desktop = {
    versions = {
      linux = "26.1111.71704";
      darwin = "26.1111.71704";
    };
    sources = {
      x86_64-linux = {
        arch = "amd64";
        hash = "sha256-Ae73x3yDX34a+5K6HCkXikwZ1sZlc73TuGUg4qv4BqQ=";
      };
      aarch64-linux = {
        arch = "arm64";
        hash = "sha256-8FUN7h+ZEn01etdgrvc5xVfUm9Z3KNLxBdAKekeA90A=";
      };
      aarch64-darwin = {
        hash = "sha256-DHkNirWEJVOf4dhEBmrLi4BBWqGaXEbYlAmBURLoE00=";
      };
    };
  };
}
