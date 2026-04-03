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

Verify that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net6.0`. Ensure this aligns with your deployment environment.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, particularly any areas that relied on Windows-specific APIs or legacy ASP.NET features prior to migration.

### 5. Execute Unit Tests

If the solution contains test projects, run all tests to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review test results for any failures that may indicate behavioral regressions introduced during the migration.

### 6. Check for Removed or Changed APIs

Review the code for usage of any APIs that were available in .NET Framework but have changed or been removed in modern .NET. Common areas to check include:

- `System.Web` references (these are not available in modern .NET)
- `HttpContext` and related types (replaced by `Microsoft.AspNetCore.Http`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `Global.asax` (replaced by `Program.cs` and `Startup.cs` or top-level statements)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) if further API compatibility checks are needed.

### 7. Validate Configuration Files

Confirm that `appsettings.json` (or `appsettings.Development.json`) contains all configuration values that were previously stored in `Web.config` or `App.config`. Verify that connection strings, application settings, and any custom configuration sections have been correctly migrated.

### 8. Test Database Connectivity

If the application uses a database, verify that the connection string is correct and that the application can connect and perform operations successfully in the new runtime environment.

### 9. Review Static Files and wwwroot

If this is a web application, confirm that static assets (CSS, JavaScript, images) are located under the `wwwroot` folder and are being served correctly when the application runs.

### 10. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct before deploying:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present, then deploy the output to your target environment.