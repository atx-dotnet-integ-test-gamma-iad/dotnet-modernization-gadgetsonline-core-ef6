# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Verify that no legacy `<TargetFrameworkVersion>` elements remain from the original .NET Framework project format.

### 4. Check for Removed or Replaced APIs

Review the codebase for any usage of APIs that were available in .NET Framework but are absent or behave differently in cross-platform .NET. Common areas to check include:

- `System.Web` references (not available in .NET Core/.NET 5+)
- `HttpContext` and related ASP.NET types (should use `Microsoft.AspNetCore` equivalents)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows-specific APIs such as the registry or WCF server-side components

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core workflows to confirm expected behavior. Pay particular attention to areas that relied on .NET Framework-specific behavior, such as authentication, session management, and database access.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review the test results and investigate any failures, as they may indicate behavioral differences introduced by the migration.

### 7. Verify Database Connectivity

If the project uses Entity Framework or another ORM, confirm that:

- The correct provider package is referenced (e.g., `Microsoft.EntityFrameworkCore.SqlServer`)
- Connection strings in `appsettings.json` are correctly configured
- Any pending migrations are applied using `dotnet ef database update`

### 8. Review Static Files and Configuration

Confirm that:

- `appsettings.json` contains all configuration values previously held in `Web.config` or `App.config`
- Static files (CSS, JavaScript, images) are located under the `wwwroot` folder if this is an ASP.NET Core web project
- Any `Web.config` transforms have been manually reviewed and their equivalents applied in the new configuration system

### 9. Deployment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to your target hosting environment and confirm the application starts and operates correctly in that environment.