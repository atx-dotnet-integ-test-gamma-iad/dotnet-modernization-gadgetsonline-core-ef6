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

Address any warnings that surface during this step, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the correct SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that existed in .NET Framework but have been removed or altered in cross-platform .NET. Common areas to inspect include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages that may need to be updated to ASP.NET Core equivalents
- `ConfigurationManager` usage, which should be replaced with `Microsoft.Extensions.Configuration`
- Any Windows-specific APIs such as the registry or certain `System.Drawing` features

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and verify that core functionality, routing, and data access behave as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review any failing tests to determine whether they reflect genuine regressions or test code that itself requires updating for the new framework.

### 7. Verify Database Connectivity and Migrations

If the project uses Entity Framework, confirm the connection strings in `appsettings.json` are correct and run the following to verify the database context is functioning:

```bash
dotnet ef database update
```

Ensure that `appsettings.json` is present and properly configured, as `web.config`-based configuration is not used in cross-platform .NET.

### 8. Review Static Files and wwwroot

Confirm that static assets such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, as this is required by ASP.NET Core's static file middleware.

### 9. Inspect Middleware and Startup Configuration

If the project was migrated from an older ASP.NET MVC application, verify that `Program.cs` and any `Startup.cs` file correctly configure services and middleware, including authentication, routing, and session handling if applicable.