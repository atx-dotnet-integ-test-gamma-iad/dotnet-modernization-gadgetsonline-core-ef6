# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or incompatible target frameworks.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports `0 Error(s)` and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with the runtime environment you intend to deploy to.

### 4. Run Unit Tests

If the solution contains any test projects, execute the tests to verify that existing functionality has not been broken during the migration:

```bash
dotnet test --configuration Release
```

Review the test results for any failures that may indicate behavioral regressions introduced by the migration.

### 5. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and verify that core functionality behaves correctly.

### 6. Review Removed or Changed APIs

Check the codebase for any usage of APIs that were available in the legacy .NET Framework but may behave differently in cross-platform .NET. Common areas to review include:

- `System.Web` references or any remaining compatibility shims
- `HttpContext` and related ASP.NET pipeline components
- Configuration APIs (e.g., `ConfigurationManager` vs. `Microsoft.Extensions.Configuration`)
- Any Windows-specific APIs such as the registry, WMI, or COM interop

### 7. Verify Static Assets and Configuration Files

Confirm that files such as `appsettings.json`, `wwwroot` contents, and any view or template files have been carried over correctly and are functioning as expected when the application is running.

### 8. Test on Target Operating System

If cross-platform support is a goal, test the application on the intended non-Windows operating system (e.g., Linux or macOS) to surface any platform-specific issues that would not appear during Windows-based testing.

### 9. Publish the Application

Once validation is complete, publish the application using the following command, adjusting the runtime identifier as needed:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.