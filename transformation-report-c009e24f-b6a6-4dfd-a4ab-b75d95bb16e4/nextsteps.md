# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution. The `GadgetsOnline/GadgetsOnline.csproj` project produced no errors during the build process.

## Validation Steps

### 1. Restore NuGet Packages

Before running the project, ensure all NuGet packages are properly restored.

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages that may not have surfaced as hard build errors.

### 2. Build the Solution

Perform a full build to confirm the clean state is consistent across configurations.

```bash
dotnet build --configuration Release
```

Confirm that the output shows zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as `net8.0`.

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is set to `net6.0` or `net7.0`, consider upgrading to `net8.0` as those versions are no longer in long-term support.

### 4. Check for Removed or Changed APIs

Run the .NET Upgrade Assistant compatibility analyzer or the `ApiCompat` tool to identify any runtime-level API usage that may not produce build errors but could fail at runtime.

```bash
dotnet tool install -g dotnet-apicompat
```

Pay particular attention to:
- Any usage of `System.Web` namespaces, which are not available on cross-platform .NET
- Windows-specific APIs that may compile but throw `PlatformNotSupportedException` at runtime

### 5. Run the Application Locally

Start the application using the .NET CLI and verify it launches without runtime exceptions.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the core functionality of the application and confirm that pages load and features behave as expected.

### 6. Review Configuration Files

Check that `appsettings.json` (and `appsettings.Development.json`) contain all configuration values that were previously held in `Web.config` or `App.config`. Common items to verify include:

- Database connection strings
- Application-specific settings
- Logging configuration

### 7. Verify Database Connectivity

If the application uses Entity Framework or direct database access, confirm the connection string is correct and that the database is reachable from the new runtime environment. Run any pending migrations if applicable.

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 8. Execute Existing Tests

If the solution contains test projects, run all tests to confirm that behavior has not regressed.

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences introduced by the migration to cross-platform .NET.

### 9. Deployment

Once local validation is complete, publish the application to confirm the output is correct.

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and configuration files are present before deploying to the target environment.