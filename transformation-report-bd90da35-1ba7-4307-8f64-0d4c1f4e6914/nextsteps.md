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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net6.0`. For example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If the target framework is outdated (e.g., `netcoreapp3.1`), update it to a current Long-Term Support (LTS) version.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as expected compared to the original legacy project.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to validate business logic and integration points:

```bash
dotnet test
```

Review the results for any failing tests that may indicate behavioral regressions introduced during the transformation.

### 6. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that are known to behave differently in cross-platform .NET compared to .NET Framework. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET and should have been replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages to confirm they reference the ASP.NET Core versions.
- Any Windows-specific APIs such as the registry, WMI, or Windows identity APIs that may fail on non-Windows platforms.

### 7. Verify Static Files and Configuration

- Confirm that `wwwroot` contains all necessary static assets (CSS, JavaScript, images).
- Verify that `appsettings.json` contains the configuration values that were previously held in `Web.config` or `App.config`.
- Check that connection strings and application settings have been correctly migrated.

### 8. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.