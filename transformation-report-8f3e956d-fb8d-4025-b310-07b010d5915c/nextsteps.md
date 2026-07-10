# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without any reported issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate deprecated APIs or compatibility concerns that should be addressed.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it still references a Windows-specific TFM such as `net48` or `net472`, update it accordingly.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to verify that runtime behavior matches the pre-migration state.

### 5. Execute Existing Tests

If the solution contains a test project, run the test suite to catch any runtime regressions:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by migration-related changes or pre-existing issues.

### 6. Check for Windows-Specific API Usage

Even without build errors, the code may reference APIs that only function correctly on Windows (e.g., `System.Drawing`, `Microsoft.Win32`, or certain `System.Security` namespaces). Use the .NET Upgrade Assistant compatibility analyzer or the following command to surface platform-specific warnings:

```bash
dotnet build /p:EnableNETAnalyzers=true /p:AnalysisMode=All
```

Address any `CA1416` platform compatibility warnings that appear.

### 7. Verify Configuration and Middleware

If this is an ASP.NET Core web application, confirm the following:

- `Program.cs` or `Startup.cs` uses the modern minimal hosting model or the standard `WebApplication.CreateBuilder` pattern.
- Any `web.config` settings that were previously relied upon have been migrated to `appsettings.json` or environment variables.
- Static files, routing, and authentication middleware are correctly configured.

### 8. Database and Data Access

If the project uses Entity Framework, run the following to verify the model and database are in sync:

```bash
dotnet ef migrations list
dotnet ef database update
```

Confirm that connection strings in `appsettings.json` are correct for the target environment.

### 9. Deployment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to the target server and ensure the correct .NET runtime version is installed on that server. You can verify the runtime availability with:

```bash
dotnet --list-runtimes
```