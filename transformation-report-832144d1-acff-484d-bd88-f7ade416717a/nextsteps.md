# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas that may cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended .NET version (e.g., `net8.0`). Ensure it is not still referencing a legacy `net48` or similar framework moniker.

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have been removed or altered in cross-platform .NET. Common areas to check include:

- `System.Web` references (not available in .NET Core/.NET 5+)
- `HttpContext` and related ASP.NET types (should now use `Microsoft.AspNetCore.*`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows-specific APIs such as the registry or WCF server-side components

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as expected. Pay close attention to:

- Database connectivity and Entity Framework migrations if applicable
- Authentication and session handling
- Static file serving
- Any third-party integrations

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that business logic has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they are failing due to migration-related changes or pre-existing issues.

### 7. Review `appsettings.json` and Configuration

If the project previously used `Web.config` or `App.config`, confirm that all configuration values have been correctly migrated to `appsettings.json` or environment-specific configuration files. Verify connection strings, application settings, and any custom configuration sections.

### 8. Validate Static Assets and Views

If this is a web application, manually verify that:

- Razor views render correctly
- Static assets (CSS, JavaScript, images) are being served
- Routing behaves as expected

### 9. Deployment

Once the above steps are completed and the application is functioning correctly:

1. Publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

2. Review the contents of the `./publish` directory to ensure all necessary files are present.
3. Deploy the published output to the target hosting environment, ensuring the correct .NET runtime version is installed on the host.