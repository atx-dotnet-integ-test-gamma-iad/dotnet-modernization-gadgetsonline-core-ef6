# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or unresolved dependencies.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these may indicate areas that need attention.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application to verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to check for any runtime exceptions or unexpected behavior that would not surface at compile time.

### 5. Check for Removed or Changed APIs

Legacy .NET Framework projects often rely on APIs that have been removed or altered in cross-platform .NET. Manually review the following areas if they were present in the original project:

- `System.Web` usages — these are not available in cross-platform .NET and must be replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext` and related types — confirm they are sourced from `Microsoft.AspNetCore.Http`.
- Windows-specific APIs such as the registry, WMI, or COM interop — these will not function on non-Windows platforms.
- `ConfigurationManager` — this should be replaced with `Microsoft.Extensions.Configuration`.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests carefully, as failures may point to behavioral differences between .NET Framework and cross-platform .NET.

### 7. Verify Static Assets and Configuration Files

For web projects, confirm the following:

- `appsettings.json` is present and contains the configuration previously held in `web.config` or `app.config`.
- Static files (CSS, JavaScript, images) are located under the `wwwroot` folder.
- Connection strings and application settings have been correctly migrated.

### 8. Test on Target Platforms

If cross-platform support is a goal, test the application on each intended operating system (Windows, Linux, macOS) to identify any platform-specific issues that only manifest at runtime.