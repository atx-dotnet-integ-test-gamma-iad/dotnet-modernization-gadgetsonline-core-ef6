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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate and supported version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older or end-of-life version such as `net5.0` or `net6.0`, consider updating it to the latest Long Term Support (LTS) release.

### 4. Run the Application Locally

Start the application and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm expected behavior.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test output for any failures or skipped tests that may indicate compatibility issues introduced during the migration.

### 6. Check for Removed or Replaced APIs

Some APIs available in .NET Framework are not present or have changed in cross-platform .NET. Review the following areas manually:

- Any usage of `System.Web` namespaces, which are not available in cross-platform .NET and may have been replaced by `Microsoft.AspNetCore` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages to confirm they reference the ASP.NET Core versions.
- Any Windows-specific APIs such as the registry, `System.Drawing`, or WCF server-side components, which may require alternative packages or implementations.

### 7. Verify Static Files, Views, and Configuration

- Confirm that `wwwroot` contains all necessary static assets.
- Verify that Razor views (`.cshtml` files) render correctly at runtime.
- Check that `appsettings.json` contains all configuration values that were previously in `web.config` or `app.config`.

### 8. Validate Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` are correct and that the application can connect and perform operations as expected.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present.

### 10. Deploy to Target Environment

Copy the published output to the target server or hosting environment. Ensure the target machine has the appropriate .NET runtime installed:

```bash
dotnet --list-runtimes
```

The required runtime version should appear in the list. If it is not present, download and install it from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download).