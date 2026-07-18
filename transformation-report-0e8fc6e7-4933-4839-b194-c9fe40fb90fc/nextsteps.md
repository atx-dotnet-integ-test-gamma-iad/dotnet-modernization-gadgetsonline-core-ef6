# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution has no build errors following the transformation. The project `GadgetsOnline/GadgetsOnline.csproj` compiled successfully, which indicates the migration to cross-platform .NET has completed without introducing any compilation issues.

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

Run the following command from the solution root to ensure all dependencies are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings about deprecated or incompatible packages and replace them with their .NET-compatible equivalents if needed.

### 3. Build the Solution

Perform a clean build to confirm there are no issues:

```bash
dotnet build --configuration Release
```

Review any warnings in the output, as some warnings may indicate runtime issues even if the build succeeds.

### 4. Run Unit Tests

If the solution contains test projects, run them to verify existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests before proceeding.

### 5. Run the Application Locally

Start the application locally and verify it behaves as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Walk through the core workflows of the application (e.g., browsing products, adding to cart, checkout) to confirm end-to-end functionality is intact.

### 6. Check for Platform-Specific API Usage

Even though the build succeeds, there may be runtime issues caused by APIs that were available in .NET Framework but behave differently or are unavailable in cross-platform .NET. Pay particular attention to:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. If any remain, they will cause runtime failures.
- **Windows Registry access**: Not supported on non-Windows platforms.
- **`HttpContext` and session handling**: Confirm these have been migrated to ASP.NET Core equivalents.
- **Entity Framework**: Confirm the project is using EF Core rather than EF 6 if database access is involved.

### 7. Verify Configuration Files

Ensure that `web.config` or `app.config` settings have been migrated to `appsettings.json` and that the application reads configuration correctly using `IConfiguration`:

```csharp
var value = configuration["SomeKey"];
```

### 8. Test on Target Platform

If the goal is to run on a non-Windows platform (Linux or macOS), deploy and run the application on that platform to surface any remaining platform-specific issues:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

Then transfer the published output to the target machine and run it to confirm compatibility.

### 9. Review Dependency Compatibility

Use the .NET Upgrade Assistant compatibility analyzer or the `dotnet-compatibility` tool to check for any remaining compatibility concerns:

```bash
dotnet tool install -g dotnet-compatibility
```

This can surface issues that do not cause build errors but may cause problems at runtime.