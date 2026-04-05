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

Run the following command from the solution root to ensure all dependencies are restored cleanly:

```bash
dotnet restore
```

Review the output for any warnings about deprecated or unlisted packages that may need updating.

### 3. Build the Solution

Perform a full build to confirm there are no warnings that could indicate runtime issues:

```bash
dotnet build --configuration Release
```

Address any warnings related to nullable reference types, obsolete APIs, or platform compatibility.

### 4. Run the Application Locally

Start the application and verify it runs as expected on the target platform:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm behavior matches the legacy version.

### 5. Run Existing Tests

If a test project exists in the solution, execute the test suite:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect regressions introduced during the migration or pre-existing issues.

### 6. Review Removed or Changed APIs

Check the codebase for any usage of APIs that were available in .NET Framework but have changed behavior in cross-platform .NET. Common areas to inspect include:

- `System.Web` references (should have been replaced with ASP.NET Core equivalents)
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `System.Drawing` (has platform limitations on non-Windows systems)
- Windows Registry access or Windows-specific P/Invoke calls

### 7. Verify Configuration Files

Confirm that `web.config` or `app.config` settings have been migrated to `appsettings.json` or environment variables where applicable. Ensure connection strings, application settings, and logging configuration are correctly represented.

### 8. Test on Target Platform

If the intended deployment platform is Linux or macOS, run the application on that operating system to surface any remaining platform-specific issues:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

Then execute the published output on the target machine and verify functionality.

### 9. Review Dependency Versions

Check that all NuGet packages are using versions compatible with the target .NET version. Run the following to identify outdated packages:

```bash
dotnet list package --outdated
```

Update packages as needed, testing after each update to isolate any breaking changes.