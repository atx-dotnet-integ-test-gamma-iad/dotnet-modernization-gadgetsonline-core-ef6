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

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Incompatible APIs

Even without build errors, some APIs that existed in .NET Framework may behave differently or have been replaced in cross-platform .NET. Review the code for usage of the following common problem areas:

- `System.Web` namespace references (not available in cross-platform .NET)
- `HttpContext` usage outside of the ASP.NET Core request pipeline
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `Session` and `FormsAuthentication` (require ASP.NET Core equivalents)

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally running application and manually verify that core functionality, routing, and data access behave as expected.

### 6. Run Existing Tests

If the solution contains test projects, execute them to confirm no regressions were introduced:

```bash
dotnet test
```

Review the test results and investigate any failures.

### 7. Review Configuration Files

Ensure that `appsettings.json` (or `appsettings.Development.json`) contains the necessary configuration values that were previously held in `Web.config` or `App.config`. Connection strings, application settings, and environment-specific values should all be accounted for.

### 8. Verify Database Connectivity

If the application uses a database, confirm that the connection string is correct and that the application can successfully connect and perform queries in the new environment.

### 9. Check Static Files and wwwroot

For web applications, confirm that static assets such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, as this is required by ASP.NET Core's static file middleware.

### 10. Review Middleware and Startup Configuration

If the project uses ASP.NET Core, review `Program.cs` (and `Startup.cs` if present) to ensure middleware is registered in the correct order and that all required services are added to the dependency injection container.