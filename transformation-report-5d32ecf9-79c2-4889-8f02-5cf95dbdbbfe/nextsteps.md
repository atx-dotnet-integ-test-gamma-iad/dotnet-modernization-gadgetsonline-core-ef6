# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these may indicate areas that were not fully modernized.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported, non-end-of-life version of .NET, such as `net8.0`. For example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is targeting `net6.0` or `net7.0`, consider updating to `net8.0` as those versions have reached end of life.

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality to identify any runtime errors that would not surface at build time.

### 5. Run Existing Tests

If a test project exists within the solution, execute the test suite:

```bash
dotnet test
```

Review the results for any failing tests that may indicate behavioral regressions introduced during the migration.

### 6. Check for Windows-Specific APIs

Search the codebase for any APIs that were specific to the .NET Framework and may not behave identically on cross-platform .NET, including:

- `System.Web` references (these are not available in cross-platform .NET)
- `HttpContext` usage outside of ASP.NET Core's dependency injection model
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Registry access or Windows-specific file paths

Use the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.ApiCompat` tooling to assist with this review.

### 7. Validate Configuration Files

Ensure that any `Web.config` or `App.config` files have been migrated to `appsettings.json` and that the application reads configuration correctly at runtime. Verify connection strings, application settings, and environment-specific values are all present and correct.

### 8. Test on Target Platforms

If cross-platform support is a goal, run and validate the application on each intended operating system (Windows, Linux, macOS) to surface any platform-specific issues that only appear at runtime.

### 9. Review Static Files and Bundling

If the project is a web application, verify that static files (CSS, JavaScript, images) are being served correctly. If the legacy project used ASP.NET bundling and minification (`System.Web.Optimization`), confirm that a replacement such as `WebOptimizer` or a front-end build tool has been configured.

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and verify all required files are present before deploying to the target environment.