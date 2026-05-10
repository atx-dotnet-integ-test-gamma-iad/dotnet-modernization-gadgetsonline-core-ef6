# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or framework-specific code paths.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, verify it targets `net8.0` or the appropriate version and that `Microsoft.AspNetCore` packages are referenced correctly.

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have been removed or altered in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET types, which have changed namespaces
- `ConfigurationManager`, which requires the `System.Configuration.ConfigurationManager` NuGet package
- `AppDomain` members that are no longer supported

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary functionality to verify runtime behavior matches the original.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to behavioral differences in the new framework or pre-existing issues.

### 7. Review Configuration Files

- Confirm that `appsettings.json` (or `appsettings.Development.json`) contains all configuration values that were previously held in `Web.config` or `App.config`.
- Verify connection strings, application settings, and any environment-specific values have been migrated correctly.

### 8. Verify Static Files and wwwroot

If this is a web application, confirm that static assets (CSS, JavaScript, images) are located under the `wwwroot` folder, as this is the expected convention in cross-platform ASP.NET Core projects.

### 9. Check Database Connectivity

If the application uses a database, verify that:

- The connection string in `appsettings.json` is correct.
- Entity Framework Core migrations (if applicable) are up to date by running:

```bash
dotnet ef database update
```

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.