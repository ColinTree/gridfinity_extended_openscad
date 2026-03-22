# AGENTS.md

## Cursor Cloud specific instructions

This is an OpenSCAD 3D modeling project (Gridfinity Extended). There is no traditional build system, web server, or package manager. The two key tools are **OpenSCAD** (developer snapshot) and **PowerShell Core** (`pwsh`).

### Installed tools

- **OpenSCAD 2026.02.13** (developer snapshot): extracted AppImage at `/opt/openscad/`, symlinked to `/usr/local/bin/openscad`.
- **PowerShell Core 7.6**: installed via Microsoft apt repo, available as `pwsh`.
- **xvfb-run**: pre-installed; required to run OpenSCAD in headless mode on Linux.

### Running OpenSCAD (headless)

OpenSCAD requires a display. Use `xvfb-run` to provide a virtual framebuffer:

```bash
xvfb-run openscad --export-format binstl --enable textmetrics --backend Manifold -o output.stl input.scad
```

A wrapper script at `/home/ubuntu/bin/openscad-wrapper` bundles `xvfb-run` so PowerShell test scripts can invoke OpenSCAD transparently:

```bash
openscad-wrapper --version
```

### Running tests

The CI test suite (root-level `.scad` files only):

```bash
pwsh ./scripts/test-render.ps1 -OpenScadPath /home/ubuntu/bin/openscad-wrapper
```

Full test including `combined/` and `demos/` directories:

```bash
cd scripts && pwsh ./test-render-all.ps1 -OpenScadPath /home/ubuntu/bin/openscad-wrapper
```

Note: `test-render-all.ps1` may report warnings for some `demos/` files — these are known and are not tested in CI.

### Rendering a preview image

```bash
xvfb-run openscad --enable textmetrics --backend Manifold --imgsize 800,600 -o preview.png input.scad
```

### Key gotchas

- The OpenSCAD AppImage cannot use FUSE in this environment; it must be pre-extracted (already done at `/opt/openscad/`).
- The `test-render.ps1` script uses `-o NUL` (Windows null device) by default, which works fine on Linux because it just creates a file named `NUL`.
- Always pass `-OpenScadPath /home/ubuntu/bin/openscad-wrapper` to the PowerShell test scripts to ensure `xvfb-run` is used.
