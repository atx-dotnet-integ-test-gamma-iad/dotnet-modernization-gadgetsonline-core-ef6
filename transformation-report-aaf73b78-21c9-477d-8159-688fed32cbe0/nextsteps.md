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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types, deprecated APIs, or target framework compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application manually and verify that core functionality behaves as expected compared to the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them with:

```bash
dotnet test
```

Review the results and investigate any failing tests. Failures at this stage may indicate behavioral differences introduced during the migration that do not surface as build errors.

### 6. Check for Removed or Changed APIs

Review the code for usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` dependencies, which are not available in cross-platform .NET
- `HttpContext` and related types if this is a web project
- Windows-specific APIs such as the registry, `System.Drawing`, or WCF server-side components
- `ConfigurationManager` usage, which may need to be replaced with `Microsoft.Extensions.Configuration`

### 7. Validate Configuration Files

Ensure that `appsettings.json` (or equivalent) is correctly structured and that any settings previously held in `Web.config` or `App.config` have been migrated appropriately. Confirm that connection strings, application settings, and environment-specific values are all accounted for.

### 8. Test Data Access

If the project uses Entity Framework or another data access layer, verify that:

- Migrations are up to date by running `dotnet ef migrations list`
- The database can be reached and queries execute correctly against the target database

### 9. Review Static Files and Bundling

If this is a web project, confirm that static assets such as CSS, JavaScript, and images are served correctly. Bundling and minification behavior may differ from the legacy `System.Web.Optimization` approach and may require configuration adjustments.

### 10. Check Logging and Error Handling

Verify that logging is configured correctly using `Microsoft.Extensions.Logging` or your chosen logging provider, and that unhandled exceptions are surfaced appropriately in both development and production configurations.