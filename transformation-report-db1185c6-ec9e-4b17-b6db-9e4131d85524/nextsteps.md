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

Review the output for any warnings about missing or incompatible packages. If any packages are flagged as incompatible with the new target framework, locate them in the relevant `.csproj` file and search [NuGet.org](https://www.nuget.org) for a compatible version.

### 2. Build the Solution

Perform a full build to confirm the solution compiles cleanly:

```bash
dotnet build --configuration Release
```

Confirm that the output shows zero errors and review any warnings, as some warnings may indicate deprecated APIs or compatibility concerns that could cause runtime issues.

### 3. Run the Application Locally

Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality manually, paying attention to:
- Application startup and middleware initialization
- Database connectivity (if applicable)
- Any pages or endpoints that rely on platform-specific behavior previously tied to the Windows/.NET Framework environment

### 4. Check for Runtime Compatibility Issues

Even with a clean build, certain areas commonly introduce runtime issues after migration. Review the following:

- **Data Access**: If Entity Framework is used, confirm the correct EF Core provider is configured and that migrations are up to date by running:
  ```bash
  dotnet ef migrations list
  dotnet ef database update
  ```
- **Authentication & Session**: Verify that any authentication middleware (e.g., cookies, identity) is correctly configured for ASP.NET Core conventions.
- **Configuration**: Confirm that `Web.config` settings have been properly migrated to `appsettings.json` and that environment-specific values are accessible via `IConfiguration`.
- **Static Files**: Ensure static assets are being served correctly and are located under the `wwwroot` directory.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate existing behavior:

```bash
dotnet test
```

Review any failing tests to determine whether failures are caused by migration-related changes or pre-existing issues.

### 6. Review Removed or Changed APIs

Cross-reference the codebase against the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the [.NET API compatibility documentation](https://learn.microsoft.com/en-us/dotnet/core/compatibility/) to identify any APIs that were available in .NET Framework but have changed behavior or been removed in modern .NET.

### 7. Target Framework Verification

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If a newer Long-Term Support (LTS) version of .NET is available and desired, update this value, then re-run restore and build steps.

### 8. Publishing the Application

Once validation is complete, publish the application to confirm the output is production-ready:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and verify all expected files, assemblies, and static assets are present before deploying to the target environment.