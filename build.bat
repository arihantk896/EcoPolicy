@echo off
setlocal enabledelayedexpansion

echo ========================================================
echo   EcoPolicy C++ Backend Build Script
echo ========================================================

cd /d "%~dp0"
if exist "oops project" (
    cd "oops project"
)

echo [1/3] Detecting C++ Compiler...
set "CXX="

if exist "C:\msys64\ucrt64\bin\g++.exe" (
    set "CXX=C:\msys64\ucrt64\bin\g++.exe"
    echo Found modern GCC: C:\msys64\ucrt64\bin\g++.exe
) else (
    where g++ >nul 2>nul
    if !errorlevel! equ 0 (
        set "CXX=g++"
        echo Found GCC in PATH
    )
)

if "%CXX%"=="" (
    echo [ERROR] No C++ compiler found! Please ensure MinGW or MSYS2 g++ is installed.
    exit /b 1
)

echo.
echo [2/3] Compiling C++ Engine and Tests...
echo Building ecopolicy.exe ...
"%CXX%" -O2 -Wall -Wextra -Iinclude src\BudgetOptimizer.cpp src\EconomicModel.cpp src\Economy.cpp src\FiscalPolicy.cpp src\main.cpp src\PolicyAnalyzer.cpp src\ReportGenerator.cpp src\Shock.cpp src\SimulationEngine.cpp src\SubsidyPolicy.cpp -o ecopolicy.exe
if %errorlevel% neq 0 (
    echo [ERROR] Failed to compile ecopolicy.exe!
    exit /b %errorlevel%
)
echo Build success: ecopolicy.exe

echo Building ecopolicy_tests.exe ...
"%CXX%" -O2 -Wall -Wextra -Iinclude src\BudgetOptimizer.cpp src\EconomicModel.cpp src\Economy.cpp src\FiscalPolicy.cpp src\PolicyAnalyzer.cpp src\ReportGenerator.cpp src\Shock.cpp src\SimulationEngine.cpp src\SubsidyPolicy.cpp tests\test_main.cpp -o ecopolicy_tests.exe
if %errorlevel% neq 0 (
    echo [ERROR] Failed to compile ecopolicy_tests.exe!
    exit /b %errorlevel%
)
echo Build success: ecopolicy_tests.exe

echo.
echo [3/3] Running Verification Tests...
ecopolicy_tests.exe
if %errorlevel% neq 0 (
    echo [WARNING] Some tests failed!
    exit /b %errorlevel%
)

echo.
echo ========================================================
echo   BUILD COMPLETED SUCCESSFULLY!
echo   Run the simulation with: .\ecopolicy.exe
echo   Or start dashboard with: streamlit run frontend\app.py
echo ========================================================
