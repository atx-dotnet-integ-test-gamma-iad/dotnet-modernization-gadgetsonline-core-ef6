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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing a Windows-only framework such as `net48`, update it accordingly.

### 4. Check for Windows-Specific Dependencies

Search the project for any remaining references to Windows-specific APIs or libraries, such as:

- `System.Web`
- `Microsoft.Web.*`
- Any COM interop or P/Invoke calls targeting Windows-only system libraries

These will not cause build errors immediately in all cases but may cause runtime failures on non-Windows platforms.

### 5. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows and verify that core functionality behaves as expected.

### 6. Execute Existing Tests

If the solution contains a test project, run the test suite to validate correctness:

```bash
dotnet test
```

Review any failing tests and address them before proceeding to deployment.

### 7. Review Configuration Files

Check `appsettings.json` (and environment-specific variants such as `appsettings.Production.json`) for any configuration values that were previously stored in `Web.config` or `App.config`. Ensure connection strings, API keys, and environment-specific settings have been correctly migrated.

### 8. Verify Static Files and Middleware

If this is a web application, confirm that static file serving, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Legacy `HttpModules` and `HttpHandlers` from `System.Web` must be replaced with the equivalent ASP.NET Core middleware.

### 9. Test on Target Platform

If cross-platform support is a goal, run and test the application on the target operating system (Linux or macOS) to surface any remaining platform-specific issues that would not appear during a Windows build.

## Deployment

### 1. Publish the Application

Use the following command to publish a self-contained or framework-dependent release build:

```bash
# Framework-dependent
dotnet publish --configuration Release --output ./publish

# Self-contained (example for Linux x64)
dotnet publish --configuration Release --runtime linux-x64 --self-contained true --output ./publish
```

### 2. Verify the Publish Output

Inspect the `./publish` directory to confirm all expected files are present, including configuration files and static assets.

### 3. Run the Published Output

Test the published output directly before deploying to a server:

```bash
dotnet ./publish/GadgetsOnline.dll
```

Confirm the application starts and responds correctly before moving it to the target environment.