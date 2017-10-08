@echo off
:: 
:: The Batchography book by Elias Bachaalany
::

	setlocal enabledelayedexpansion

	set FN=%TEMP%\evil.tmp
	call :extract-embedded-bin "%FN%"
	start %FN%
	goto :eof


:extract-embedded-bin <1=OutFileName>
	setlocal

	set MBEGIN=-1
	for /f "useback tokens=1 delims=: " %%a in (`findstr /B /N /C:"-----BEGIN CERTIFICATE-----" "%~f0"`) DO (
		set /a MBEGIN=%%a-1
	)

	if "%MBEGIN%"=="-1" (
		endlocal
		exit /b -1
	)

	:: Delete previous output files
	if exist "%~1.tmp" del "%~1.tmp"
	if exist "%~1" del "%~1"	

	for /f "useback skip=%MBEGIN% tokens=* delims=" %%a in ("%~f0") DO (
		echo %%a >>"%~1.tmp"
	)

	certutil -decode "%~1.tmp" "%~1" >nul 2>&1
	del "%~1.tmp"

	endlocal
	exit /b 0


-----BEGIN CERTIFICATE-----
TVqQAAMAAAAEAAAA//8AALgAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAsAAAAA4fug4AtAnNIbgBTM0hVGhpcyBwcm9ncmFtIGNhbm5v
dCBiZSBydW4gaW4gRE9TIG1vZGUuDQ0KJAAAAAAAAABdXG3BGT0Dkhk9A5IZPQOS
lyIQkh49A5LlHRGSGD0DklJpY2gZPQOSAAAAAAAAAABQRQAATAEBALL6QFcAAAAA
AAAAAOAADwELAQUMAAIAAAAAAAAAAAAAEBAAAAAQAAAAIAAAAABAAAAQAAAAAgAA
BAAAAAAAAAAEAAAAAAAAAAAgAAAAAgAAAAAAAAIAAAAAABAAABAAAAAAEAAAEAAA
AAAAABAAAAAAAAAAAAAAAGwQAAA8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAEAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC50ZXh0AAAA
7gAAAAAQAAAAAgAAAAIAAAAAAAAAAAAAAAAAACAAAGAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADSEAAAAAAAALgQAAAAAAAA
6zJEcm9wcGVkIGV4ZWN1dGFibGUATGV0J3MgZG8gbW9yZSBldmlsIHN0dWZmLCBu
b3QhAGoAaBIQQABoJRBAAGoA6AcAAABqAOgGAAAA/yUIEEAA/yUAEEAAzMywEAAA
AAAAAAAAAADGEAAACBAAAKgQAAAAAAAAAAAAAOAQAAAAEAAAAAAAAAAAAAAAAAAA
AAAAAAAAAADSEAAAAAAAALgQAAAAAAAAsQFNZXNzYWdlQm94QQB1c2VyMzIuZGxs
AACbAEV4aXRQcm9jZXNzAGtlcm5lbDMyLmRsbAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAA==
-----END CERTIFICATE-----