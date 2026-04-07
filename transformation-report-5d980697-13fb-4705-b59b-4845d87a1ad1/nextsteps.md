# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, as some warnings may indicate deprecated APIs or compatibility concerns that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure this aligns with the runtime environment you intend to deploy to.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences between the legacy .NET Framework and the new target framework.

### 5. Check for Runtime Dependencies

Verify that any dependencies on Windows-specific APIs, registry access, `System.Web`, or other platform-specific libraries have been addressed. These will not produce build errors but may cause runtime failures on non-Windows platforms.

Common areas to audit:
- Any use of `System.Web` namespaces (should be replaced with ASP.NET Core equivalents)
- `HttpContext` usage patterns
- Session and authentication middleware configuration
- Any P/Invoke calls or native library references

### 6. Run the Application Locally

Start the application locally and manually verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Walk through the primary user-facing features and confirm they behave as expected.

### 7. Review Configuration Files

Ensure that `appsettings.json` (and environment-specific variants such as `appsettings.Production.json`) contain all configuration values that were previously held in `Web.config` or `App.config`. The `Web.config` transformation system is not used in cross-platform .NET; all configuration should be managed through the `Microsoft.Extensions.Configuration` system.

### 8. Validate Static Assets and Middleware Pipeline

If this is a web project, confirm that:
- Static files are being served correctly
- Routing is configured as expected
- Any custom HTTP modules or handlers from the legacy project have been converted to ASP.NET Core middleware

### 9. Test on a Non-Windows Platform (if applicable)

If cross-platform support is a requirement, run the application on Linux or macOS to surface any remaining platform-specific issues that would not appear during Windows-based testing.