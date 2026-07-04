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

Review the output for any warnings about missing or incompatible packages. Pay attention to any packages that may have been replaced with compatibility shims during the transformation, as these may need to be updated to their modern cross-platform equivalents.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm the build completes with zero errors and review any warnings, as some warnings may indicate deprecated APIs or patterns that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework moniker (TFM) is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it is using `net8.0` or another current supported TFM rather than a legacy one such as `net472` or `netcoreapp3.1`.

### 4. Check for Windows-Specific Dependencies

Review the project for any remaining Windows-specific APIs or packages that may compile successfully but fail at runtime on non-Windows platforms. Common areas to check include:

- `System.Drawing` (replaced by cross-platform alternatives such as `SkiaSharp` or `ImageSharp`)
- Windows Registry access (`Microsoft.Win32.Registry`)
- COM interop dependencies
- Any `[SupportedOSPlatform("windows")]` warnings emitted during the build

### 5. Run the Application Locally

Start the application and verify basic functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm that core features behave as expected.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review any failing tests carefully, as failures may indicate behavioral differences between the legacy .NET Framework runtime and modern .NET rather than bugs in the transformation itself.

### 7. Review Configuration Files

- Confirm that `appsettings.json` (or equivalent) contains all configuration values that were previously in `Web.config` or `App.config`.
- Verify that connection strings, application settings, and environment-specific values have been correctly migrated.
- Check that any `Web.config` transforms or `configSource` references have been replaced with the appropriate `appsettings.{Environment}.json` pattern.

### 8. Validate Data Access Layer

If the project uses Entity Framework, confirm the version in use:

- **Entity Framework Core**: Run `dotnet ef migrations list` to verify migrations are intact.
- **Entity Framework 6**: Confirm the `EntityFramework6` NuGet package is referenced and that the connection strings are correctly configured.

### 9. Test on Target Platforms

If cross-platform support is a goal, run and test the application on each intended target operating system (Windows, Linux, macOS) to surface any platform-specific runtime issues that would not appear during a Windows-only build.