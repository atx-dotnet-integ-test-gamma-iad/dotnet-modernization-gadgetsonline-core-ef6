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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary functionality to confirm runtime behavior is correct.

### 5. Execute Unit Tests

If the solution contains test projects, run them to validate that existing logic has not been broken during the transformation:

```bash
dotnet test
```

Review test results and address any failing tests before proceeding.

### 6. Review Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Manually review the code for usage of the following common problem areas:

- `System.Web` namespace references (not available in .NET Core/5+)
- `HttpContext` usage outside of ASP.NET Core's dependency injection pattern
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `System.Drawing` (requires additional packages on non-Windows platforms)
- Windows Registry access (`Microsoft.Win32.Registry`)

### 7. Check Database Connectivity

If the application uses a database, verify that the connection strings in `appsettings.json` are correctly configured and that the appropriate EF Core or ADO.NET provider packages are referenced. Run any pending migrations if Entity Framework Core is in use:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 8. Validate Static Files and Configuration

Confirm that `wwwroot` contains the expected static assets and that `appsettings.json` (and `appsettings.Production.json` if applicable) contains all configuration values previously held in `Web.config` or `App.config`.

### 9. Test on Target Platform

If the goal is cross-platform execution, run the application on the target operating system (Linux or macOS) to surface any platform-specific runtime issues that would not appear on Windows.

### 10. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all required files are present, then deploy the published output to the target environment.