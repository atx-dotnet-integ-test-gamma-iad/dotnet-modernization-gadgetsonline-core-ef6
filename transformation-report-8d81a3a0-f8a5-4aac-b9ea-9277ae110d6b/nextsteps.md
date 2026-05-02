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

Review the output for any warnings about deprecated packages or version conflicts that may need to be addressed.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing a Windows-specific framework such as `net48`, the migration to cross-platform .NET is not yet complete.

### 4. Run Unit Tests

If the solution contains test projects, execute the test suite to verify runtime behavior has not regressed:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences introduced by the framework change.

### 5. Check for Windows-Specific APIs

Even with a successful build, the code may still reference Windows-specific APIs that will fail at runtime on non-Windows platforms. Use the .NET compatibility analyzer to surface these issues:

```bash
dotnet build /p:PlatformTarget=AnyCPU
```

Additionally, review the code for usages of:
- `System.Windows.Forms`
- `System.Drawing` (without the `System.Drawing.Common` NuGet package)
- `Microsoft.Win32` registry APIs
- `System.Runtime.InteropServices` P/Invoke calls targeting Windows DLLs

### 6. Run the Application

Start the application and exercise its core functionality manually:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Verify that all major features behave as expected and that no runtime exceptions are thrown.

### 7. Review Configuration Files

Check that configuration files such as `appsettings.json` (or `web.config` if it was carried over) are correctly structured for the new hosting model. In cross-platform .NET, `web.config` is not used for application configuration and should be replaced with `appsettings.json` where applicable.

### 8. Validate Database Connectivity

If the project uses a database, confirm that connection strings are correctly configured in `appsettings.json` and that the data access layer functions correctly at runtime.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required assets, static files, and dependencies are present.

### 10. Test on Target Platform

If cross-platform support is a goal, run the published output on the intended target operating system (e.g., Linux or macOS) to confirm there are no platform-specific runtime issues that were not caught during the build phase.