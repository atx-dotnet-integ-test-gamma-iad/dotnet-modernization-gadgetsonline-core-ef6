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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an actively supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm behavior matches the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failures before proceeding.

### 6. Check for Removed or Changed APIs

Review the code for usage of any APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET pipeline components
- Windows-specific APIs such as the registry or certain `System.Drawing` features
- `ConfigurationManager` usage, which may need to be replaced with `IConfiguration`

### 7. Validate Configuration Files

Ensure that `appsettings.json` (or equivalent) contains all configuration values that were previously stored in `web.config` or `app.config`. Confirm that connection strings, application settings, and environment-specific values have been correctly migrated.

### 8. Test Data Access

If the project uses a database, verify that:

- Connection strings are correctly configured
- Migrations (if using Entity Framework) are up to date by running:

```bash
dotnet ef database update
```

- Basic CRUD operations function correctly against the target database

### 9. Review Static Files and Assets

If this is a web project, confirm that static files such as CSS, JavaScript, and images are being served correctly. Ensure the `wwwroot` folder structure aligns with what the application expects.

### 10. Deploy to a Staging Environment

Once local validation is complete, deploy the application to a staging environment that mirrors production. Perform smoke testing against staging before promoting to production.