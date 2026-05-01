# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or incompatible target frameworks.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is targeting an older version such as `net6.0` or `net7.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run Unit Tests

If the solution contains test projects, execute the test suite to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results for any failures that may indicate behavioral differences introduced by the migration.

### 5. Run the Application Locally

Start the application locally to confirm it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application's key functionality and verify that pages load, data is retrieved correctly, and no runtime exceptions occur.

### 6. Review Removed or Changed APIs

Check the codebase for any usage of APIs that were available in .NET Framework but have changed behavior in cross-platform .NET. Pay particular attention to:

- `System.Web` references, which are not available in cross-platform .NET and should have been replaced with ASP.NET Core equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages to confirm they reference `Microsoft.AspNetCore.Http` types.
- Any Windows-specific APIs such as the registry, WMI, or Windows identity APIs that may compile but fail at runtime on non-Windows platforms.

### 7. Review Configuration Files

Confirm that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable. Connection strings, application settings, and environment-specific values should be present and correct.

### 8. Verify Database Connectivity

If the application uses a database, confirm that connection strings in `appsettings.json` are correct and that the application can connect and perform queries successfully during local testing.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and dependencies are present.

### 10. Deploy to Target Environment

Copy the published output to the target server or hosting environment. Ensure the target machine has the appropriate .NET runtime installed. You can verify the required runtime version with:

```bash
dotnet --info
```

Confirm the application starts and responds correctly in the target environment before directing production traffic to it.