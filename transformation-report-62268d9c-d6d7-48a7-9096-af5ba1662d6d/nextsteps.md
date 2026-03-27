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

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that surface, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or `net6.0` and not a legacy `netcoreapp` moniker.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, paying attention to any runtime exceptions that would not surface at build time.

### 5. Check for Removed or Changed APIs

Review the code for usage of any APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references (not available in .NET Core/.NET 5+)
- `HttpContext` and related types (replaced by `Microsoft.AspNetCore.Http`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows-specific APIs such as the registry or certain I/O operations

### 6. Validate Configuration Files

Ensure that `appsettings.json` (or equivalent) is correctly set up to replace any legacy `Web.config` or `App.config` entries. Confirm connection strings, application settings, and environment-specific values are present and correct.

### 7. Run Existing Tests

If the solution contains a test project, execute the tests to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a functional regression or a test that requires updating due to API changes.

### 8. Verify Static Files and Views

If this is a web application, verify that static files (CSS, JavaScript, images) are being served correctly and that all views render without errors. Check that the `wwwroot` folder is structured correctly and that middleware for static files is configured in `Program.cs` or `Startup.cs`.

### 9. Review Middleware and Startup Configuration

Confirm that the request pipeline in `Program.cs` or `Startup.cs` is configured correctly, including:

- Authentication and authorization middleware
- Routing configuration
- Any custom middleware that was migrated from HTTP modules or handlers

### 10. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present before deploying to the target environment.