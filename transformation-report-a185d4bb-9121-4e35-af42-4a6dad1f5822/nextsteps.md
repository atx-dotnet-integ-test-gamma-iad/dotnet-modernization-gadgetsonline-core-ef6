# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation errors:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to check for any runtime errors that would not have been caught at compile time.

### 5. Review Runtime Behavior and Middleware

If this is an ASP.NET Core application, verify that the `Program.cs` or `Startup.cs` configuration is correct for the target framework. Pay particular attention to:

- Middleware registration order
- Authentication and authorization configuration
- Static file serving
- Database context registration and connection strings

### 6. Check Configuration Files

Ensure that `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) contain the correct configuration values, particularly:

- Database connection strings
- Any API keys or external service endpoints that may have been stored in `Web.config` in the legacy project

Note that `Web.config` transforms are not used in cross-platform .NET. Configuration should now be managed through `appsettings.json` and environment variables.

### 7. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before considering the migration complete.

### 8. Verify Database Migrations

If the project uses Entity Framework Core, confirm that migrations are up to date and apply them against a development database:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

If the project was previously using Entity Framework 6, ensure it has been migrated to Entity Framework Core and that all migration history is intact.

### 9. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the [Platform Compatibility Analyzer](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/platform-compat-analyzer) can assist with identifying these issues.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.