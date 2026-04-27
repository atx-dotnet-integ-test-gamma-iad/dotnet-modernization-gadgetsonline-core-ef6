# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Verify Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to a supported cross-platform .NET version (e.g., `net6.0`, `net7.0`, or `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 2. Restore NuGet Packages

Run the following command from the solution root to ensure all dependencies are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings about deprecated or unlisted packages that may need updating.

### 3. Build the Solution

Perform a full build to confirm there are no issues:

```bash
dotnet build --configuration Release
```

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test output and address any failing tests before proceeding.

### 5. Run the Application Locally

Start the application and verify it runs as expected on the target platform:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application's key workflows to confirm runtime behavior is correct.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` dependencies (these are not available in cross-platform .NET)
- `HttpContext` and related ASP.NET types (ensure you are using the `Microsoft.AspNetCore` equivalents)
- Windows-specific APIs such as the registry, WMI, or Windows identity APIs
- `ConfigurationManager` (replace with `Microsoft.Extensions.Configuration`)

### 7. Review Configuration Files

Ensure that `web.config` or `app.config` settings have been migrated to `appsettings.json` or `appsettings.{Environment}.json` where applicable. Verify that connection strings, application settings, and environment-specific values are correctly represented.

### 8. Validate Database Connectivity

If the project uses a database, confirm that connection strings are correct and that the application can successfully connect and perform operations against the database in the new environment.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present.

### 10. Deploy to Target Environment

Copy the published output to the target server or hosting environment. Ensure the correct .NET runtime version is installed on the target machine. You can verify this with:

```bash
dotnet --list-runtimes
```

Start the application in the target environment and perform a final round of validation against the deployed instance.