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

If the project is a web application, ensure it references `Microsoft.AspNetCore.App` or the appropriate metapackage.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm behavior matches the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` dependencies (not available in .NET Core/.NET 5+)
- `HttpContext` and related types if this is a web project
- Windows-specific APIs such as the registry, WCF, or `System.Drawing` (may require compatibility packages)
- Entity Framework — confirm whether the project has migrated from EF 6 to EF Core, and if so, review any LINQ queries or model configurations that may behave differently

### 7. Verify Static Files and Configuration

If this is an ASP.NET web application, confirm the following:

- `appsettings.json` contains the necessary configuration that was previously in `web.config`
- Static files (CSS, JS, images) are located under the `wwwroot` folder
- Middleware pipeline in `Program.cs` or `Startup.cs` is configured correctly, including routing, authentication, and error handling

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.