# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your team's intended support targets.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves the same as it did in the legacy version.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to validate business logic and integration points:

```bash
dotnet test
```

Review the results for any failing tests that may indicate regressions introduced during the transformation.

### 6. Verify Static Assets and Configuration

- Confirm that `appsettings.json` (and any environment-specific variants such as `appsettings.Development.json`) contain the correct configuration values that were previously held in `Web.config` or `App.config`.
- Verify that static files, views, and any embedded resources are included correctly in the new project structure.

### 7. Check for Platform-Specific Code

Search the codebase for any remaining usage of Windows-specific APIs that may not be available on Linux or macOS, such as:

- `System.Web` references
- Windows Registry access
- COM interop
- `HttpContext.Current`

Address any findings by replacing them with cross-platform equivalents available in modern .NET.

### 8. Test on Target Platforms

If cross-platform support is a requirement, run and test the application on each intended operating system (e.g., Linux, macOS) to surface any platform-specific runtime issues that would not appear during a Windows build.

### 9. Review Published Output

Publish the application and review the output to ensure all required files are present:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm that dependencies, configuration files, and static assets are included as expected.