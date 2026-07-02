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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas of the code that need attention.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older or end-of-life version, update it accordingly:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key features and confirm that core functionality behaves correctly.

### 5. Execute Unit Tests

If the solution contains test projects, run them to validate existing functionality:

```bash
dotnet test
```

Review the test results and investigate any failures. If no tests exist, consider writing tests for critical paths in the application.

### 6. Check for Removed or Changed APIs

Cross-platform .NET does not support certain APIs that were available in .NET Framework. Review the code for usage of the following common incompatibilities:

- `System.Web` namespace (not available in .NET Core/.NET 5+)
- `HttpContext` usage outside of ASP.NET Core's dependency injection model
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows Registry access or other Windows-specific APIs
- `BinaryFormatter` (deprecated and disabled by default in modern .NET)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify remaining incompatible API calls.

### 7. Validate Configuration Files

Ensure that `appsettings.json` (or `appsettings.Development.json`) contains all configuration values that were previously in `Web.config` or `App.config`. Confirm that connection strings, application settings, and environment-specific values have been migrated correctly.

### 8. Test Database Connectivity

If the application uses a database, verify that:

- The connection string in `appsettings.json` is correct for the target environment.
- Migrations (if using Entity Framework Core) are up to date by running:

```bash
dotnet ef database update
```

- Data reads and writes function correctly through the application.

### 9. Review Static Files and Middleware

If this is a web application, confirm that static files (CSS, JavaScript, images) are being served correctly and that all middleware components (authentication, routing, error handling) are configured properly in `Program.cs` or `Startup.cs`.

### 10. Deploy to Target Environment

Once all local validation steps pass:

1. Publish the application using the appropriate runtime identifier for your target environment:

```bash
dotnet publish --configuration Release --runtime win-x64 --self-contained false
```

2. Copy the published output to the target server or hosting environment.
3. Verify the application starts and responds correctly in the target environment.
4. Check application logs for any runtime errors that did not surface during local testing.