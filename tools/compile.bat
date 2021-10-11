@echo off

type "..\shared_magicbox.gsc" > "release.gsc"
Compiler.exe release.gsc
del /f release.gsc
ren "release-compiled.gsc" "release.gsc"
echo - Compiled release file.