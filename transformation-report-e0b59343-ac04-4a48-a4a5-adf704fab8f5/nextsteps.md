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

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

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

Navigate through the application and verify that core functionality behaves as expected compared to the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that business logic has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before moving forward.

### 6. Review Removed or Changed APIs

Cross-platform .NET does not support certain APIs that were available in .NET Framework. Manually review the codebase for usage of the following common problem areas:

- `System.Web` namespace references (these are not available in .NET Core/.NET 5+)
- `HttpContext` usage patterns that may differ from ASP.NET Core
- `ConfigurationManager` replaced by `Microsoft.Extensions.Configuration`
- `Global.asax` replaced by `Program.cs` and `Startup.cs` (or top-level statements)
- Windows-specific APIs such as the registry or certain I/O operations

### 7. Validate Configuration Files

Ensure that `appsettings.json` (or `appsettings.Development.json`) contains all configuration values that were previously stored in `Web.config` or `App.config`. Verify connection strings, application settings, and any environment-specific values are correctly migrated.

### 8. Check Static Files and wwwroot

If this is a web project, confirm that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder, as this is required by ASP.NET Core's static file middleware.

### 9. Verify Database Connectivity

If the application uses a database, confirm that:

- The connection string in `appsettings.json` is correct
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

- The application can successfully read and write data at runtime

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and self-contained:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder and verify all expected files are present before deploying to the target environment.