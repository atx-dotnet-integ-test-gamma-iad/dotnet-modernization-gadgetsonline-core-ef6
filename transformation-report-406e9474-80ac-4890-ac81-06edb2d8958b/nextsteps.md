# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform target, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is set to `net8.0-windows` or another platform-specific moniker and cross-platform support is required, update it accordingly and rebuild.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality to confirm runtime behavior matches the legacy version.

### 5. Run Existing Tests

If a test project exists in the solution, execute the test suite:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate regressions introduced during the transformation or pre-existing issues.

### 6. Check for Removed or Replaced APIs

Review the codebase for any APIs that were available in the legacy .NET Framework but behave differently in cross-platform .NET. Common areas to check include:

- `System.Web` references or any remaining `HttpContext` usage patterns specific to ASP.NET (non-Core)
- `ConfigurationManager` usage — this should be replaced with `Microsoft.Extensions.Configuration`
- `App.config` or `Web.config` — confirm settings have been migrated to `appsettings.json`
- Windows-specific APIs such as the registry, `System.Drawing` (GDI+), or WCF server-side components

### 7. Validate Static Assets and Configuration

If this is a web project, confirm the following:

- `appsettings.json` contains all necessary configuration values previously held in `Web.config`
- Static files (CSS, JavaScript, images) are served correctly
- Connection strings point to the correct database instances for the target environment

### 8. Database Connectivity

If the project uses Entity Framework or ADO.NET, verify:

- The connection string in `appsettings.json` is correct
- Migrations (if using Entity Framework Core) are up to date by running:

```bash
dotnet ef database update
```

- Query behavior matches the legacy application, particularly around lazy loading or change tracking if migrating from EF6 to EF Core.

### 9. Publish the Application

Once validation is complete, publish the application for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all expected files are present before deploying to the target environment.