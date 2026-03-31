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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or target framework compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.AspNetCore.App` or the appropriate metapackage.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows to identify any runtime errors that would not surface at compile time.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality is intact:

```bash
dotnet test
```

Review the test results and investigate any failures, as they may indicate behavioral differences introduced by the migration.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage patterns
- Configuration APIs (`System.Configuration.ConfigurationManager` requires the `System.Configuration.ConfigurationManager` NuGet package)
- Any Windows-specific APIs such as the registry or certain cryptography providers

### 7. Review Static Files and wwwroot

If this is a web project, confirm that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder, which is the expected convention in ASP.NET Core.

### 8. Validate Database Connectivity

If the application uses a database, verify that the connection strings in `appsettings.json` are correctly configured and that the application can connect to the database at runtime.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the contents of the `./publish` directory to ensure all required files are present, then deploy the published output to the target environment.