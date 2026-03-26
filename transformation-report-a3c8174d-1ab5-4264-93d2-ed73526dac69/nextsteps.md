# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Verify Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to a supported cross-platform .NET version (e.g., `net6.0`, `net7.0`, or `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 2. Restore NuGet Packages

Run the following command from the solution root to ensure all dependencies are properly restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated or unlisted packages that may need to be updated.

### 3. Build the Solution

Perform a full build to confirm there are no warnings that could indicate runtime issues:

```bash
dotnet build --configuration Release
```

Address any warnings related to nullable reference types, obsolete APIs, or platform compatibility.

### 4. Run the Application Locally

Start the application and verify it runs as expected on your local machine:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, including any database connections, authentication flows, and key business logic paths.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to confirm existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they represent regressions introduced during the migration or pre-existing issues.

### 6. Check for Windows-Specific APIs

Search the codebase for any remaining usage of Windows-specific APIs that may compile successfully but fail at runtime on non-Windows platforms. Common areas to check include:

- `Microsoft.Win32` namespace usage
- Registry access
- Windows-specific file path assumptions (e.g., hardcoded backslashes)
- `System.Drawing` (GDI+) usage, which requires additional native dependencies on Linux/macOS

Use the .NET Compatibility Analyzer or the following command to surface platform-specific warnings:

```bash
dotnet build -p:EnableNETAnalyzers=true
```

### 7. Verify Configuration and Middleware

If this is an ASP.NET Core project, review `Program.cs` or `Startup.cs` to ensure:

- Middleware is registered in the correct order
- Connection strings in `appsettings.json` are valid and point to accessible database instances
- Any `web.config` settings that were previously relied upon have been migrated to `appsettings.json` or environment variables

### 8. Test on Target Platform

If the goal is cross-platform deployment, run the application on the intended target operating system (Linux or macOS) to surface any runtime platform-specific issues that would not appear during a Windows build:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

Then execute the published output on the target platform and verify behavior matches the Windows run.

### 9. Review Deprecated Package References

Run the following to check for outdated NuGet packages:

```bash
dotnet list package --outdated
```

Update packages where appropriate, particularly any that were carried over from the legacy .NET Framework project and may have newer cross-platform compatible versions available.