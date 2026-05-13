# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution has no build errors following the transformation. The project `GadgetsOnline/GadgetsOnline.csproj` compiled successfully, which indicates the migration to cross-platform .NET was completed without introducing any compilation issues.

## Validation Steps

### 1. Review the Project File

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to a supported cross-platform .NET version (e.g., `net6.0`, `net7.0`, or `net8.0`):

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it still references `net48` or any other .NET Framework moniker, update it accordingly.

### 2. Restore NuGet Packages

Run the following command from the solution root to ensure all dependencies are properly restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated or incompatible packages. Replace any packages that do not support the target framework with their modern equivalents.

### 3. Build the Solution

Perform a clean build to confirm there are no residual issues:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, as some may indicate runtime issues even if the build succeeds.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality and confirm that pages load, data is retrieved correctly, and no runtime exceptions occur.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite:

```bash
dotnet test
```

Review the results and investigate any failing tests. Failing tests after a migration often indicate behavioral differences between .NET Framework and modern .NET, such as changes in serialization, HTTP handling, or configuration loading.

### 6. Verify Configuration and Middleware

If this is an ASP.NET Core project, confirm the following:

- `Program.cs` or `Startup.cs` uses the modern ASP.NET Core middleware pipeline.
- `appsettings.json` is present and replaces any legacy `Web.config` application settings.
- Connection strings have been moved from `Web.config` to `appsettings.json` or environment variables.

### 7. Check for Platform-Specific API Usage

Run the .NET Compatibility Analyzer to detect any remaining usage of Windows-only or .NET Framework-only APIs:

```bash
dotnet add package Microsoft.DotNet.Analyzers.Compatibility
dotnet build
```

Review and replace any flagged APIs with their cross-platform equivalents.

### 8. Test on a Non-Windows Environment (Optional but Recommended)

Since the goal is cross-platform compatibility, run the application on a Linux or macOS machine (or WSL on Windows) to surface any platform-specific issues that would not appear on Windows alone:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay particular attention to file path separators, case-sensitive file access, and any Windows Registry or COM interop dependencies.

### 9. Review Deprecated or Removed APIs

Check the [.NET breaking changes documentation](https://learn.microsoft.com/en-us/dotnet/core/compatibility/breaking-changes) relevant to the version you are targeting. Common areas to review include:

- `System.Web` namespace removal (replaced by ASP.NET Core equivalents)
- Changes in `HttpClient` behavior
- JSON serialization differences (`Newtonsoft.Json` vs `System.Text.Json`)
- Entity Framework Core differences if migrating from EF 6

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` folder and confirm the application runs from the published output before deploying to the target environment.