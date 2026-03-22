# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net6.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If the target framework does not match your intended runtime, update it accordingly and re-run the build.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, particularly any areas that relied on Windows-specific APIs or legacy ASP.NET features prior to transformation.

### 5. Execute Unit Tests

If the solution contains test projects, run all tests to validate functional correctness:

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral differences introduced during the migration.

### 6. Review Replaced or Removed APIs

Check the codebase for any uses of APIs that may have been replaced or removed in modern .NET. Common areas to review include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage patterns
- Any third-party packages that were updated during transformation — confirm the newer versions behave as expected
- Configuration patterns, such as `Web.config` sections that may have been migrated to `appsettings.json`

### 7. Verify Static Files and Configuration

Confirm that `appsettings.json`, `appsettings.Development.json`, and any static web assets are present and correctly structured. Ensure connection strings and application settings have been properly carried over from any legacy `Web.config` or `App.config` files.

### 8. Test on Target Operating System

Since the goal is cross-platform compatibility, if deployment is intended for Linux or macOS, run and test the application on that operating system to surface any remaining platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay particular attention to file path handling, case sensitivity, and any OS-specific dependencies.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.