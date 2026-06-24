# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or unresolved dependencies that may not surface as hard build errors.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with the runtime environment you intend to deploy to.

### 4. Check for Removed or Incompatible APIs

Even without build errors, some APIs may have behavioral differences in cross-platform .NET compared to .NET Framework. Run the .NET Upgrade Assistant compatibility analyzer or the Platform Compatibility Analyzer to surface any runtime risks:

```bash
dotnet add package Microsoft.DotNet.UpgradeAssistant.Extensions.Default.Analyzers
```

Review any warnings produced during the build after adding this package.

### 5. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior is consistent with the original application:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate subtle behavioral differences introduced by the migration.

### 6. Verify Static Assets and Configuration Files

For web projects such as `GadgetsOnline`, confirm the following:

- `appsettings.json` is present and contains the correct configuration values previously held in `Web.config` or `App.config`.
- Static files (CSS, JavaScript, images) are located under the `wwwroot` folder.
- Connection strings and application settings have been correctly migrated.

### 7. Run the Application Locally

Start the application and manually verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the primary workflows of the application to confirm pages load correctly, database connectivity is functional, and no runtime exceptions occur.

### 8. Review Middleware and HTTP Pipeline

If this is an ASP.NET Core project, review `Program.cs` or `Startup.cs` to ensure the middleware pipeline is correctly configured, including:

- Authentication and authorization middleware
- Session and cookie configuration
- Error handling middleware
- Any custom HTTP modules or handlers that were previously in `Web.config` and may need to be re-implemented as middleware

### 9. Validate Database Connectivity

If the application uses Entity Framework or another data access layer, run any pending migrations and confirm the schema is correct:

```bash
dotnet ef database update
```

Test all primary data access operations to ensure queries execute as expected.

### 10. Deployment

Once local validation is complete, publish the application targeting your intended runtime:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` folder to your hosting environment and confirm the application starts and operates correctly there as well.