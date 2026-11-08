{
  cli = {
    version = "0.167.0";
    sources = {
      x86_64-linux = {
        target = "x86_64-unknown-linux-musl";
        hash = "sha256-O7916D3mtYrtKPLPbjOtQj7DH9RwChRXuUvlV+pafG4=";
      };
      aarch64-linux = {
        target = "aarch64-unknown-linux-musl";
        hash = "sha256-DeJh7PHn8wKKeVLwP8ogk/dJJ304WQt4uzL4VndWu7c=";
      };
      aarch64-darwin = {
        target = "aarch64-apple-darwin";
        hash = "sha256-r0XtRdlA15mICWIsHAKW0wmO19f61pUoRCLCKL1FRRc=";
      };
    };
  };

  desktop = {
    versions = {
      linux = "26.1103.32239";
      darwin = "26.1103.41825";
    };
    sources = {
      x86_64-linux = {
        arch = "amd64";
        hash = "sha256-GMEIgI6ixS+42/ktM2LSd0HjOCxYkb1K6QOptXgTZO8=";
      };
      aarch64-linux = {
        arch = "arm64";
        hash = "sha256-mB/4FcyMnP0C6MSdds2aTmwVEgleSHwHU2wchtUqZgI=";
      };
      aarch64-darwin = {
        hash = "sha256-CzDOXKx4eJO/V0tUmx0yzzY/ITApNVOKzTacZo3y/R8=";
      };
    };
  };
}
