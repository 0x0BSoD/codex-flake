{
  cli = {
    version = "0.166.0";
    sources = {
      x86_64-linux = {
        target = "x86_64-unknown-linux-musl";
        hash = "sha256-HUSyi8SsmTfX01MiZLqmilB842SVag1Ou4VvMxze4lQ=";
      };
      aarch64-linux = {
        target = "aarch64-unknown-linux-musl";
        hash = "sha256-eCG3fdouYoP7H2PzFlF3onHaiDPoV89nPGyhyds7/MY=";
      };
      aarch64-darwin = {
        target = "aarch64-apple-darwin";
        hash = "sha256-VaRAy1eflwq+fHmrGB5UsOpMQZvpnzM7vYaO66ycIfA=";
      };
    };
  };

  desktop = {
    versions = {
      linux = "26.1027.51404";
      darwin = "26.1027.61615";
    };
    sources = {
      x86_64-linux = {
        arch = "amd64";
        hash = "sha256-RvHiLQKGmP6e2u/VhHrs4HxFCaMNNwnhBCIHGdjBKCI=";
      };
      aarch64-linux = {
        arch = "arm64";
        hash = "sha256-LCulzS9cE95fXZOl4WI/u2HqSzVWVx5fdDGlcPF/j+o=";
      };
      aarch64-darwin = {
        hash = "sha256-oi6B/55S5/MAbGV/8gBsA0mCh2paigArv5wA+/gwfyM=";
      };
    };
  };
}
