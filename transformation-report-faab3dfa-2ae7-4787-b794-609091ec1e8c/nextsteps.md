# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution. The `GadgetsOnline/GadgetsOnline.csproj` project produced no errors during the build process.

## Validation Steps

### 1. Restore NuGet Packages

Before running the project, ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing or incompatible packages. Pay attention to any packages that may have been replaced with compatibility shims during the transformation, as these may need to be updated to their cross-platform equivalents.

### 2. Build the Solution

Perform a full build of the solution to confirm there are no errors:

```bash
dotnet build --configuration Release
```

Review any warnings in the build output, as some warnings may indicate deprecated APIs or patterns that could cause runtime issues even if the build succeeds.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework moniker (TFM) is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, verify it uses the appropriate TFM such as `net8.0` rather than a Windows-specific one like `net8.0-windows`, unless Windows-specific APIs are intentionally required.

### 4. Check for Windows-Specific Dependencies

Search the project for any remaining references to Windows-specific APIs or libraries, such as:

- `System.Web` (not available in .NET Core/.NET 5+)
- `Microsoft.Web.*` legacy packages
- Windows Registry access
- Windows-only file path assumptions

Run a search across the solution for these namespaces:

```bash
grep -r "System.Web" --include="*.cs"
```

### 5. Run the Application Locally

Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality and check the console output for any unhandled exceptions or runtime errors.

### 6. Execute Existing Tests

If the solution contains a test project, run all tests to validate core functionality:

```bash
dotnet test
```

Review any failing tests, as they may indicate behavioral differences between the legacy .NET Framework and the new cross-platform .NET runtime.

### 7. Review Configuration Files

Confirm that configuration has been properly migrated:

- `web.config` or `app.config` settings should be moved to `appsettings.json` if not already done.
- Connection strings should be verified against the new configuration system.
- Any `<system.web>` or `<system.webServer>` sections in `web.config` are not used in ASP.NET Core and should be reviewed.

### 8. Verify Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` are correct and that the application can connect successfully at runtime. If Entity Framework is used, verify migrations are up to date:

```bash
dotnet ef database update
```

### 9. Test on Target Platforms

Since the goal is cross-platform support, test the application on each intended operating system (Windows, Linux, macOS) to identify any platform-specific runtime issues that would not appear during a build.

### 10. Review Middleware and Startup Configuration

If this is an ASP.NET Core application, review `Program.cs` (and `Startup.cs` if present) to ensure middleware is registered in the correct order and that all required services are configured, particularly if the transformation automated the conversion from the legacy `Global.asax` or `Startup` patterns.