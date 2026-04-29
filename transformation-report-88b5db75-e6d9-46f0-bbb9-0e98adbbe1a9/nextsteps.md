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

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Cross-platform .NET does not support certain APIs that were available in .NET Framework. Run the .NET Upgrade Assistant compatibility analyzer or the Platform Compatibility Analyzer to identify any runtime-level issues that would not surface as build errors:

```bash
dotnet add package Microsoft.DotNet.PlatformAbstractions
```

Additionally, review any usages of the following commonly incompatible areas:
- `System.Web` (not available in cross-platform .NET; replaced by `Microsoft.AspNetCore.*`)
- `HttpContext` and related types (ensure they come from `Microsoft.AspNetCore.Http`)
- Windows Registry access or Windows-specific APIs if cross-platform support is required

### 5. Run Unit Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test --configuration Release
```

Review the test output for any failures that may indicate behavioral differences between .NET Framework and the new target framework.

### 6. Verify Application Startup

Run the application locally and confirm it starts without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Check the console output for any startup errors, particularly around:
- Middleware configuration
- Dependency injection registration
- Database connection strings and Entity Framework migrations

### 7. Validate Configuration Files

Confirm that `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) are present and contain the correct configuration values. In cross-platform .NET, `Web.config` is no longer the primary configuration source.

If the original project used `Web.config` for connection strings or app settings, verify those values have been migrated to `appsettings.json`.

### 8. Check Static Files and wwwroot

If the project serves static files, confirm that they reside in the `wwwroot` folder and that the middleware is configured correctly in `Program.cs` or `Startup.cs`:

```csharp
app.UseStaticFiles();
```

### 9. Database Migrations (if applicable)

If the project uses Entity Framework, verify that existing migrations are compatible with the new version of EF Core. Run the following to apply migrations against your development database:

```bash
dotnet ef database update
```

If migrations need to be regenerated, consider creating a new initial migration after confirming the model is correct.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, assets, and dependencies are present before deploying to the target environment.