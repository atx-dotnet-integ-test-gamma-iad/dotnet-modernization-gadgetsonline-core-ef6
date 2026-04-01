# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or deprecated APIs, as these can indicate latent issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your organization's supported .NET version.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm runtime behavior matches the legacy version. Pay particular attention to:

- Database connectivity and any Entity Framework migrations
- Authentication and session handling
- Any file system operations that may have path sensitivity differences on Linux/macOS

### 5. Check for Windows-Specific Dependencies

Review the codebase for any remaining usage of Windows-specific APIs or libraries, such as:

- `Microsoft.Web.Infrastructure`
- `System.Web` namespaces
- Windows Registry access
- COM interop

These will not function correctly on non-Windows platforms and will need to be replaced with cross-platform equivalents.

### 6. Execute Existing Tests

If a test project exists in the solution, run the test suite to verify functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 7. Review Static Files and wwwroot

If this is a web application, confirm that static assets (CSS, JavaScript, images) have been moved to the `wwwroot` folder as expected by ASP.NET Core's static file middleware.

### 8. Validate Configuration

Confirm that `web.config` settings have been appropriately migrated to `appsettings.json` or `appsettings.{Environment}.json`. Check that connection strings, application settings, and any custom configuration sections are present and correctly formatted.

### 9. Publish the Application

Once local validation is complete, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and perform a final smoke test by running the published output against a staging environment before promoting to production.