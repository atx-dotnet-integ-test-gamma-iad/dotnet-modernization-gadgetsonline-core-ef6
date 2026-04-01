# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution. The following steps outline how to validate, test, and deploy the migrated `GadgetsOnline` project.

---

## 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings about deprecated or incompatible packages. If any packages are flagged, check [NuGet.org](https://www.nuget.org) for cross-platform compatible versions and update the `.csproj` file accordingly.

---

## 2. Build the Solution

Perform a full build to confirm there are no compilation issues.

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings, as some warnings may indicate runtime issues even if the build succeeds.

---

## 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `TargetFramework` is set to a supported modern .NET version, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing a legacy framework (e.g., `net472` or `netcoreapp3.1`), update it to a currently supported version.

---

## 4. Check for Removed or Changed APIs

Some APIs available in .NET Framework are not available or have changed in cross-platform .NET. Review the code for usage of the following common problem areas:

- `System.Web` namespace (not available in .NET Core/5+)
- `HttpContext` and related types (replaced by ASP.NET Core equivalents)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows-specific APIs such as the registry or WCF server-side hosting

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the [.NET API compatibility tool](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/api-compat) to identify any remaining incompatibilities.

---

## 5. Validate Application Configuration

Check that configuration files have been correctly migrated:

- `Web.config` or `App.config` settings should be moved to `appsettings.json`.
- Connection strings should be present and correct in `appsettings.json`.
- Confirm that environment-specific configuration (e.g., `appsettings.Development.json`) is in place.

---

## 6. Run the Application Locally

Start the application locally to verify basic functionality.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key features manually to confirm they behave as expected. Pay particular attention to:

- Database connectivity and queries
- Authentication and authorization flows
- Any file system operations (ensure paths are cross-platform compatible using `Path.Combine`)

---

## 7. Run Existing Tests

If the solution contains test projects, execute them to validate existing functionality.

```bash
dotnet test
```

Review the test results and address any failing tests. If no tests exist, consider writing basic integration or unit tests for the core functionality before deploying.

---

## 8. Verify Static Files and Frontend Assets

If the project serves static files (CSS, JavaScript, images), confirm that:

- Static files are located in the `wwwroot` folder.
- The `UseStaticFiles()` middleware is configured in `Program.cs` or `Startup.cs`.

---

## 9. Validate Database Migrations

If the project uses Entity Framework, verify that migrations are up to date and can be applied to the target database.

```bash
dotnet ef migrations list
dotnet ef database update
```

If migrations are missing or outdated, generate a new migration after confirming the model is correct:

```bash
dotnet ef migrations add InitialMigration
```

---

## 10. Publish the Application

Once validation is complete, publish the application to prepare it for deployment.

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.