# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without any reported issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors and review any warnings:

```bash
dotnet build --configuration Release
```

Address any warnings that may indicate compatibility concerns, such as obsolete APIs or platform-specific code paths.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `net8.0` or the appropriate modern TFM rather than any `net4x` or `netcoreapp` moniker.

### 4. Run the Application Locally

Start the application locally and verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test primary user flows such as browsing products, adding items to a cart, and completing a purchase if applicable.

### 5. Execute Unit and Integration Tests

If a test project exists in the solution, run all tests to confirm no regressions were introduced during transformation:

```bash
dotnet test --configuration Release
```

Review test output for any failures and address them before proceeding.

### 6. Verify Database Connectivity

If the project uses Entity Framework or another data access layer, confirm that:

- Connection strings in `appsettings.json` are correctly configured for the target environment.
- Any EF Core migrations are up to date by running:

```bash
dotnet ef migrations list
dotnet ef database update
```

Ensure the EF Core provider package matches the database being used (e.g., `Microsoft.EntityFrameworkCore.SqlServer`).

### 7. Check for Windows-Specific Dependencies

Review the codebase for any remaining usages of Windows-specific APIs, such as:

- `System.Web` types that were not fully replaced
- Registry access (`Microsoft.Win32.Registry`)
- Windows-only authentication mechanisms

Use the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify remaining platform-specific code.

### 8. Review Static Files and Bundling

If the project uses static file bundling or minification (e.g., via `BundleConfig.cs` from the legacy ASP.NET MVC pipeline), confirm these have been replaced with an appropriate alternative such as:

- `WebOptimizer`
- Manual inclusion of pre-built assets
- A front-end build tool such as npm scripts

### 9. Validate Configuration Migration

Confirm that settings previously stored in `Web.config` have been fully migrated to `appsettings.json` and that the application reads them correctly via `IConfiguration`.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and verify all necessary files, static assets, and configuration files are present before deploying to the target environment.