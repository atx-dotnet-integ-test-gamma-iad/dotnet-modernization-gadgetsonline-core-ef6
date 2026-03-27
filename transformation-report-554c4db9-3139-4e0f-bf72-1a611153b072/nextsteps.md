# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas that may cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm baseline functionality is intact.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by behavioral differences in the new runtime or by incomplete migration of test dependencies.

### 6. Review Removed or Replaced APIs

Check the codebase for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` references (not available in cross-platform .NET)
- `HttpContext` and related ASP.NET pipeline components
- Windows-specific APIs such as the registry, WCF, or `System.Drawing` (which requires additional packages on non-Windows platforms)
- Entity Framework — confirm whether the project has migrated to EF Core and that all migrations are up to date

### 7. Verify Static Assets and Configuration

- Confirm that `appsettings.json` contains the correct configuration values previously held in `Web.config` or `App.config`.
- Verify that static files, views, and other content files are included correctly in the project output.

### 8. Test on Target Platform

If the goal is cross-platform support, run the application on the intended non-Windows platform (Linux or macOS) to surface any platform-specific issues that would not appear during Windows development.

```bash
dotnet publish --configuration Release --runtime linux-x64
```

Then execute the published output on the target platform and verify expected behavior.