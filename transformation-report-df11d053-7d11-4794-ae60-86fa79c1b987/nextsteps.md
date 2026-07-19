# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Run the following command from the solution root to ensure all dependencies are correctly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the framework moniker is appropriate (e.g., `net8.0` rather than a Windows-specific TFM unless Windows-only APIs are required).

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally hosted URL and verify that core functionality behaves as expected.

### 5. Execute the Test Suite

If a test project exists in the solution, run all tests to validate business logic and integration points:

```bash
dotnet test
```

Review any failing tests and address regressions introduced during the transformation.

### 6. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have changed behavior or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references (these are not available in cross-platform .NET)
- `HttpContext` and related ASP.NET pipeline APIs
- Windows Registry access (`Microsoft.Win32.Registry`)
- `AppDomain` usage
- Configuration APIs (e.g., `ConfigurationManager` replaced by `Microsoft.Extensions.Configuration`)

### 7. Verify Static Files and Configuration

Ensure that files such as `appsettings.json`, `wwwroot` assets, and any embedded resources are correctly included in the project and accessible at runtime. Check that connection strings and application settings have been migrated from `Web.config` or `App.config` to `appsettings.json` where applicable.

### 8. Validate Database Connectivity

If the application uses a database, confirm that:

- The connection string in `appsettings.json` is correct for the target environment.
- Any ORM (e.g., Entity Framework) migrations are up to date by running:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is self-contained and deployable:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.