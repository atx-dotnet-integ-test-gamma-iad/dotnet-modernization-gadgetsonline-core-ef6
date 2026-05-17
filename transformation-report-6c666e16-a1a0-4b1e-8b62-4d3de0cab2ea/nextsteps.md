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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version of .NET, such as `net8.0`. Ensure it is not still referencing a legacy `net48` or `netcoreapp` moniker unless that is intentional.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm core functionality is intact.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate business logic and integration points:

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral regressions introduced during the migration.

### 6. Review Removed or Replaced APIs

Check the codebase for any usage of APIs that were commonly replaced during migration from .NET Framework to cross-platform .NET, including:

- `System.Web` references, which are not available in cross-platform .NET and should have been replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages to confirm they reference the ASP.NET Core versions.
- Any `ConfigurationManager` usage, which should be replaced with `Microsoft.Extensions.Configuration`.
- `BinaryFormatter`, which is disabled by default in modern .NET due to security concerns.

### 7. Verify Static Files and Configuration

- Confirm that `wwwroot` contains all necessary static assets that were previously served from the project root or `Content`/`Scripts` folders.
- Verify that `appsettings.json` contains the configuration values that were previously held in `Web.config` or `App.config`.
- Confirm that connection strings, application settings, and environment-specific values are correctly represented.

### 8. Check Runtime Behavior for Data Access

If the project uses Entity Framework, confirm the version in use:

- **Entity Framework Core**: Run `dotnet ef migrations list` to verify migrations are recognized.
- Confirm the database provider package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is referenced and up to date.
- Test database connectivity by running the application and exercising data-driven features.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required assemblies, static files, and configuration files are present before deploying to the target environment.