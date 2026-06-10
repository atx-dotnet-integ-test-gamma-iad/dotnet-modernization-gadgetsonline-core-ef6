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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or deprecated APIs, as these may indicate areas of the code that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application locally to verify basic runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to check for runtime exceptions that would not have been caught at build time.

### 5. Review Removed or Replaced APIs

Check the codebase for any usages of APIs that were available in the legacy .NET Framework but behave differently in cross-platform .NET. Common areas to inspect include:

- `System.Web` references (these are not available in cross-platform .NET and should have been replaced with ASP.NET Core equivalents)
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `Session` and `FormsAuthentication` (replaced by ASP.NET Core middleware equivalents)

### 6. Verify Configuration Files

Ensure that `web.config` or `app.config` settings have been migrated to `appsettings.json` or `appsettings.{Environment}.json` where applicable. Confirm that connection strings, app settings, and environment-specific values are correctly represented.

### 7. Execute Unit Tests

If the solution contains test projects, run them to validate that existing functionality behaves as expected:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to behavioral differences in the new runtime or pre-existing issues.

### 8. Test Data Access

If the project uses Entity Framework or another ORM, verify that:

- Migrations are up to date
- The database connection string is correctly configured for the target environment
- Basic CRUD operations function correctly at runtime

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and configuration files are present.

### 10. Verify on Target Operating System

If the goal of the migration was cross-platform support, run the published output on the target operating system (Linux or macOS) to confirm there are no platform-specific runtime issues:

```bash
dotnet GadgetsOnline.dll
```