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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports `0 Error(s)` and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the framework moniker is appropriate (e.g., `net8.0` rather than a legacy `net48` or `netcoreapp` value).

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, including any database connections, authentication flows, and key business logic paths.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that behavior has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures. Pay particular attention to tests covering data access, external service integrations, and any platform-specific code that was modified during transformation.

### 6. Review Removed or Replaced APIs

Check the codebase for any uses of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to review include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related types, which may have moved to `Microsoft.AspNetCore.Http`
- Configuration APIs, which have moved from `System.Configuration` to `Microsoft.Extensions.Configuration`
- Any Windows-specific APIs (registry access, WCF, etc.) that may require alternative implementations

### 7. Verify Static Files and Configuration

If this is a web application, confirm that:

- `wwwroot` contains the expected static assets
- `appsettings.json` (or environment-specific variants) contains the configuration values previously held in `Web.config` or `App.config`
- Connection strings and application settings have been correctly migrated

### 8. Test Against a Target Database

If the application uses a database, run the application against a test or staging database instance to confirm that:

- Migrations apply cleanly (if using Entity Framework Core)
- Queries return expected results
- No runtime exceptions occur related to data access

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.