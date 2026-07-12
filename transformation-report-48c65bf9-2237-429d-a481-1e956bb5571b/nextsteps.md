# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or deprecated APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended .NET version (e.g., `net8.0`). Ensure any dependencies and NuGet packages are compatible with that target framework.

### 4. Check for Removed or Changed APIs

Review the codebase for usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references (not available in .NET Core/.NET 5+)
- `HttpContext` and related ASP.NET types if this is a web project
- Windows-specific APIs such as the registry, WCF, or Windows Forms (if applicable)
- `ConfigurationManager` — replaced by `Microsoft.Extensions.Configuration`

### 5. Run the Application Locally

Start the application locally and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the core functionality of the application and confirm expected behavior is preserved.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior has not regressed:

```bash
dotnet test
```

Review any failing tests carefully, as failures may point to behavioral differences between .NET Framework and cross-platform .NET.

### 7. Review Static Files and Configuration

If this is a web application, verify the following:

- `appsettings.json` contains all configuration values previously held in `Web.config` or `App.config`
- Static files (CSS, JavaScript, images) are served correctly
- Connection strings and environment-specific settings are correctly configured

### 8. Validate Database Connectivity

If the application uses a database, confirm that:

- The connection string in `appsettings.json` is correct
- Entity Framework migrations (if applicable) are up to date by running:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.