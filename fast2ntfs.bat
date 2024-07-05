@echo off
setlocal enabledelayedexpansion

:: Pengecekan Hak Akses Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Script ini harus dijalankan dengan hak akses administrator.
    pause
    exit /b
)

echo ===================by===========================
echo         f  a  s  t  2  n  t  f  s                                               
echo ===================it===========================
echo      FAT32 Secure Transition to NTFS
echo =================t4mp@n=========================
echo.

echo Daftar drive yang tersedia:
echo --------------------------------
wmic logicaldisk get deviceid, volumename, description

:input
echo --------------------------------
echo Silakan masukkan huruf drive yang ingin dikonversi (contoh: D)
set /p driveLetter=Drive letter:

if "%driveLetter%"=="" (
    echo Huruf drive tidak boleh kosong. Silakan coba lagi.
    goto input
)

:: Cek apakah drive letter valid
vol %driveLetter%: >nul 2>&1
if errorlevel 1 (
    echo Huruf drive tidak valid atau drive tidak ada. Silakan coba lagi.
    goto input
)

:: Konfirmasi sebelum konversi
echo.
echo Anda akan mengonversi drive %driveLetter%: ke NTFS. Apakah Anda yakin? (Y/N)
set /p confirm=Konfirmasi:

if /i not "%confirm%"=="Y" (
    echo Konversi dibatalkan.
    goto end
)

echo.
echo Memulai konversi drive %driveLetter%: ke NTFS...
convert %driveLetter%: /fs:ntfs

if %errorlevel% equ 0 (
    echo.
    echo Konversi berhasil!
) else (
    echo.
    echo Terjadi kesalahan selama konversi. Periksa kembali huruf drive yang dimasukkan atau pastikan drive tidak sedang digunakan.
)

:end
pause
endlocal
