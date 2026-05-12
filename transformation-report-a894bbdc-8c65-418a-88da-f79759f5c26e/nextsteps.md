# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or unresolved dependencies that may not surface as hard build errors.

### 2. Build the Solution

Perform a full solution build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported, non-end-of-life version of .NET, such as `net8.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it to `net8.0` and re-running the restore and build steps.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences introduced by the migration even when no build errors exist.

### 5. Verify Runtime Behavior

Run the application locally and manually exercise its primary functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay specific attention to:
- Database connectivity and any Entity Framework migrations if applicable
- Any areas of the code that previously relied on Windows-specific APIs (e.g., `System.Web`, registry access, Windows authentication)
- File path handling, which can behave differently on Linux and macOS due to case sensitivity

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs may have changed behavior in cross-platform .NET. Review the following areas manually:

- **Configuration**: Ensure `web.config` or `app.config` settings have been migrated to `appsettings.json` and are being read correctly via `IConfiguration`.
- **Session and Authentication**: If the project uses ASP.NET session state or forms authentication, verify these have been replaced with their ASP.NET Core equivalents.
- **Static Files**: Confirm that static file serving is configured correctly in `Program.cs` or `Startup.cs`.
- **HTTP Handlers and Modules**: These do not exist in ASP.NET Core. Verify they have been replaced with middleware.

### 7. Inspect Package References for Compatibility

Check `GadgetsOnline/GadgetsOnline.csproj` for any remaining references to packages that are known to be Windows-only or incompatible with cross-platform .NET:

```bash
dotnet list package --deprecated
dotnet list package --vulnerable
```

Replace or update any flagged packages as needed.

### 8. Test on Target Platform

If the goal is to run this application on Linux or macOS, validate the application on that operating system explicitly. Issues such as case-sensitive file paths, platform-specific dependencies, or missing native libraries will only surface in that environment.

### 9. Publish the Application

Once validation is complete, publish the application for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files, assets, and dependencies are present.