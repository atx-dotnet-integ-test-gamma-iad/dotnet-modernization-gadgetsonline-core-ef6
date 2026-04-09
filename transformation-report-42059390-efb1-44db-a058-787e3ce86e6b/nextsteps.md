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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas that need attention.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net9.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework is outdated (e.g., `netcoreapp3.1` or `net5.0`), update it to a current Long-Term Support (LTS) version.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality to identify any runtime errors that would not surface at compile time.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by the migration or pre-existing issues.

### 6. Check for Removed or Changed APIs

Review the code for usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET and should be replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages.
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`.
- Any Windows-specific APIs (e.g., registry access, WCF server-side) that may not function on non-Windows platforms.

### 7. Review Static Files and Configuration

Ensure that `appsettings.json` contains all configuration values that were previously held in `Web.config` or `App.config`. Verify connection strings, application settings, and any environment-specific values are correctly migrated.

### 8. Validate Data Access Layer

If the project uses Entity Framework, confirm the version in use:

- Entity Framework 6 can run on cross-platform .NET but has limitations.
- Migrating to Entity Framework Core is recommended for full cross-platform support.

Run any pending migrations and verify database connectivity:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and configuration files are present before deploying to the target environment.