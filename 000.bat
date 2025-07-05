@echo off
(for /R %%F in (*) do @echo %%~fF) > file_paths.txt