# PCGrid proof-of-concept download bundle

This bundle carries the already-built x86-64 Linux worker USB image and source.
The repository is being used as a temporary delivery option because the chat
artifact viewer could not retrieve downloads. It is not a public-job release.

## On Windows

1. Download the ZIP for this branch and extract the complete ZIP to a folder.
2. Check that all 17 `pcgrid-iso.partNNN.bin` files are present.
3. Double-click `assemble-iso.cmd`. It uses Windows COPY and PowerShell, needs
   no administrator access, installs nothing, and makes no network requests.
4. Wait for SUCCESS. The helper verifies the complete ISO SHA-256 before naming
   the output `pcgrid-live-amd64.iso`; it refuses to overwrite an existing ISO.
5. Follow the USB-writing and HP setup instructions inside `pcgrid-source.zip`.

Allow at least 2.5 GB free space for extracting and reconstructing, in addition
to the downloaded ZIP itself. The downloaded ZIP is about 1.1 GB. The ISO is
split into 64 MiB pieces to stay below GitHub's per-file limit; the pieces alone
cannot be written to a boot USB. All pieces must be from this same bundle.

The complete ISO is 1,083,064,320 bytes with SHA-256:
`50acf472a49f3b944bcb8b9fcdd0994dbc0305c4850159b5595a8f7c3d09a986`.
`SHA256SUMS` records the source ZIP and individual part hashes.

## Current validation and limits

The application passed 76 unit tests and real CPU Docker integration checks.
The exact ISO passed BIOS/UEFI QEMU USB boots, responding network-service checks,
an offline restricted-container job, and simulated internal-disk preservation.
The split pieces were independently reread in order and verified against the
original ISO hash. The Windows helper has not yet run on physical Windows.

Physical HP boot, Wi-Fi, AC reporting and RTX 3050 CUDA execution remain untested.
Intel/AMD compute acceleration, hard GPU power/VRAM limits, public-job isolation,
a public marketplace and production security review remain unfinished.
Use trusted experimental jobs only. Do not put arbitrary public code on a
primary laptop. Keep worker and coordinator credential files private.
