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

Confirm the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net6.0`, `net7.0`, or `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended version, update it and re-run `dotnet restore` and `dotnet build`.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test output for any failures and address them before proceeding.

### 5. Check for Removed or Changed APIs

Run the .NET Upgrade Assistant compatibility analyzer or inspect the code manually for usage of APIs that may have been removed or changed between .NET Framework and modern .NET. Pay particular attention to:

- `System.Web` dependencies, which are not available in cross-platform .NET
- Any Windows-specific APIs (e.g., registry access, WCF server-side hosting)
- Third-party libraries that may still target .NET Framework only

### 6. Run the Application Locally

Start the application locally and exercise its primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Verify that all routes, pages, or endpoints respond correctly and that no runtime exceptions occur.

### 7. Review Configuration Files

Ensure that `appsettings.json` (or equivalent) contains all configuration values that were previously held in `web.config` or `app.config`. The `web.config` transformation process does not always migrate all entries automatically. Check for:

- Connection strings
- Application settings / feature flags
- Authentication configuration
- Logging configuration

### 8. Validate Data Access

If the project uses Entity Framework or another ORM, confirm that:

- Migrations are up to date by running `dotnet ef migrations list`
- The database connection can be established at runtime
- Basic CRUD operations function as expected against the target database

### 9. Test on Target Platform

If cross-platform support (Linux/macOS) is a goal, run the application on the intended non-Windows platform to surface any remaining platform-specific issues before deployment.