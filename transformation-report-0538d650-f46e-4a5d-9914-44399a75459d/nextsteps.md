# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to deprecated or incompatible packages that may not have surfaced as build errors but could cause runtime issues.

### 2. Build the Solution

Perform a full build to confirm the clean state:

```bash
dotnet build --configuration Release
```

Confirm that the output shows zero errors and review any warnings, particularly those related to nullable reference types, obsolete APIs, or target framework compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or `net6.0` and not a legacy `netcoreapp` moniker.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality manually to identify any runtime exceptions that would not appear at compile time. Pay particular attention to:

- Database connection strings and Entity Framework migrations if applicable
- Any static file serving or middleware configuration in `Program.cs` or `Startup.cs`
- Authentication and session handling, which often requires reconfiguration when migrating from ASP.NET to ASP.NET Core

### 5. Check for Replaced or Removed APIs

Review the code for any usage of APIs that were available in legacy .NET Framework but have changed behavior in cross-platform .NET. Common areas include:

- `System.Web` references, which are not available in .NET Core or later
- `HttpContext` and related types, which have different namespaces and behaviors
- `ConfigurationManager`, which should be replaced with `IConfiguration`
- `App.config` or `Web.config` sections, which should be migrated to `appsettings.json`

### 6. Execute Unit Tests

If the solution contains test projects, run them with:

```bash
dotnet test
```

Review any failing tests as they may indicate behavioral differences introduced by the migration even when the build succeeds.

### 7. Verify Database Migrations

If the project uses Entity Framework, verify that migrations are compatible with the new runtime:

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
```

If migrations fail or are missing, you may need to add a new initial migration or update the database context configuration.

### 8. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files, static assets, and configuration files are present before deploying to the target environment.